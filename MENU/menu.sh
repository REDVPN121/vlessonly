#!/bin/bash
#Autoscript-Lite By Visntech Modded by YoLoNET
#modded by yolonet
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

#omment lesen di bawah if dont want ip auth
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
#PERMISSION
#########################################################END OF IP PERMISSION#########################################
######################################################################################################################
P='\e[0;35m'
B='\033[0;36m'
G='\e[0;32m'
N='\e[0m'

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
MYIP=$(wget -qO- ipv4.icanhazip.com);
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

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
clear
domain=$(cat /root/domain)
#headerdesign
KEPALA=$(figlet -f slant "RED VPN")
servercountry=$(cat /usr/local/etc/servercountry.txt)
ispserver=$(cat /usr/local/etc/serverisp.txt)
namaklien=$(cat /var/lib/premium-script/clientname.conf)
clear
# // nginx status
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // xray status
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi
###########################
#Count Total User Vmess
check_online_users_vmess() {
    data=( $(grep '^###' /usr/local/etc/xray/config.json | awk '{print $2}' | sort -u) )

    for akun in "${data[@]}"; do
        data2=( $(cat /var/log/xray/access.log | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | sort -u) )
        ipvmess=()

        for ip in "${data2[@]}"; do
            jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort -u)
            if [[ "$jum" = "$ip" ]]; then
                ipvmess+=("$jum")
            else
                echo "$ip" >> /tmp/ipvmess.txt
            fi
        done
    done

    sort /tmp/ipvmess.txt | uniq > /tmp/totalonlinevmess.txt
    totaluseronline=$(cat /tmp/totalonlinevmess.txt | wc -l)

    echo "Vmess = $totaluseronline"
    
rm -rf /tmp/ipvmess.txt
rm -rf /tmp/totalonlinevmess.txt
}
#Count total xtls online
check_online_users_xtls() {
    data=( $(cat /usr/local/etc/xray/xtls.json | grep '^###' | awk '{print $2}' | sort -u) )

    for akun in "${data[@]}"; do
        if [[ -z "$akun" ]]; then
            akun="tidakada"
        fi
        echo -n > /tmp/ipxtls.txt
        data2=( $(cat /var/log/xray/access5.log | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | sort -u) )
        ipxtls=()

        for ip in "${data2[@]}"; do
            jum=$(cat /var/log/xray/access5.log | grep -w "$akun" | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort -u)
            if [[ "$jum" = "$ip" ]]; then
                ipxtls+=("$jum")
            else
                echo "$ip" >> /tmp/otherxtls.txt
            fi
        done
    done

    sort /tmp/otherxtls.txt | uniq > /tmp/totalonlinextls.txt
    totaluseronlinextls=$(cat /tmp/totalonlinextls.txt | wc -l)

    echo "XTLS = $totaluseronlinextls"
    
rm -rf /tmp/otherxtls.txt
rm -rf /tmp/totalonlinextls.txt
}

