Fonte: https://docs.docker.com/engine/install/debian/#uninstall-docker-engine

<br/><br/>

> [!TIP]
> ### Pode parecer estranho o 1º passo ser a desinstalação, mas ignore, caso não tenha versões anteriores instaladas
>

<br/><br/>

# Uninstall Docker Engine

## Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages:
```sh
 sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
```

Desinstalando versões antigas

Versões anteriores do Docker eram conhecidas como docker, docker.io ou docker-engine. Você também pode ter instalações de containerd ou runc.

Desinstale todas essas versões anteriores antes de tentar instalar uma nova versão.
```sh
sudo apt-get remove docker docker-engine docker.io containerd runc
```
```sh
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

## Images, containers, volumes, or custom configuration files on your host aren't automatically removed. To delete all images, containers, and volumes:
```
 sudo rm -rf /var/lib/docker

 sudo rm -rf /var/lib/containerd
```
