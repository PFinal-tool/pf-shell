#!/bin/sh

##########################################################################
# File Name: pfs.sh
# Author: pfinal
# mail: lampxiezi@163.com
# Created Time: 2021年03月10日 星期三 12时07分15秒
#########################################################################

direc=`dirname $0`
passwd_file="$direc/password"
function color(){
    blue="\033[0;36m"
    red="\033[0;31m"
    green="\033[0;32m"
    close="\033[m"
    case $1 in
        blue)
            echo -e "$blue $2 $close"
        ;;
        red)
            echo -e "$red $2 $close"
        ;;
        green)
            echo -e "$green $2 $close"
        ;;
        *)
            echo "Input color error!!"
        ;;
    esac
}

function copyright(){
    echo "##########################################"
    color green "   SSH Login Platform   "
    echo "##########################################"
    echo
}

function underline(){
    echo "------------------------------------------"
}

function main(){

while [ True ];do


    echo "序号 |       主机      | 说明"
    underline
    # awk 'BEGIN {FS=":"} {printf("\033[0;31m% 3s \033[m | %15s | %s\n",$1,$2,$6)}' $direc/password
    awk '{if(!NF || /^#/){next}} BEGIN {FS=":"} {printf("\033[0;31m% 3s \033[m | %s@%s:%s | %s\n",$1,$4,$2,$3,$6)}' $passwd_file
    underline
    read -p '[*] 选择主机: ' number
    #pw="$direc/password"
    ipaddr=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $2}}' $passwd_file)
    port=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $3}}' $passwd_file)
    username=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $4}}' $passwd_file)
    passwd=$(awk -v num=$number 'BEGIN {FS=":"} {if($1 == num) {print $5}}' $passwd_file)

    case $number in
        [0-9]|[0-9][0-9]|[0-9][0-9][0-9])
            #echo $passwd | grep -q ".pem$"
            #RETURN=$?
            if [ -f "$passwd" ];then
                #echo "$passwd 文件存在"
                echo "ssh -i $passwd $username@$ipaddr -p $port"
                ssh -i $passwd $username@$ipaddr -p $port
            else
                #echo "$passwd 文件不存在"
                expect -f $direc/ssh_login.exp $ipaddr $username $passwd $port
            fi
        ;;
        "q"|"quit")
            exit
        ;;

        *)
            echo "Input error!!"
        ;;
    esac
done
}

copyright
main
