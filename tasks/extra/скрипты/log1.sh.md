```
#!/bin/bash
LOGFILE="/var/www/html/script/nginx.log"
NGINX_LOG="/var/log/nginx/access.log"

MAX_SIZE=300000
LOG_CLEAN="/var/www/html/script/log_clean.log"
LOG_4XX="/var/www/html/script/log_4xx.log"
LOG_5XX="/var/www/html/script/log_5xx.log"

log_nginx(){
		tail -n 10 "$NGINX_LOG" >> "$LOGFILE"
}


check_log_size() {

	if [[ -f "$LOGFILE" && $(stat -c%s "$LOGFILE") -gt $MAX_SIZE ]]; then
			local count=$(wc -l < "$LOGFILE")
			> "$LOGFILE"
			echo "$(date '+%Y-%m-%d %H:%M:%S') - cleared $count records
		from $LOGFILE" >> "$LOG_CLEAN
	fi           
}

log_http_code() {
		if [[ -f "$NGINX_LOG" ]]; then
			tail -n 10 "$NGINX_LOG" | awk '$9 ~ /^5[0-9][0-9]$/' >> "$LOG_5XX"
			tail -n 10 "$NGINX_LOG" | awk '$9 ~ /^4[0-9][0-9]$/' >> "$LOG_4XX"
		fi
}

while true; do
        log_nginx
        check_log_size
        log_http_code
        sleep 5
done
```