#!/bin/bash

#
#
# Criado por zGumeloBr
#
#

#Verificando dependências.
if [[ $EUID -ne 0 ]]; then
  echo -e "\033[1;31m * Esse script precisa ser executado em super usuário (sudo). \033[0m" 1>&2
  exit 1

fi

if ! [ -x "$(command -v wget)" ]; then
  echo -e "\033[1;31m * O comando (wget) não foi encontrado, por favor instale-o\033[0m"
  exit 1
fi

if ! [ -x "$(command -v iptables)" ]; then
  echo -e "\033[1;31m * O comando (iptables) não foi encontrado, por favor instale-o\033[0m"
  exit 1
fi

if ! [ -x "$(command -v ipset)" ]; then
  echo -e "\033[1;31m * O comando (ipset) não foi encontrado, por favor instale-o\033[0m"
  exit 1
fi

#Criando tabela para bloqueio.
ipset create zProxyFilter -exist hash:ip hashsize 9999999 maxelem 9999999 timeout 0

#Download das proxies.
wget -O proxies.txt https://api.zgsite.tech/proxies.txt
wget -O mproxies.txt https://api.zgsite.tech/mproxies.txt

#Compactando em 1 só arquivo.
cat mproxies.txt >> proxies.txt

#Implementando as regras no firewall.
for x in $(cat proxies.txt)
do
        ipset -A zProxyFilter $x
done
iptables -I INPUT -m set --match-set zProxyFilter src -j DROP

#Deletando arquivos após a instalação.
rm mproxies.txt
rm proxies.txt

#Atualização automatica de proxies.

timedatectl set-timezone America/Sao_Paulo

cd /home

touch crontab.txt

echo "2 12 * * * cd /home && sh coletor.sh" >> crontab.txt

crontab -i crontab.txt

wget -O coletor.sh https://api.zgsite.tech/updater.txt

chmod +x coletor.sh


#Módulo azure instalação.
echo -e "\033[1;34m* Você deseja ativar o módulo de bloqueio [Azure] ? \033[0m"
echo -e "\033[1;34m* Ative este recurso somente se não estiver hospedando seu projeto na azure.  \033[0m"
echo -e "\033[1;34m* Informações sobre: https://github.com/zGumeloBr/zPF-Azure-Module \033[0m"
echo -e -n "* Y = Sim N = Não (Y|N): "
read -r CONFIRM

if [[ "$CONFIRM" =~ [Yy] ]]; then
    wget -O azure.txt https://raw.githubusercontent.com/zGumeloBr/zPF-Azure-Module/main/azure.txt
    for x in $(cat azure.txt)
    do
            ipset -A zProxyFilter $x
    done
    iptables -I INPUT -m set --match-set zProxyFilter src -j DROP
    rm azure.txt
    clear
    echo ""
    echo ""
    echo -e "\033[1;34m ____  ____  ____  _____  _  _  _  _  ____  ____  __    ____  ____  ____ \033[0m"  
    echo -e "\033[1;34m(_   )(  _ \(  _ \(  _  )( \/ )( \/ )( ___)(_  _)(  )  (_  _)( ___)(  _ \ \033[0m" 
    echo -e "\033[1;34m / /_  )___/ )   / )(_)(  )  (  \  /  )__)  _)(_  )(__   )(   )__)  )   / \033[0m"
    echo -e "\033[1;34m(____)(__)  (_)\_)(_____)(_/\_) (__) (_)   (____)(____) (__) (____)(_)\_) \033[0m"
    echo ""
    echo -e "\033[0;37m❖ Proteção instalada com sucesso! Lembre-se sempre de acompanhar\033[0m"
    echo -e "\033[0;37matualizações em nosso github, assim sempre se mantendo protegido.\033[0m"
    echo ""
    echo -e "\033[1;33m❖ Módulos adicionais bloqueados:\033[0m"
    echo ""
    echo -e "\033[1;33m⋄ Azure\033[0m"
fi

if [[ "$CONFIRM" =~ [Nn] ]]; then
    clear
    echo ""
    echo ""
    echo -e "\033[1;34m ____  ____  ____  _____  _  _  _  _  ____  ____  __    ____  ____  ____ \033[0m"  
    echo -e "\033[1;34m(_   )(  _ \(  _ \(  _  )( \/ )( \/ )( ___)(_  _)(  )  (_  _)( ___)(  _ \ \033[0m" 
    echo -e "\033[1;34m / /_  )___/ )   / )(_)(  )  (  \  /  )__)  _)(_  )(__   )(   )__)  )   / \033[0m"
    echo -e "\033[1;34m(____)(__)  (_)\_)(_____)(_/\_) (__) (_)   (____)(____) (__) (____)(_)\_) \033[0m"
    echo ""
    echo -e "\033[0;37m❖ Proteção instalada com sucesso! Lembre-se sempre de acompanhar\033[0m"
    echo -e "\033[0;37matualizações em nosso github, assim sempre se mantendo protegido.\033[0m"
    echo ""
fi
