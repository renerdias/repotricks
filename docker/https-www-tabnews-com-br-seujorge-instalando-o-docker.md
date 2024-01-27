https://www.tabnews.com.br/seujorge/instalando-o-docker


Post Install


---
Configuirando o docker para iniciar com o systemd

Geralmente essa configuração é desnecessária pois na maioria das distribuições Linux modernas utilizam o systemd para gerenciar quais serviços iniciam quando o sistema é inicializado. No Debian e no Ubuntu, o serviço do Docker é iniciado automaticamente durante a inicialização por padrão. Para iniciar automaticamente o Docker e o containerd durante a inicialização em outras distribuições Linux que utilizam o systemd, execute os seguintes comandos:

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

Para interromper esse comportamento, utilize o comando "disable" em vez disso.

sudo systemctl disable docker.service
sudo systemctl disable containerd.service




