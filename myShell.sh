#!/bin/bash

while true; do
    #Prompt
    echo -n "myshell> "
    read -r line

    #If user presses Ctrl+D or enters empty input
    [[ -z "$line" ]] && continue

    #Built in exit code
    if [[ "$line" == "exit" ]]; then
        exit 0
    fi

    #Processing for cd command
    if [[ "$line" == cd* ]]; then
        #Get the directory after "cd"
        dir="${line:3}"
        dir="${dir## }"   # trim leading spaces
        if [[ -z "$dir" ]]; then
            cd ~
        else
            cd "$dir" 2>/dev/null || echo "cd: no such directory"
        fi
        continue
    fi

   
    #Background Process stuff
    
    if [[ "$line" == *"&" ]]; then
        line="${line/&/}"   # remove "&"
        eval "$line" &
        continue
    fi

    
    #Piping commands
    
    if [[ "$line" == *"|"* ]]; then
        eval "$line"
        continue
    fi

    #Redirection 
    if [[ "$line" == *"<"* || "$line" == *">"* ]]; then
        eval "$line"
        continue
    fi

    
    #Default stuff
    
    eval "$line"

done
