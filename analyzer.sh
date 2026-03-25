#!/bin/bash
LOG_FILE=$1

echo "Top 5 IP addresses:"
cut -d ' ' -f1 "$LOG_FILE" | sort | uniq -c | sort -nr | head -5


echo ""
echo "Top 5 most requested paths:"
awk -F\" '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo ""
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo ""
echo "Top 5 user agents:"
awk -F\" '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | sed 's/^ *//' | awk '{count=$1; $1=""; print substr($0,2) " - " count " requests"}'
