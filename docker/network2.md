
InícioMicrosoft CloudDocker – Configurando a Rede [Tutorial]
Docker – Configurando a Rede [Tutorial]
17 de maio de 2017 Daniel Donda Microsoft Cloud 4

Neste artigo vamos criar uma rede e executar um container usando um endereço IP da rede criada. Por padrão o Docker executa os containers usando a rede NAT fornecendo um IP da rede 172.16.0.0/24). Em minha rede eu uso o DHCP e tenho a rede 192.168.0.0/24.

O comando para gerenciar rede no Docker é “docker network” seguido doss parâmetros:

    connect – Conecta uma rede a um container
    create  – Cria uma nova rede
    disconnect – Desconecta um container de uma rede
    inspect – Exibe informações detalhadas sobre uma ou mais redes
    ls – Lista as redes
    prune – Remove todas as redes não usadas
    rm – Remove uma ou mais redes

Existem vários tipos de redes:

    NAT – Ip dinâmico alocado pelo Host Networking Service (HNS) e usa uma subnet Interna
    Transparent – Endereço IP estático ou dinâmico (usando um DHCP existente externo)
    Overlay – Endereço IP dinâmico alocado pelo engine do Swarm
    L2 Bridge – Endereço IP estático de um conjunto de IPs do host de container ou através do HNS Plugin)
    L2 Tunnel – Apenas para Azure – Endereço dinâmico

Definindo uma rede transparente no Docker

Exemplo para definir uma rede transparente chamada redelocal e conectar um container a essa rede

docker network create -d transparent --subnet=192.168.0.0/24 --gateway=192.168.0.1 redelocal

Podemos então executar um container usando o endereço IP estático:

docker run --network=redelocal --ip 192.168.0.45 -it microsoft/windowsservercore cmd

Fontes: 
