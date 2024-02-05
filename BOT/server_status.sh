#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# SC Remod by YOLONET
# TELE BOT TOOLS BY YOLONET
# =========================================

## Foreground
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
NC='\e[0m'

IPVPS=$(curl -s https://checkip.amazonaws.com)
date=$(date +"%d-%m-%Y-%H:%M:%S")
domain=$(cat /root/domain)

# TOTAL ACC XRAYS WS & XTLS
tvless=$(grep -c -E "^### $user" "/usr/local/etc/xray/vless.json")
ttxtls=$(grep -c -E "^### $user" "/usr/local/etc/xray/xtls.json")

Total_User=$(($tvless + $ttxtls))

#Total Online user
# // cek online user vless
    echo -n > /tmp/ipvless.txt
    echo -n > /root/vlessonline.txt # save the total vless user online to the file
    data=( `cat /usr/local/etc/xray/config.json | grep '^#tls' | cut -d ' ' -f 2 | sort | uniq`);

    for akun in "${data[@]}"; do
        if [[ -z "$akun" ]]; then
            akun="tidakada"
        fi
        
        data2=( $(cat /var/log/xray/access2.log | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | sort -u) )
        ipvless=()

        for ip in "${data2[@]}"; do
            jum=$(cat /var/log/xray/access2.log | grep -Fw "$akun" | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | grep -Fw "$ip" | sort -u)
            if [[ "$jum" = "$ip" ]]; then
                ipvless+=("$jum")
            else
                echo "$ip" >> /tmp/ipvless.txt
            fi
        done
    done

    sort /tmp/ipvless.txt | uniq > /tmp/totalonlinevless.txt 2>/dev/null
totaluseronline=$(cat /tmp/totalonlinevless.txt | wc -l)

# RAM & CPU Info
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )

# Get CPU usage percentage
cpu_usage=$(top -bn1 | awk '/%Cpu/{print $2}' | cut -d. -f1)

# Get memory usage percentage
mem_usage=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')

# Replace the following values with your own Telegram bot token and chat ID
TELEGRAM_BOT_TOKEN=$(cat /var/lib/premium-script/tele_token.txt)
TELEGRAM_CHAT_ID=$(cat /var/lib/premium-script/tele_id.txt)

send_telegram_message() {
    message="$1"
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" -d "chat_id=$TELEGRAM_CHAT_ID&text=$message"
}

# Send notification to Telegram
send_server_status() {
send_telegram_message "Server status for: $IPVPS
    DOMAIN      : $domain
    DATE        : $date
    CPU USAGE   : $cpu_usage%
    RAM USAGE   : $mem_usage%
    TOTAL USER  : $Total_User
    USER ONLINE : $totaluseronline" &> /dev/null
}
send_server_status
rm -rf /tmp/ipvless.txt>/dev/null 2>&1
rm -rf /tmp/totalonlinevless.txt>/dev/null 2>&1