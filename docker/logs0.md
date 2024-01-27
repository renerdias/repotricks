https://medium.com/@gomex/logs-no-docker-c6f3c7fa6ee4

Logs no Docker
Rafael Gomes

Rafael Gomes
·

Follow
8 min read
·
Aug 24, 2017

Com o passar do tempo e as demandas de mercado, as aplicações têm ficado cada vez mais complexas, múltiplos serviços, e para gerenciar todo esse ambiente é necessário lidar com o volume de informações que esse conjunto pode gerar.

De acordo com wikipedia, logs de dados “é uma expressão utilizada para descrever o processo de registro de eventos relevantes num sistema computacional.”

Quando falamos de obter informações sobre nosso sistemas, analisar os logs é uma maneira bastante eficaz para um tratamento proativo de incidentes em seu ambiente, pois ao coletar registros em pontos distintos da sua arquitetura é possível correlacionar informações a fim de perceber anomalias antes que que o cliente perceba qualquer mal funcionamento.

Falaremos nesse artigo sobre tratamento de logs em um ecossistema de containers docker.
Tipos de logs

Vale salientar quais os tipos de logs podemos encontrar e como podemos organizá-los:
Logs de Infra do container

Eles são gerados pelos softwares que normalmente suportam a aplicação, um container de mysql em execução mostrará informações de seu funcionamento interno e quais possíveis erros está passando. É possível visualizar os logs do container mysql ao digitar esse comando em seu console com docker instalado:

docker container run -it mysql

Logs de app do container

Eles são gerados pela aplicação que foi executada a partir do código movido para o container. Vale atentar que essa aplicação precisará enviar o log para STDOUT/STDERR, pois o docker será responsável por coletar esses logs e dar devido tratamento a ele. De acordo com o 12factor, sua aplicação não deve ser preocupar com armazenamento de log, apenas jogue na console do container.

Para testar execute esse container e veja os logs produzidos pela aplicação dele:

docker container run -it hello-world

Logs do docker host

Esses são os logs que mais importam para o time de sustentação da infraestrutura docker, pois nele tem informações do tipo “level=warning msg=”Your kernel does not support swap memory limit”.

Essas informações são relevantes para uma manutenção e os maiores problemas arquiteturais serão obtidos nessa categoria.

Para ter acesso a esse log localmente em máquinas com systemd, basta digitar esse comando:

sudo journalctl -u docker.service

Log local ou remoto

Cada container que é iniciado no docker tem uma forma de gerenciar seus logs e por padrão os logs (tanto de infraestrutura ou aplicação) dele é armazenado em arquivos do tipo json.

Armazenar em json é um dos piores modelos, pois existe uma alta possibilidade desses arquivos consumirem todo espaço livre em disco e impactar negativamente na disponibilidade do mesmo. Isso pode ser evitado utilizando opções de max-size e max-file. Onde max-size especifica a quantidade máxima de cada arquivo json e o max-file a quantidade de arquivos que serão gerados até que o mais antigo seja reciclado. Perceba que utilizar apenas uma das opções não surtirá efeito no controle de uso indevido do espaço em disco, você precisa utilizar ambas (max-size e max-file).

Para iniciar um container com driver de log json com essas opções:

docker container -it -–log-driver json-file --log-opt max-size=10m --log-opt max-file=2 hello-world

É possível modificar o padrão de drivers de log, e assim não precisa dizer em cada container qual driver e opções serão utilizadas. Acesse o arquivo /etc/docker/daemon.json (Ao menos esse é o caminho do Debian) e modifique a seguinte configuração:

{ "log-driver": "json-file", "log-opts": { "max-size": "10m", “max-file”:”2” } }

Depois de modificar, você deve reiniciar o daemon do docker para que as novas definições sejam aplicadas. Depois dessa modificação e restart, os novos containers executados desde então terão limites de 10 megabytes e apenas 2 arquivos.
Perceba que até então o log será armazenado localmente, ou seja, caso esse host apresente problemas, perderemos todos os registros tanto da infra do container, como da aplicação que está nela hospedada e isso não é algo aceitável nos tempos modernos.

O docker tem outros drivers para armazenamento remoto, porém cada tipo tem suas vantagens e desvantagens:

