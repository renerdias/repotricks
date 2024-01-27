
### Obter as informações básicas sobre a configuração do Docker executando o comando:
#### O resultado contém as informações sobre seu driver de armazenamento e sobre seu diretório raiz do Docker.
```sh
$ docker info
```
Exemplo de saída
```
Client:
 Version:    24.0.5
 Context:    default
 Debug Mode: false

Server:
 Containers: 26
  Running: 1
  Paused: 0
  Stopped: 25
 Images: 135
 Server Version: 24.0.5
 Storage Driver: zfs
  Zpool: rpool
  Zpool Health: ONLINE
  Parent Dataset: rpool/var/lib/docker
  Space Used By Parent: 2976002048
  Space Available: 205771878400
  Parent Quota: no
  Compression: lz4
 Logging Driver: json-file
 Cgroup Driver: systemd
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 
 runc version: 
 init version: 
 Security Options:
  apparmor
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 5.15.0-76-generic
 Operating System: Linux Mint 21.2
 OSType: linux
 Architecture: x86_64
 CPUs: 4
 Total Memory: 15.5GiB
 Name: desktop
 ID: 0df7d178-fd52-4ec5-8f1e-b4da7da7eea5
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Live Restore Enabled: false
```

