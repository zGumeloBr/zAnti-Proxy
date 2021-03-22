#!/bin/bash

#
#
# Criado por zGumeloBr
#
#

#Verificar se o script vai ser executado em root ou não.

if [[ $EUID -ne 0 ]]; then
  echo -e "\033[1;32m * Esse script precisa ser executado em super usuário (sudo). \033[0m" 1>&2
  exit 1

fi

# Dependências para funcionamento do script.

sudo apt -y update

sudo apt -y upgrade

sudo apt install -y wget

sudo apt install -y iptables

sudo apt install -y ipset

ipset create zShield -exist hash:ip hashsize 9999999 maxelem 9999999 timeout 0

# Plataformas de obtenção das proxies.

wget -O proxyS4.txt https://www.proxy-list.download/api/v1/get?type=socks4

wget -O PSproxies.txt https://api.proxyscrape.com/?request=displayproxies&proxytype=all&timeout=all&country=all

wget -O githubList.txt https://raw.githubusercontent.com/ktsaou/blocklist-ipsets/master/nixspam.ipset

wget -O tor.txt https://check.torproject.org/torbulkexitlist

wget -O proxyS5.txt https://www.proxy-list.download/api/v1/get?type=socks5

wget -O psS4.txt https://www.proxyscan.io/download?type=socks4

wget -O psS5.txt https://www.proxyscan.io/download?type=socks5

wget -O proxyscrap.txt https://api.proxyscrape.com/v2/?request=getproxies

# Compactando todos os arquivos em 1 so.

cat proxyS4.txt > proxies.txt | cat proxyS5.txt > proxies.txt | cat psS4.txt > proxies.txt | cat psS5.txt > proxies.txt | cat proxyscrap.txt > proxies.txt | cat tor.txt > proxies.txt | cat githubList.txt > proxies.txt

# Replace para retirar as portas

sed -i 's/$/:/' proxies.txt

sed -i 's/:.*/:/' proxies.txt

sed -i 's/[:]\+//g' proxies.txt

sed -i '/^#/d' proxies.txt

#Apagando os arquivos inuteis.

rm -rf proxyS4.txt | rm -rf tor.txt | rm -rf PSproxies.txt | rm -rf proxyS5.txt | rm -rf psS4.txt | rm -rf psS5.txt | rm -rf proxyscrap.txt | rm -rf githubList.txt

# Bloqueando todos as proxys coletadas.

for x in $(cat proxies.txt)
do
        ipset -A zShield $x
done

iptables -I INPUT -m set --match-set zShield src -j DROP

#Limpando terminal

clear

#Mensagem de finalização

echo ""
echo ""
echo -e "\033[1;34m ____    __    _  _  ____  ____      ____  ____  _____  _  _  _  _\033[0m"  
echo -e "\033[1;34m(_   )  /__\  ( \( )(_  _)(_  _)    (  _ \(  _ \(  _  )( \/ )( \/ )\033[0m" 
echo -e "\033[1;34m / /_  /(  )\  )  (   )(   _)(_      )___/ )   / )(_)(  )  (  \  / \033[0m"
echo -e "\033[1;34m(____)(__)(__)(_)\_) (__) (____)    (__)  (_)\_)(_____)(_/\_) (__) \033[0m"
echo ""
echo -e "\033[0;37m❖ Proxys bloqueadas com sucesso! Lembre-se de sempre re-ativar\033[0m"
echo -e "\033[0;37messa proteção para atualizar as lista de proxys bloqueadas. \033[0m"
echo ""
echo -e "\033[1;33m❖ Total de proxys bloqueadas:\033[0m"

#Contando proxies bloqueadas

echo ""
for x in $(wc -l proxies.txt)
do
        echo "⋄ | $x"
done

#Limpando lista de proxies antiga

rm -rf proxies.txt
