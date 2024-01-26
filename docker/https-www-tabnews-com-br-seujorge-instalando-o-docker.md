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




