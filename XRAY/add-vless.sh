#!/bin/bash
#Autoscript-Lite By YoLoNET
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
clear
#########################################################END OF IP PERMISSION#########################################
######################################################################################################################
clear
domain=$(cat /usr/local/etc/xray/domain)
tls="$(cat ~/log-install.txt | grep -w "VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "VLESS WS None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\E[0;41;36m     Add XRAY Vless WS Account     \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/vless.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
		    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\E[0;41;36m      Add XRAY Vless Account       \E[0m"
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			read -n 1 -s -r -p "Press any key to back on menu"
			menu
		fi
	done

  function bug_sendiri() {
  read -p "Bug Address (Example: www.google.com) : " address
  read -p "Bug SNI/Host (Example : m.facebook.com) : " hst
  read -p "Expired (days) : " masaaktif
  bug_addr=${address}.
  bug_addr2=${address}
  if [[ $address == "" ]]; then
  sts=$bug_addr2
  else
  sts=$bug_addr
  fi
  bug=${hst}
  bug2=bug.com
  if [[ $hst == "" ]]; then
  sni=$bug2
  else
  sni=$bug
  fi
  }
  clear

function preset_bug() {
  bugdigi=/root/.ctech/.kumbang/digi
  bugumo=/root/.ctech/.kumbang/umobile
  bugmaxis=/root/.ctech/.kumbang/maxis
  bugunifi=/root/.ctech/.kumbang/unifi
  bugyodoo=/root/.ctech/.kumbang/yodoo
  bugcelcom=/root/.ctech/.kumbang/celcom
  digi=$(sed -n '1 p' $bugdigi | cut -d' ' -f1)
  umo=$(sed -n '1 p' $bugumo | cut -d' ' -f1)
  maxis=$(sed -n '1 p' $bugmaxis | cut -d' ' -f1)
  unifi=$(sed -n '1 p' $bugunifi | cut -d' ' -f1)
  yodoo=$(sed -n '1 p' $bugyodoo | cut -d' ' -f1)
  celcom=$(sed -n '1 p' $bugcelcom | cut -d' ' -f1)

while true $x != "ok"
  do
  echo "1. DIGI"
  echo "2. UMOBILE"
  echo "3. MAXIS"
  echo "4. UNIFI"
  echo "5. YODOO"
  echo "6. CELCOM"
  echo -ne "Input your choice : "; read list
  case "$list" in
     1) bug="$digi";break;;
     2) bug="$umo";break;;
     3) bug="$maxis";break;;
     4) bug="$unifi";break;;
     5) bug="$yodoo";break;;
     6) bug="$celcom";break;;
  esac
  done
  }
  clear
