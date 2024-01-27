
# Configure o Docker para iniciar na inicialização com systemd

Muitas distribuições modernas do Linux usam o systemd para gerenciar quais serviços são iniciados quando o sistema é inicializado. 

No Debian e Ubuntu, o serviço Docker inicia na inicialização por padrão. 


Para iniciar automaticamente o Docker e o containerd na inicialização de outras distribuições Linux usando systemd, execute os seguintes comandos:

```sh
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

Para interromper esse comportamento, use desativar.
```sh
sudo systemctl disable docker.service
sudo systemctl disable containerd.service
```

