Fonte: https://docs.docker.com/engine/install/debian/#uninstall-docker-engine

<br/><br/>

> [!TIP]
> ### Pode parecer estranho o 1º passo ser a desinstalação, mas ignore, caso não tenha versões anteriores instaladas
>

<br/><br/>

# Desinstalação do Docker

## Desinstalando o Docker Engine, CLI, containerd, and Docker Compose packages:
Versões anteriores do Docker eram conhecidas como docker, docker.io ou docker-engine. 
Você também pode ter instalações de containerd ou runc.
Desinstale todas essas versões anteriores antes de tentar instalar uma nova versão.
```sh
 sudo apt-get purge docker docker-engine docker.io containerd runc docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
```
ou
```sh
for pkg in docker docker-engine docker.io containerd runc docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras; do sudo apt-get remove $pkg; done
```

Docker-compose ::

## Imagens, contêineres, volumes ou arquivos de configuração personalizados em seu host não são removidos automaticamente. 
Para excluir todas as imagens, contêineres e volumes:
```
 sudo rm -rf /var/lib/docker

 sudo rm -rf /var/lib/containerd
```
