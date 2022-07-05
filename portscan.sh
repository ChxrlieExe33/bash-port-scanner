#!/bin/bash

declare -a puertosAbiertos=()

function scan (){
    
    for ((i=1; i < 10001; i++))
    do

    if 2> /dev/null > /dev/tcp/$1/$i
    then
        puertosAbiertos+=("$i")
        imprimirPantalla $i
    fi

    done

}

function imprimirPantalla (){

    cyan='\033[0;36m'
    green='\033[0;32m'
    yellow='\033[0;33m'
    clear='\033[0m'

    echo -e "${yellow}[*] ${green} Port ${cyan} $1 ${green} OPEN ${clear}"

}

function guardarCsv (){
    for puerto in "${puertosAbiertos[@]}"
    do
        echo "$activo;$puerto;Open" >> results.csv
    done
}

echo -e "Welcome to my quick bash port scanner \n\nInsert the IP address or domain name you wish to scan: \n"

read -p "--> " activo

if ping -c 1 $activo > /dev/null
then

    echo -e "\n[+] Scan of $activo running:\n"

    echo -e "---------------------------------------------\n"

    scan $activo

    # imprimirPantalla 

    guardarCsv
else
    echo "The target $activo is unavailable or doest exist"
fi
