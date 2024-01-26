https://www.tabnews.com.br/seujorge/instalando-o-docker


Post Install

É importante em alguns sistemas operacionas proceder com o post install. O pós instalação do docker consiste basicamente em criar um grupo para gerenciar o docker e nos adicionar a esse grupo, assim sendo:

Para criar o grupo "docker" e adicionar o seu usuário:

    Crie o grupo "docker".

sudo groupadd docker

    Adicione o seu usuário ao grupo "docker".

sudo usermod -aG docker $USER

    Faça o logout e em seguida faça login novamente para que a sua adesão ao grupo seja reavaliada.

Você também pode executar o seguinte comando para ativar as alterações nos grupos:

newgrp docker

    Verifique se você pode executar comandos do Docker sem o uso do sudo.

 docker run hello-world

Este comando faz o download de uma imagem de teste e a executa em um contêiner. Quando o contêiner é executado, ele imprime uma mensagem e encerra.
Corrigindo erros

Se você inicialmente executou comandos do Docker CLI usando sudo antes de adicionar seu usuário ao grupo "docker", você pode encontrar o seguinte erro:

WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied

Esse erro indica que as configurações de permissão para o diretório ~/.docker/ estão incorretas devido ao uso anterior do comando sudo.

Para corrigir esse problema, você pode remover o diretório ~/.docker/ (ele será recriado automaticamente, mas as configurações personalizadas serão perdidas) ou alterar a propriedade e as permissões usando os seguintes comandos:

sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R

---
Configuirando o docker para iniciar com o systemd

Geralmente essa configuração é desnecessária pois na maioria das distribuições Linux modernas utilizam o systemd para gerenciar quais serviços iniciam quando o sistema é inicializado. No Debian e no Ubuntu, o serviço do Docker é iniciado automaticamente durante a inicialização por padrão. Para iniciar automaticamente o Docker e o containerd durante a inicialização em outras distribuições Linux que utilizam o systemd, execute os seguintes comandos:

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

Para interromper esse comportamento, utilize o comando "disable" em vez disso.

sudo systemctl disable docker.service
sudo systemctl disable containerd.service



---
Instalando o docker-compose

O Docker Compose é uma ferramenta desenvolvida pela Docker, Inc. que permite definir e gerenciar aplicações compostas por vários contêineres Docker. Ele é utilizado para simplificar o processo de orquestração de múltiplos serviços Docker, permitindo que você descreva a infraestrutura necessária para sua aplicação em um arquivo YAML.

Com o Docker Compose, você pode definir a estrutura da sua aplicação, incluindo os serviços, redes e volumes necessários para o funcionamento correto da aplicação. Cada serviço é geralmente executado em seu próprio contêiner Docker isolado, mas eles podem se comunicar entre si por meio das redes criadas pelo Docker Compose.

O arquivo YAML do Docker Compose é chamado de "docker-compose.yml" e nele você pode especificar as seguintes informações:

Serviços: Cada serviço representa um contêiner Docker que compõe sua aplicação. Por exemplo, um serviço pode ser o servidor web, outro pode ser o banco de dados e assim por diante.

Imagens: Você especifica a imagem Docker a ser usada para cada serviço. Essas imagens geralmente são hospedadas no Docker Hub ou em um registro de contêiner privado.

Redes: Você pode definir redes personalizadas para seus serviços, permitindo que eles se comuniquem entre si de maneira isolada.

Volumes: É possível especificar volumes que serão montados dentro dos contêineres para persistência de dados ou compartilhamento de arquivos com o host.

Variáveis de ambiente: O Docker Compose permite definir variáveis de ambiente que podem ser injetadas nos contêineres, facilitando a configuração de cada serviço.

Com o arquivo "docker-compose.yml" definido, você pode usar os comandos do Docker Compose para iniciar, parar, reiniciar, construir e gerenciar seus serviços e contêineres de forma simples e automatizada. Essa abordagem facilita a configuração de ambientes de desenvolvimento e produção, bem como a implantação de aplicações em diferentes sistemas.

Em resumo, o Docker Compose é uma ferramenta poderosa para definir, executar e gerenciar aplicativos compostos por múltiplos serviços em contêineres Docker, tornando a orquestração de aplicações mais fácil e escalável.

Para instalar basta executar o seguinte comando

 curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

Basicamente isso faz download do script do docker-compose e coloca no diretório /usr/local/bin/

Caso você tenha problemas de permissões, pode criar um link simbólico

 sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

Após a instalação, você pode checar se tudo correu bem:

docker-compose -v
docker-compose version 1.29.2, build unknown

Fontes:

https://docs.docker.com/engine/install/ubuntu/
https://docs.docker.com/engine/install/linux-postinstall/
https://docs.docker.com/compose/install/standalone/