Nome Vantagem Desvantagem none Ultra-secreto, pois não gera nenhum registro de log para ser obtido informação Difícil de realizar tratamento de problemas, uma vez que não há registro das falhas json-file O padrão. Suporto o uso do comando ‘docker logs’ e tags Logs armazenados locais e não agregados. Esses logs podem encher seu disco syslog Maioria dos hosts já contém syslog instalado. Suporta tag e com suporte a TLS no envio de logs Precisa de configuração de alta disponibilidade(HA) no serviço de syslog, pois em caso de falha de enviar logs para o servidor syslog, o container não inicia journald Suporta o uso do comando ‘docker logs’ e agregação de logs sem impacto Log binário, precisa de um trato extra para armazenamento externo e não suporta tag gelf Provê campos indexáveis por padrão (container id, host, container name, etc.) e suporte a tags Suporta apenas protocolo UDP, sem suporte ao comando ‘docker logs’ fluentd Provê os campos container_name e container_id por padrão, fluentd suporta multiples output Sem suporte ao comando ‘docker logs’ awslogs Fácil integração quando usado com AWS e suporte a tags Não ideal para ambientes multi-clouds e sem suporte ao comando ‘docker logs’ splunk Fácil integração com Splunk, suporte a envio de log com TLS, suporte a tags e métricas adicionais Sem suporte ao comando ‘docker logs’. Precisa de configuração de alta disponibilidade(HA), pois em caso de falha de enviar logs para o splunk, o container não inicia etwlogs Framework comum para log Windows. Valores indexáveis por padrão Apenas funciona para Windows gcplogs Fácil integração quando usado com Google Cloud e suporte a tags Não ideal para ambientes multi-clouds e sem suporte ao comando ‘docker logs’

Para exemplificar o uso de log remoto vamos usar o driver syslog, e para testar iniciaremos um syslog em um container docker para simular um serviço centralizado de log da sua rede.

Primeiro acesse novamente o arquivo /etc/docker/daemon.json e modifique a seguinte opção:

{ "log-driver": "syslog", "log-opts": {   "syslog-address": "udp://localhost:514" } }

Não esqueça de reiniciar o serviço docker desse host.

Agora vamos criar um arquivo chamado syslog-ng.conf com o seguinte conteúdo:

@version: 3.9 source s_net { udp( ip("0.0.0.0") ); syslog( ip("0.0.0.0") ); }; destination d_file { file("/var/log/test"); }; log {source(s_net); destination(d_file); };

Depois vamos executar o syslog com o seguinte comando:

sudo docker run -it -p 514:514/udp -p 601:601 -v "$PWD/syslog-ng.conf":/etc/syslog-ng/syslog-ng.conf balabit/syslog-ng:latest -edv

No console que iniciou o container do syslog você já verá o log de novos containers já enviado para esse serviço.
Docker service

Antes de falarmos sobre logs em contexto de cluster docker, vale a pena contextualizar como funciona o service do docker.

A forma convencional de se iniciar um container em um docker host é o comando “docker container run” e essa instrução é executada em um determinado servidor docker, mas quando estamos falando de cluster, a ideia de iniciar um container em um nó específico perde relevância, pois a ideia de ter um grupo de nós, é escalabilidade e alta disponibilidade.

No contexto de cluster, o container está incluído em uma estrutura mais complexa que permite abstração de onde o container será executado.

&nbsp;

A estrutura de organização funciona da seguinte forma:

    service: Na estrutura de organização, essa é a camada mais alto nível. Cada service contém N tasks.
    task: Camada de organização intermediária. Foi criada para abstrair uso de containers e outra coisa que há por vir (Unikernels?) o número de tasks é exatamente igual ao número de réplicas solicitadas no inicio do service ou igual ao número de nós, caso https://docs.docker.com/engine/admin/logging/log_tags/o service seja do tipo global.
    container: É o container que já conhecemos, ele é iniciado dentro da task

Como podem ver, ao criar um service você não tem controle direto do container, já que ele está contido em uma task, que por sua vez está dentro de um service.