check_online_users_vless() {
    data=( $(cat /usr/local/etc/xray/vless.json | grep '^###' | awk '{print $2}' | sort -u) )

    for akun in "${data[@]}"; do
        if [[ -z "$akun" ]]; then
            akun="tidakada"
        fi
        echo -n > /tmp/ipvless.txt
        data2=( $(cat /var/log/xray/access2.log | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | sort -u) )
        ipvless=()

        for ip in "${data2[@]}"; do
            jum=$(cat /var/log/xray/access2.log | grep -w "$akun" | tail -n 500 | awk '{print $3}' | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort -u)
            if [[ "$jum" = "$ip" ]]; then
                ipvless+=("$jum")
            else
                echo "$ip" >> /tmp/othervless.txt
            fi
        done
    done

    sort /tmp/othervless.txt | uniq > /tmp/totalonlinevless.txt
    totaluseronlinevless=$(cat /tmp/totalonlinevless.txt | wc -l)

    echo "Vless = $totaluseronlinevless"

rm -rf /tmp/othervless.txt
rm -rf /tmp/totalonlinevless.txt
}
# TOTAL ACC CREATE VMESS WS
totalvmess=$(grep -c -E "^### " "/usr/local/etc/xray/config.json")
# TOTAL ACC CREATE  VLESS WS
totalvless=$(grep -c -E "^### " "/usr/local/etc/xray/vless.json")
# TOTAL ACC CREATE  VLESS TCP XTLS
totalxtls=$(grep -c -E "^### " "/usr/local/etc/xray/xtls.json")
### MENU START DI BAWAH ##
clear
# Call the count user online function
useronvmess=$(check_online_users_vmess)
useronxtls=$(check_online_users_xtls)
useronvless=$(check_online_users_vless)
clear
echo -e "$red$KEPALA"
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e " \E[44;1;46m                    SERVER INFO                     \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m"
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
IPVPS=$(curl -s icanhazip.com/ip )
if [ "$cekup" = "day" ]; then
echo -e " System Uptime   :  $uphours $upminutes $uptimecek"
else
echo -e " System Uptime   :  $uphours $upminutes"
fi
echo -e " Memory Usage    :  $uram / $tram"
echo -e " VPN Core        :  XRAY-CORE"
echo -e " Domain          :  $domain"
echo -e " Server Location :  $servercountry"
echo -e " Server ISP      :  $ispserver"
echo -e " IP VPS          :  $IPVPS"
 
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e "     [ XRAY-CORE${NC} : ${status_xray} ]   [ NGINX${NC} : ${status_nginx} ]"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m"
echo -e " Online User     : $useronvmess | $useronvless | $useronxtls"
echo -e " Total User      : Vmess=$totalvmess  | vless=$totalvless   | XTLS = $totalxtls " 
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e " \E[44;1;46m                     XRAY MENU                      \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m
 [\033[1;36m•1 \033[0m] Vmess WS Panel    [\033[1;36m•4 \033[0m]  Vless TCP XTLS Panel
 [\033[1;36m•2 \033[0m] Vless WS Panel    [\033[1;36m•5 \033[0m]  Trojan TCP Panel
 [\033[1;36m•3 \033[0m] Trojan WS Panel   [\033[1;36m•6 \033[0m]  Trojan GO Panel"
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e " \E[44;1;46m                       SYSTEM                       \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m
 [\033[1;36m•7 \033[0m] Change Domain     [\033[1;36m•10\033[0m]  Check VPN Port
 [\033[1;36m•8 \033[0m] Renew Certificate [\033[1;36m•11\033[0m]  Restart VPN Services
 [\033[1;36m•9 \033[0m] Check VPN Status"
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e " \E[44;1;46m                  OTHER FUNCTION                    \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m
 [\033[1;36m•12\033[0m]  Speedtest VPS    [\033[1;36m•15\033[0m]  DNS Changer
 [\033[1;36m•13\033[0m]  Check RAM        [\033[1;36m•16\033[0m]  Netflix Checker
 [\033[1;36m•14\033[0m]  Check Bandwith   [\033[1;36m•17\033[0m]  Set Bug Telco
 [\033[1;36m•77\033[0m]  System Menu"
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e " \E[44;1;46m                  BACKUP FUNCTION                   \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m
 [\033[1;36m•18\033[0m]  Backup To Github
 [\033[1;36m•19\033[0m]  Restore From Github"
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e " \E[44;1;46m                    SCRIPT INFO                     \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m"
echo -e "\e[36m╒════════════════════════════════════════════════════╕\033[0m"
echo -e " Version       :\033[1;36m Multiport Websocket 2.1 Premium\e[0m"
echo -e " Autoscript By : YOLONET"
echo -e " Client Name   : $namaklien"
echo -e " Expiry Script : ${G}Lifetime${NC}"
echo -e " Telegram      : @rayyolo"
echo -e "\e[36m╘════════════════════════════════════════════════════╛\033[0m"
echo -e " \033[1;37mPress [ Ctrl+C ] • To-Exit-Script\033[0m"
echo
echo -ne "Select menu : "; read x
if [[ $(cat /opt/.ver) = $serverV ]] > /dev/null 2>&1; then
    if [[ $x -eq 1 ]]; then
       menu-ws
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 2 ]]; then
       menu-vless
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 3 ]]; then
       menu-tr
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 4 ]]; then
       menu-xray
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 5 ]]; then
       menu-xtr
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 6 ]]; then
       menu-trgo
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 7 ]]; then
       add-host
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 8 ]]; then
       certxray
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 9 ]]; then
       status
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 10 ]]; then
       info
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 11 ]]; then
       restart
       menu
    elif [[ $x -eq 12 ]]; then
       clear
       speedtest
           echo ""
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 13 ]]; then
       clear
       ram
           echo ""
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 14 ]]; then
       clear
       vnstat
           echo ""
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 15 ]]; then
       dns
           echo ""
       menu
    elif [[ $x -eq 16 ]]; then
       clear
       bash <(curl -L -s https://git.io/JRw8R) -E
           echo ""
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 17 ]]; then
      kumbang
      read -n1 -r -p "Press any key to continue..."
      menu
    elif [[ $x -eq 77 ]]; then
      system-menu
      read -n1 -r -p "Press any key to continue..."
      menu
    elif [[ $x -eq 18 ]]; then
       backupgithub
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 19 ]]; then
       restoregithub
       read -n1 -r -p "Press any key to continue..."
       menu
    else
       menu
    fi
fi