bug_sendiri
uuid=$(cat /proc/sys/kernel/random/uuid)
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`

sed -i '/#tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vless.json
sed -i '/#none$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vnone.json
sed -i '/#grpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/vlessgrpc.json

# Restart Service
systemctl restart xray@vless.service
systemctl restart xray@vnone.service
service cron restart

vlesslink1="vless://${uuid}@${sts}${domain}:${tls}?type=ws&encryption=none&security=tls&host=${domain}&path=/vless-tls&allowInsecure=1&sni=${sni}#XRAY_VLESS_TLS_${user}"
vlesslink2="vless://${uuid}@${sts}${domain}:${none}?type=ws&encryption=none&security=none&host=${domain}&path=/vless-ntls#XRAY_VLESS_NON_TLS_${user}"

vlesslink2.1="vless://${uuid}@${sts}${domain}:${none}?type=ws&encryption=none&security=none&host=${domain}&path=/vless-ntls#XRAY_VLESS_NON_TLS_${user}"
vlesslink22="vless://${uuid}@${sts}${domain}:${80}?type=grpc&encryption=none&security=none&mode=gun&serviceName=vlessgrpc#$user"

vlesslink3="vless://${uuid}@italeem.iium.edu.my:${tls}?type=ws&encryption=none&security=tls&host=${domain}&path=wss://italeem.iium.edu.my/vless-tls&allowInsecure=1&sni=italeem.iium.edu.my#XRAY_VLESS_MAXIS_${user}"
vlesslink4="vless://${uuid}@162.159.134.61:${none}?type=ws&encryption=none&security=none&host=${domain}&path=/vless-ntls#XRAY_VLESS_DIGI_${user}"
vlesslink5="vless://${uuid}@104.20.65.29:${tls}?type=ws&encryption=none&security=tls&host=${domain}&path=wss://onlinepayment.celcom.com.my/vless-tls&allowInsecure=1&sni=onlinepayment.celcom.com.my#XRAY_VLESS_CELCOM_${user}"
vlesslink6="vless://${uuid}@cdn.who.int:${none}?type=ws&encryption=none&security=none&host=${domain}&path=wss://cdn.who.int/vless-ntls#XRAY_VLESS_YES_${user}"

cat > /home/vps/public_html/$user-VLESSTLS.yaml <<EOF
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: XRAY_VLESS_TLS_${user}
    server: ${sts}${domain}
    port: ${tls}
    type: vless
    uuid: ${uuid}
    cipher: auto
    tls: true
    skip-cert-verify: true
    servername: ${sni}
    network: ws
    ws-opts:
      path: /vless-tls
      headers:
        Host: ${domain}
    udp: true
proxy-groups:
  - name: YoLoNET-Autoscript
    type: select
    proxies:
      - XRAY_VLESS_TLS_${user}
      - DIRECT
rules:
  - MATCH,YoLoNET-Autoscript
EOF

cat > /home/vps/public_html/$user-VLESSNTLS.yaml <<EOF
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: XRAY_VLESS_NON_TLS_${user}
    server: ${sts}${domain}
    port: ${none}
    type: vless
    uuid: ${uuid}
    cipher: auto
    tls: false
    skip-cert-verify: true
    servername: ${sni}
    network: ws
    ws-opts:
      path: /vless-ntls
      headers:
        Host: ${domain}
    udp: true
proxy-groups:
  - name: YoLoNET-Autoscript
    type: select
    proxies:
      - XRAY_VLESS_NON_TLS_${user}
      - DIRECT
rules:
  - MATCH,YoLoNET-Autoscript
EOF

clear
echo -e ""
echo -e "════════════[XRAY VLESS WS]════════════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port TLS          : ${tls}"
echo -e "Port None TLS     : ${none}"
echo -e "ID                : ${uuid}"
echo -e "Security          : TLS"
echo -e "Encryption        : None"
echo -e "Network           : WS"
echo -e "Path TLS          : /vless-tls"
echo -e "Path NTLS         : /vless-ntls"
echo -e "═══════════════════════════════════════"
echo -e "Link WS TLS       : ${vlesslink1}"
echo -e "═══════════════════════════════════════"
echo -e "Link WS None TLS  : ${vlesslink2}"
echo -e "═══════════════════════════════════════"
echo -e "Link (MAXIS)      : ${vlesslink3}"
echo -e "═══════════════════════════════════════"
echo -e "Link (DIGI)       : ${vlesslink4}"
echo -e "═══════════════════════════════════════"
echo -e "Link (CELCOM)     : ${vlesslink5}"
echo -e "═══════════════════════════════════════"
echo -e "Link (YES)        : ${vlesslink6}"
echo -e "═══════════════════════════════════════"
echo -e "YAML WS TLS       : http://${MYIP}:81/$user-VLESSTLS.yaml"
echo -e "════════════════════════════════════════"
echo -e "YAML WS None TLS  : http://${MYIP}:81/$user-VLESSNTLS.yaml"
echo -e "════════════════════════════════════════"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "═══════════════════════════════════════"
echo -e ""
echo -e "Autoscript By YoLoNET"
echo -e ""