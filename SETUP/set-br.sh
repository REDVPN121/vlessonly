#!/bin/bash
# Set-Backup Installation
# By YoLoNET
#-----------------------------
clear
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
MYIP=$(wget -qO- ipv4.icanhazip.com);

curl https://rclone.org/install.sh | bash
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/YoloNet/multiport/main/rclone.conf"
git clone  https://github.com/MrMan21/wondershaper.git
cd wondershaper
make install
cd
rm -rf wondershaper
cd /usr/bin
wget -O backup "https://${Server_URL}/BACKUP/backup.sh"
wget -O backup_tele "https://${Server_URL}/BACKUP/backup_tele.sh"
wget -O backupgithub "https://${Server_URL}/BACKUP/backupgithub.sh"
wget -O restore "https://${Server_URL}/BACKUP/restore.sh"
wget -O restore_tele "https://${Server_URL}/BACKUP/restore_tele.sh"
wget -O restoregithub "https://${Server_URL}/BACKUP/restoregithub.sh"
wget -O cleaner "https://${Server_URL}/BACKUP/logcleaner.sh"
wget -O kumbang "https://${Server_URL}/OTHERS/kumbang.sh"
chmod +x /usr/bin/backup
chmod +x /usr/bin/backup_tele
chmod +x /usr/bin/backupgithub
chmod +x /usr/bin/restore
chmod +x /usr/bin/restore_tele
chmod +x /usr/bin/restoregithub
chmod +x /usr/bin/cleaner
chmod +x /usr/bin/kumbang
cd
if [ ! -f "/etc/cron.d/cleaner" ]; then
cat> /etc/cron.d/cleaner << END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/2 * * * * root /usr/bin/cleaner
END
fi
service cron restart > /dev/null 2>&1
rm -f /root/set-br.sh