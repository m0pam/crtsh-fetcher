# Crtsh-Fetcher
Fetches domains from https://crt.sh/


![Menu][tool-menu]


#### How does it work?
An HTTP query is sent via curl to crt.sh with the requested domain, JSON is specified for the response format, from there it is parsed with [jq](https://github.com/stedolan/jq) to extract two fields: *common_name* and *name_value*, then sorting is carried out and duplicates removed.


### Installation & Usage
1. Clone and make the script executable
   ```sh
   git clone https://github.com/m0pam/crtsh-fetcher && cd crtsh-fetcher && chmod +x crtsh-fetcher.sh
   ```
2. Execute
   ```sh
   ./crtsh-fetcher.sh
   ```
### Menu with examples
```sh
Flags:
-d｜--domain <domain.com>         # stout to terminal                  [MANDATORY] 
-o｜--output <output.txt>         # stout to specified file            [OPTIONAL]  
-w｜--wildcardsonly               # only print domains with wildcards  [OPTIONAL]  

Examples:
./crtsh-fetcher.sh --domain bugcrowd.com --output out.txt
./crtsh-fetcher.sh -d bugcrowd.com -w
```

-------------------------------------------------------
#### Why yet another crt.sh fetching script ?!
There are 999 scripts to fetch domains from crt.sh, but from my recent research, they all seem broken or don't fetch *all* domains listed.
Even amass or subfinder failed to fetch domains *clearly* visible after a basic crt.sh query.







[tool-menu]: images/menu.png


