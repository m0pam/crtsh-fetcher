#!/bin/bash

set -e -o pipefail # set -e: if program fails it will exit

#variables
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CLEAR='\033[0m' # No Color
# banner generated with https://manytools.org/hacker-tools/ascii-banner
BANNER='
 ██████╗██████╗ ████████╗███████╗██╗  ██╗    ███████╗███████╗████████╗ ██████╗██╗  ██╗███████╗██████╗ 
██╔════╝██╔══██╗╚══██╔══╝██╔════╝██║  ██║    ██╔════╝██╔════╝╚══██╔══╝██╔════╝██║  ██║██╔════╝██╔══██╗
██║     ██████╔╝   ██║   ███████╗███████║    █████╗  █████╗     ██║   ██║     ███████║█████╗  ██████╔╝
██║     ██╔══██╗   ██║   ╚════██║██╔══██║    ██╔══╝  ██╔══╝     ██║   ██║     ██╔══██║██╔══╝  ██╔══██╗
╚██████╗██║  ██║   ██║██╗███████║██║  ██║    ██║     ███████╗   ██║   ╚██████╗██║  ██║███████╗██║  ██║
 ╚═════╝╚═╝  ╚═╝   ╚═╝╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝   ╚═╝    ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
Fetch \e[3mALL\e[0m CRT.SH domains		By \e]8;;https://twitter.com/m0pam/\e\\@m0pam\e]8;;\e\\ with <3\n'

#menu
if [ $# -eq 0 ] || [ $1 == "-h" ] || [ $1 == "--h" ] || [ $1 == "-help" ] || [ $1 == "--help" ]; then
    printf "${BANNER}"
    printf "\n${YELLOW}Flags:${CLEAR}\n" 
    printf "${RED}-d\uff5c--domain${CLEAR} ${BLUE}<domain.com>${CLEAR}	  # stout to terminal                  [MANDATORY] \n"
    printf "${RED}-o\uff5c--output${CLEAR} ${BLUE}<output.txt>${CLEAR}	  # stout to specified file            [OPTIONAL]  \n"
    printf "${RED}-w\uff5c--wildcardsonly${CLEAR}	          # only print domains with wildcards  [OPTIONAL]  \n"
    printf "\n${YELLOW}Examples:${CLEAR}\n" 
    printf "$0 ${RED}--domain${CLEAR} ${BLUE}gugol.xyz${CLEAR} ${RED}--output${CLEAR} ${BLUE}out.txt${CLEAR}\n"
    printf "$0 ${RED}-d${CLEAR} ${BLUE}gugol.xyz${CLEAR} ${RED}-w${CLEAR}\n"
    exit 1
fi





# REAL SCRIPT STARTS HERE ⇩ ⇩ ⇩
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--domain) domain="$2"; shift ;;
        -o|--output) output="$2"; shift ;;
        -w|--wildcard) wildcard=1 ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done


if [[ ! $domain =~ "." ]] || [[ -z $domain ]]; then # $domain is empty or doesn't contain a dot, exit.
    printf "\nYou haven't entered a DOMAIN. Exiting.\n"
    exit 1
elif [ -z $output ]; then #no output file specified, print to terminal
    if [[ $wildcard -eq 1 ]]; then
        curl -s "https://crt.sh/?q="$domain"&output=json" | jq -r '.[].common_name,.[].name_value' | grep \*\. | sort -u # grep for domains with wildcard
    else
        curl -s "https://crt.sh/?q="$domain"&output=json" | jq -r '.[].common_name,.[].name_value' | sed 's/\*\.//g' | sort -u # grep for domains NO wildcard
    fi
else
    if [[ $wildcard -eq 1 ]]; then
        curl -s "https://crt.sh/?q="$domain"&output=json" | jq -r '.[].common_name,.[].name_value' | grep \*\. | sort -u > $output # grep for domains with wildcard + save output to file
    else
        curl -s "https://crt.sh/?q="$domain"&output=json" | jq -r '.[].common_name,.[].name_value' | sed 's/\*\.//g' | sort -u > $output # no wildcard set + save to output file
    fi
fi
