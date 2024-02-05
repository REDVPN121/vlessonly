#!/bin/bash
# SSH-VPN Installation Setup
# By YoLoNET
# ==================================
###############################START IP PERMISSION#################################################
Server_URL="$(cat /root/install_link.txt )"
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
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#Detail
country="MY"
state="Perak"
locality="Parit Buntar"
organization="YoLoNET-Project"
organizationalunit="YoLoNET-Project"
commonname="YoLoNET-Project"
email="rayrjtech@gmail.com"

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

# install wget and curl
apt -y install wget curl

# install netfilter-persistent
apt-get install netfilter-persistent

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git lsof
echo "clear" >> .profile
echo "menu" >> .profile

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://${Server_URL}/OTHERS/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "hhttps://${Server_URL}/OTHERS/vps.conf"
/etc/init.d/nginx restart

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.12.tar.gz
tar zxvf vnstat-2.12.tar.gz
cd vnstat-2.12
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.12.tar.gz
rm -rf /root/vnstat-2.12

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate // DDOS Protection
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# banner /etc/issue.net
wget -q -O /etc/issue.net "https://${Server_URL}/OTHERS/issues.net" && chmod +x /etc/issue.net
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP

iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# install resolvconf service
apt update
apt install resolvconf -y

#start resolvconf service
systemctl start resolvconf.service
systemctl enable resolvconf.service
touch /etc/resolvconf/resolv.conf.d/head
echo nameserver 1.1.1.1 >> /etc/resolvconf/resolv.conf.d/head
echo nameserver 1.0.0.1 >> /etc/resolvconf/resolv.conf.d/head
resolvconf --enable-updates
resolvconf -u
systemctl restart resolvconf.service

# download script
cd /usr/bin
wget -O add-host "https://${Server_URL}/OTHERS/add-host.sh" 
wget -O speedtest "https://${Server_URL}/OTHERS/speedtest_cli.py"
wget -O xp "https://${Server_URL}/OTHERS/xp.sh"
wget -O menu "https://${Server_URL}/MENU/menu.sh"
wget -O status "https://${Server_URL}/OTHERS/status.sh"
wget -O info "https://${Server_URL}/OTHERS/info.sh"
wget -O restart "https://${Server_URL}/OTHERS/restart.sh"
wget -O ram "https://${Server_URL}/OTHERS/ram.sh"
wget -O dns "https://${Server_URL}/OTHERS/dns.sh"
wget -O system-menu "https://${Server_URL}/MENU/system-menu.sh"
wget -O updater_sc "https://${Server_URL}/SETUP/updater_sc.sh"
wget -O anti-highusage "https://${Server_URL}/OTHERS/anti-highusage.sh"
wget -O autocek_online "https://${Server_URL}/OTHERS/autocek_online.sh"
wget -O server_status "https://${Server_URL}/BOT/server_status.sh"
chmod +x menu
chmod +x add-host
chmod +x speedtest
chmod +x xp
chmod +x status
chmod +x info
chmod +x restart
chmod +x ram
chmod +x dns
chmod +x system-menu
chmod +x updater_sc
chmod +x anti-highusage
chmod +x autocek_online
chmod +x server_status

# / / setting cron
echo "0 6 * * * root reboot" >> /var/spool/cron/crontabs/root
echo "0 0 * * * root /usr/bin/xp" >> /var/spool/cron/crontabs/root
echo "*/2 * * * * root /usr/bin/cleaner" >> /var/spool/cron/crontabs/root
echo "@hourly /usr/bin/backup_tele" >> /var/spool/cron/crontabs/root
echo "*/2 * * * * /usr/bin/anti-highusage.sh" >> /var/spool/cron/crontabs/root # Every 2 minute
echo "*/62 * * * *  /usr/bin/server_status" >> /var/spool/cron/crontabs/root # Every 62 Minutes
cd

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1

# remove unnecessary files
cd
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
# finishing
cd
chown -R www-data:www-data /home/vps/public_html
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting nginx"
/etc/init.d/nginx restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting cron "
/etc/init.d/cron restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting fail2ban"
/etc/init.d/fail2ban restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting resolvconf"
/etc/init.d/resolvconf restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}ok${NC} ] Restarting vnstat"
/etc/init.d/vnstat restart >/dev/null 2>&1
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/ssh-vpn.sh

# finishing
clear
