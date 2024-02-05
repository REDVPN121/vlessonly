#!/bin/bash
###############################START IP PERMISSION#################################################
red='\e[1;31m'
green='\e[0;32m'
purple='\e[0;35m'
orange='\e[0;33m'
NC='\e[0m'
#get server date for taday
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
MYIP=$(wget -qO- ipv4.icanhazip.com);
echo "Checking VPS"
clear
#get ip for permission
cek=$( curl -sS https://raw.githubusercontent.com/YoloNet/IP-Multiport-Websocket/main/access | awk '{print $4}'  | grep $MYIP )
Name=$(curl -sS https://raw.githubusercontent.com/YoloNet/IP-Multiport-Websocket/main/access | grep $MYIP | awk '{print $2}')
lesen() {
if [[ $cek = $MYIP ]]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo ""
echo -e "Your IP is ${red}NOT REGISTER${NC} @ ${red}EXPIRED${NC}"
echo ""
echo -e "Please Contact ${green}Admin${NC}"
echo -e "Telegram : t.me/rayyolo"
rm -f setup-lite.sh
exit 0
fi
}
clear
#comment lesen di bawah if dont want ip auth
lesen
#get ip from access github
BURIQ() {
    curl -sS https://raw.githubusercontent.com/YoloNet/IP-Multiport-Websocket/main/access >/root/tmp
    data=($(cat /root/tmp | grep -E "^### " | awk '{print $4}'))
    for user in "${data[@]}"; do
        exp=($(grep -E "^### $user" "/root/tmp" | awk '{print $3}'))
        d1=($(date -d "$exp" +%s))
        d2=($(date -d "$biji" +%s))
        exp2=$(((d1 - d2) / 86400))
        if [[ "$exp2" -le "0" ]]; then
            echo $user >/etc/.$user.ini
        else
            rm -f /etc/.$user.ini >/dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

MYIP=$(wget -qO- ipv4.icanhazip.com);
Name=$(curl -sS https://raw.githubusercontent.com/YoloNet/IP-Multiport-Websocket/main/access | grep $MYIP | awk '{print $2}')
echo $Name >/usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman() {
    if [[ -f "/etc/.$Name.ini" ]]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [[ "$CekOne" = "$CekTwo" ]]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION() {
    MYIP=$(wget -qO- ipv4.icanhazip.com);
    IZIN=$(curl -sS https://raw.githubusercontent.com/YoloNet/IP-Multiport-Websocket/main/access | awk '{print $2}' | grep $MYIP)
    if [[ "$MYIP" = "$IZIN" ]]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    BURIQ
}
##PERMISSION
#########################################################END OF IP PERMISSION#########################################
######################################################################################################################
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
MYIP=$(wget -qO- ipv4.icanhazip.com);
echo "Checking VPS"
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple='\e[0;35m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

echo -e "\e[0;32mCHECKING IP PERMISSION...\e[0m"

cd
# / / CHECKING FOR ROOT USER
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
MYIP=$(wget -qO- icanhazip.com/ip);
secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minutes $(( ${1} % 60 )) seconds"
}
start=$(date +%s)

echo -e "[ ${green}INFO${NC} ] Preparing the autoscript installation ~"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Installation file is ready to begin !"
sleep 1

if [ -f "/usr/local/etc/xray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
# / / Install jq
echo -e "[ ${green}INFO${NC} ] Installing JQ ~"
apt install jq -y
echo -e "[ ${green}INFO${NC} ] JQ has been installed !"
clear
# / / make directory for premium script
mkdir /var/lib/premium-script;
mkdir /var/lib/crot-script;
clear
#Ask for servinstall_link_url
read -p "Enter your script installation link without http:// or https:// and no '/' at end: " install_link_url
echo "${install_link_url}" > /root/install_link.txt
Server_URL="$(cat /root/install_link.txt )"
clear
# / / Gathering other information
echo -e ""
echo -e " ${green}Please Insert Domain${NC}"
echo -e ""
read -p " Hostname / Domain: " host
echo -e ""
echo -e " ${green}Please Insert Client Name${NC}"
echo -e ""
read -p " Client Name : " clientname
echo -e " [ ${green}SC  By YoLoNET 2022 modded by redvpn${NC} ] "
echo -e ""
echo -e " ${green}Please Insert Your Telegram BOT TOKEN${NC}"
echo -e " ${green}Create Your Telegram Bot Using @BotFather${NC}"
echo -e ""
read -p " TELEGRAM BOT TOKEN: " tele_token
echo -e ""
echo -e " ${green}Please Insert Your Telegram CHAT ID${NC}"
echo -e " ${green}get Your Telegram CHAT ID from BOT @MissRose_bot${NC}"
echo -e ""
read -p " TELEGRAM CHAT ID: " tele_id
echo -e ""
# / / saving information to /var/lib
echo "IP=$host" > /var/lib/premium-script/ipvps.conf
echo "IP=$host" > /var/lib/crot-script/ipvps.conf
echo "$host" > /root/domain
echo "$host" > /usr/local/etc/xray/domain
echo "$clientname" > /var/lib/premium-script/clientname.conf
echo "$tele_token" > /var/lib/premium-script/tele_token.txt
echo "$tele_id" > /var/lib/premium-script/tele_id.txt
clear

#gathering and saving server info
echo -e "\e[0;32mgathering & Saving Data Server...\e[0m"
ispserver=$(curl -sL ip.guide | jq -r '.network.autonomous_system.organization')
servercountry=$(curl -sL ip.guide | jq -r '.location.country')
echo "$ispserver" > /var/lib/premium-script/serverisp.txt
echo "$servercountry" > /var/lib/premium-script/servercountry.txt
echo -e "\e[0;32mREADY FOR INSTALLATION SCRIPT...\e[0m"
echo -e ""
sleep 1
#Install SSH-VPN
echo -e "\e[0;32mINSTALLING SSH-VPN...\e[0m"
sleep 1
wget https://${Server_URL}/SETUP/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
echo -e "\e[0;32mDONE INSTALLING SSH-VPN\e[0m"
echo -e ""
sleep 1
#Install Xray
echo -e "\e[0;32mINSTALLING XRAY CORE...\e[0m"
sleep 1
wget https://${Server_URL}/SETUP/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
echo -e "\e[0;32mDONE INSTALLING XRAY CORE\e[0m"
echo -e ""
sleep 1
clear
#Install SET-BR
echo -e "\e[0;32mINSTALLING SET-BR...\e[0m"
sleep 1
wget https://${Server_URL}/SETUP/set-br.sh && chmod +x set-br.sh && ./set-br.sh
echo -e "\e[0;32mDONE INSTALLING SET-BR...\e[0m"
echo -e ""
sleep 1
clear

rm -rf /usr/share/nginx/html/index.html
wget -q -O /usr/share/nginx/html/index.html "https://${Server_URL}/OTHERS/index.html"

# Finish
rm -f /root/ins-xray.sh
rm -f /root/set-br.sh
rm -f /root/ssh-vpn.sh

# Version
echo "1.2" > /home/ver
clear
echo ""
echo ""
echo -e "    .-------------------------------------------."
echo -e "    |      Installation Has Been Completed      |"
echo -e "    '-------------------------------------------'"
echo ""
echo ""
echo -e "${purple}═════════════════════${NC}[-Autoscript-Lite-]${purple}═════════════════════${NC}" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "    >>> Service Details <<<"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   [ XRAY INFORMATION ]" | tee -a log-install.txt
echo -e "${purple}   --------------------${NC}" | tee -a log-install.txt
echo "   - XRAY VMESS WS TLS       : 443"  | tee -a log-install.txt
echo "   - XRAY VLESS WS TLS       : 443"  | tee -a log-install.txt
echo "   - XRAY TROJAN WS TLS      : 443"  | tee -a log-install.txt
echo "   - XRAY VLESS TCP XTLS     : 443"  | tee -a log-install.txt
echo "   - XRAY TROJAN TCP TLS     : 443"  | tee -a log-install.txt
echo "   - XRAY VMESS WS None TLS  : 80"  | tee -a log-install.txt
echo "   - XRAY VLESS WS None TLS  : 80"  | tee -a log-install.txt
echo "   - XRAY TROJAN WS None TLS : 80"  | tee -a log-install.txt
echo "   - TROJAN GO WS            : 8443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   [ YAML INFORMATION ]" | tee -a log-install.txt
echo -e "${purple}   --------------------${NC}" | tee -a log-install.txt
echo "   - YAML XRAY VMESS WS"  | tee -a log-install.txt
echo "   - YAML XRAY VLESS WS"  | tee -a log-install.txt
echo "   - YAML XRAY TROJAN WS"  | tee -a log-install.txt
echo "   - YAML XRAY VLESS XTLS"  | tee -a log-install.txt
echo "   - YAML XRAY TROJAN TCP"  | tee -a log-install.txt
echo "   - YAML TROJAN GO"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   [ SERVER INFORMATION ]"  | tee -a log-install.txt
echo -e "${purple}   ----------------------${NC}" | tee -a log-install.txt
echo "   - Timezone                : Asia/Kuala_Lumpur (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPV6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 06.00 GMT +8" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   [ DEV INFORMATION ]" | tee -a log-install.txt
echo -e "${purple}   -------------------${NC}" | tee -a log-install.txt
echo "   - Autoscript-Lite By      : YoLoNET"  | tee -a log-install.txt
echo "   - Telegram                : t.me/rayyolo"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo -e "${purple}════════════════${NC}Autoscript-Lite By YoLoNET${purple}════════════════${NC}" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo ""
echo -e "Thanks For Installing This Autoscript-Lite :)"
echo -e "VPS Will Reboot . . ."
sleep 3
rm -r setup-lite.sh
reboot