Parece complicado, mas se lembrar que uma aplicação ao iniciar pode ter N cópias, em N nós diferentes, essa estruturação começa a fazer mais sentido. E quando se leva em consideração que os containers são de fato descartáveis, a ideia de gerir containers diretamente perde ainda mais relevância.

Para criar um service você pode utilizar o comando de exemplo abaixo:

docker service create --replicas 2 nginx

docker container logs VS docker service logshttps://docs.docker.com/engine/admin/logging/log_tags/

Basicamente o comando docker container logs só analisa dados armazenados locais em um determinado docker host, ou seja, como já vimos na tabela de drivers acima, alguns logs são enviados pela rede e por isso esse comando não é suportado para esses drivers.

O comando docker container logs obtém todos os dados enviados para STDOUT e STDERR do container. Isso quer dizer que se você envia seus logs para um arquivo específico, dentro de uma pasta qualquer, de seu container, esse comando não mostrará esse dados.

Se você utilizar o comando abaixo ele mostrará os logs enviados para console em tempo real:

docker container logs -f id_ou_nome_do_container

No caso do docker service logs funciona da maneira parecida, pegando os logs enviados para console apenas e sendo limitado pelos mesmos drivers de log do docker container logs, mas a diferença está no fato dele pegar os logs a nível service e task. Dessa forma você pode a nível de service perceber um problema e então “descer” para uma determinada task para isolar o comportamento.

Os logs obtidos com docker service logs são correspondentes a todos registros enviados para STDOUT e STDERR do service ou task em questão, não importando em qual nó eles estão.
Tags

Os logs obtidos, tanto por docker container logs ou docker service logs, são exibidos da seguinte maneira por padrão:

Aug 7 18:33:19 HOSTNAME 5790672ab6a0[9103]: Hello from Docker.

O ID 5790672ab6a0 corresponde a identificação de 12 dígitos do container, que no contexto de uma máquina pessoal, ou apenas um docker host dedicado a hospedar esse serviço, é mais do que suficiente para um tratamento de problema pontual.

Agora imagine esse mesmo log em uma arquitetura de múltiplos nós, com vários serviços, cada um com diversas réplicas dispostas em vários docker hosts distintos. Um caos, certo? Você não terá ideia onde está o problema, já que o ID de um container em um nível de gerência que sua visualização é de service. Para resolver esse problema e identificar o problema de uma forma mais eficaz deve ser fazer o uso de tags.

Para usar tags basta utilizar a opção do seu driver de log escolhido, no caso de um exemplo utilizando o fluentd ficaria da seguinte forma:

docker container run --log-driver=fluentd --log-opt fluentd-address=myhost.local:24224 --log-opt tag="mailer" hello-world

Com essa opção o log teria a seguinte saída:

Aug 7 18:33:19 HOSTNAME mailer[9103]: Hello from Docker.

Pode ser utilizado algumas marcações especiais para construção dessas tags:

Marcação Descrição {{.ID}} Os 12 primeiros caracteres do ID do container {.FullID}} O ID completo do container {{.Name}} O nome do container {{.ImageID}} Os 12 primeiros caracteres do ID da imagem do container {{.ImageFullID}} O ID completo da imagem do container {{.DaemonName}} O nome do programa docker (docker)

Segue abaixo um exemplo utilizando essa marcação:

docker container run --log-driver=fluentd --log-opt fluentd-address=myhost.local:24224 --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}" hello-world

A saída de log seria assim:

Aug 7 18:33:19 HOSTNAME hello-world/foobar/5790672ab6a0[9103]: Hello from Docker.

É possível configurar tags padrão no arquivo /etc/docker/daemon.json, junto a configuração do driver já apresentado anteriormente nesse capítulo:

{ "log-driver": "gelf", "log-opts": { "gelf-address": "udp://1.2.3.4:12201", "tag":"{{.ImageName}}/{{.Name}}/{{.ID}}" } }

Fontes

https://success.docker.com/Architecture/Docker_Reference_Architecture%3A_Docker_Logging_Design_and_Best_Practices
https://docs.docker.com/engine/reference/commandline/service_logs/
https://docs.docker.com/engine/admin/logging/overview/
https://logz.io/blog/docker-swarm-logging/
https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/#tasks-and-scheduling
https://docs.docker.com/engine/admin/logging/log_tags/
