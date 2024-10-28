#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"

tail -n -F "$LOG_FILE" | while read line; do
     0
    if [ $(stat -c %s /home/roman/site/logs.log) -gt 3000 ]; then
        lines=$(wc -l /home/roman/site/logs.log | awk '{print $1}')
        date=$(date)
        echo "[$date] lines: $lines" >> /home/roman/site/freed.log  
        echo "" > /home/roman/site/logs.log
    fi

    status=$(echo $line | awk '{print $9}')
    
    if [[ $status =~ 4[0-9]{2} ]]; then
    echo "$line" >> "/home/roman/site/logs4.log"
    fi

    if [[ $status =~ 5[0-9]{2} ]]; then
    echo "$line" >> "/home/roman/site/logs5.log"
    fi

    echo "$line" >> "/home/roman/site/logs.log"
done