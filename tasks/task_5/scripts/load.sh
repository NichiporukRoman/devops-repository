#!/bin/bash

date=$(date)
cpu=$(top -n1 | grep "Cpu(s)")

while true; do 
    date=$(date | awk '{print $5}')
    cpu=$(mpstat | awk '{print "CPU: " $2+$3+$4+$5+$6+$7+$8+$9+$10+$11 "%"}'| tail -1)
    echo "<head><meta charset="UTF-8"><meta http-equiv="refresh" content="1">["$date"]" $cpu > data.html
sleep 1
done