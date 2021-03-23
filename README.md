<img src="https://i.imgur.com/eD9dvqC.png">

![](https://imgur.com/a/YOJPzUH)

# Informações

🛡 O zProxyFilter e um sistema que faz a coleta automatica de proxys do tipo SOCKS4, SOCKS5, HTTPS e HTTP e faz o bloqueio utilizando as ferramentas `IPTABLES e IPSET` assim criando uma proteção a mais em sua maquina, o proxyfilter faz uma coleta de 20mil+ proxies a cada execução, recomendamos executar nosso script todo dia, assim atualizando a lista de proxys bloqueadas em seu firewall.

# Funcionamento

📡 Nosso script funciona com dois sistemas que chamamos de `MPB e APB` que realizam a coleta de grandes quantidades de proxys, disponibilizadas por sites de terceiros, mas como esses sistemas funcionam ? Leia a baixo a rápida explicação deles:

**❖ APB (Automatic Proxy Blocker):**

O APB funciona coletando autoamticamente proxys de sistes como `ProxyScraper, Github, TOR` e outros, assim de forma automatica bloqueando todas as proxys coletadas, atualmente coletamos de 16 locais as proxies bloqueadas.

**❖ MPB (Manual Proxy Blocker):**

O MPB consiste em uma forma de coleta de proxys manual realizada por nossos desenvolvedores, que a cada 24H realizam uma coleta rigorosa de proxys que não podem se obitidas e forma automaticas automatica, assim nosso script sempre que iniciado irá fazer a copia das proxys coletadas e bloquar respectivamente elas.

# Sistemas compatíveis

| Sistemas | Versões | Compatibilidade |
|----------|---------|-----------------|
| Ubuntu   | 20.04   | ✅              |
|          | 18.04   | ✅              |
| CentOS   | 8       | ✅              |
|          | 7       | ✅              |
| Debian   | 10      | ✅              |
|          | 9       | ✅              |
|          | 8       | ✅              |

# Como utilizar

⌨️ Para utilizar o script é super fácil, basta digitar os comandos a baixo que o programa será executado automaticamente.

<pre>
  <code>root@server:~# git clone https://github.com/zGumeloBr/zProxyFilter.git</code>
</pre>

<pre>
  <code>root@server:~# bash ./zProxyFilter.sh</code>
</pre>

# Contato

`Discord:` zGumeloBr#8726

# Contribuidores

oagiota: Contribuição de proxies.<p></p>
https://github.com/oagiota

