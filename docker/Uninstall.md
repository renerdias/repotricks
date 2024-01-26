# Uninstall Docker Engine

## Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages:
```sh
 sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
```

## Images, containers, volumes, or custom configuration files on your host aren't automatically removed. To delete all images, containers, and volumes:
```
 sudo rm -rf /var/lib/docker

 sudo rm -rf /var/lib/containerd
```