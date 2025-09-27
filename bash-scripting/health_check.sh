#!/bin/bash


# global variable
NC="\033[0m"
LOGFILE="/var/log/healthcheck/health_check.log"
#LOGFILE="./health_check.log"
USER="healthcheck"


# function to show the information about how to use this script
function show_help(){
    echo -e "Usage: $0 <IP_ADDRESS/HOSTNAME> [PORT]\n"
    echo -e "Check the connectivity to the <IP_ADDERSS/HOSTNAME>"
    echo -e "Check the connectivity to the <IP_ADDERSS/HOSTNAME> [PORT]"
    echo -e "Show disk usage on the root filesystems (/) in percentage\n"
    echo -e "Arguments:"
    echo -e "  IP_ADDRESS      The IP address of the server (required)"
    echo -e "  PORT            The port (optional, default: 80)\n"
    echo -e "Options:"
    echo -e "  -h, --help      Show this help message\n"
    echo -e "Examples:"
    echo -e "  $0 192.168.1.10"
    echo -e "  $0 192.168.1.10 2222"
}


# for printing color in the terminal
function print_color(){
    case $1 in
        "green") COLOR="\033[0;32m" ;;
        "red") COLOR="\033[0;31m" ;;
        *) COLOR="\033[0m" ;;
    esac
    echo -e "${COLOR} $2 ${NC}"
}


# for appending log to log file
log() {
    local MESSAGE="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $MESSAGE" >> "$LOGFILE"
}


# check if the script is run by at least one argument
if [ $# -eq 0 ] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi


IP=$1
PORT=${2:-80}


# make sure the log directory is exist
mkdir -p "$(dirname "$LOGFILE")"


log "Start running healthcheck"
# start checking the ping connectivity
log "Checking connection to the $IP"
if ping -c 1 -W 2 "$IP" > /dev/null 2>&1; then
    print_color "green" "Server is reachable."
    log "Server $IP is reachable"
else
    print_color "red" "Server is not reachable."
    log "Server $IP is not reachable"
fi


# start checking connection to the web service
log "Checking connection to the web service on $IP:$PORT"
if curl -s --connect-timeout 3 "http://$IP:$PORT" > /dev/null 2>&1 || \
   curl -s --connect-timeout 3 "https://$IP:$PORT" > /dev/null 2>&1; then
    print_color "green" "Web service on port $PORT is UP"
    log "Web service on $IP:$PORT is UP"
else
    print_color "red" "Web service on port $PORT is DOWN"
    log "Web service on $IP:$PORT is DOWN"
fi


# ssh to the remote server, and get the disk usage
log "Checking the disk usage at $IP on /"


if [[ "$IP" == "localhost" || "$IP" == "127.0.0.1" ]]; then
    USAGE=$(df -h / | awk 'NR==2 {print $5}')
else
    USAGE=$(ssh -o ConnectTimeout=5 ${USER}@${IP} "df -h / | awk 'NR==2 {print \$5}'" 2>/dev/null)
fi


if [ -z "$USAGE" ]; then
    print_color "red" "Failed to get disk usage on $IP. Maybe ssh related issue."
    log "Failed to get disk usage on $IP"
else
    print_color "green" "Disk usage on / is $USAGE at $IP"
    log "Disk usage on / is $USAGE at $IP"
fi


log "End running healthcheck"
print_color "green" "Result logged to health_check.log"
