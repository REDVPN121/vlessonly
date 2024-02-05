#!/bin/bash
#Autoscript-Lite By YoLoNET
P='\e[0;35m'
B='\033[0;36m'
N='\e[0m'
clear
echo -e "\e[36m╒════════════════════════════════════════════╕\033[0m"
echo -e " \E[0;41;36m            XRAY TROJAN TCP MENU            \E[0m"
echo -e "\e[36m╘════════════════════════════════════════════╛\033[0m

 [\033[1;36m•1 \033[0m]  Add XRAY Trojan TCP
 [\033[1;36m•2 \033[0m]  Check User Login XRAY Trojan TCP
 [\033[1;36m•3 \033[0m]  Delete XRAY Trojan TCP
 [\033[1;36m•4 \033[0m]  Renew XRAY Trojan TCP
 [\033[1;36m•5 \033[0m]  Check XRAY Trojan TCP Config
 [\033[1;36m•6 \033[0m]  Back To Main Menu"
echo ""
echo -e " \033[1;37mPress [ Ctrl+C ] • To-Exit-Script\033[0m"
echo ""
echo -ne "Select menu : "; read x
if [[ $(cat /opt/.ver) = $serverV ]] > /dev/null 2>&1; then
    if [[ $x -eq 1 ]]; then
       add-xtr
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 2 ]]; then
       cek-xtr
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 3 ]]; then
       del-xtr
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 4 ]]; then
       renew-xtr
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 5 ]]; then
       user-xtr
       read -n1 -r -p "Press any key to continue..."
       menu
    elif [[ $x -eq 6 ]]; then
       clear
       menu
    else
       clear
       menu-xtr
    fi
fi