# Gerencie o Docker como um usuário não root

O daemon do Docker se liga a um soquete Unix, não a uma porta TCP. Por padrão, é o usuário root que possui o soquete Unix, e outros usuários só podem acessá-lo usando sudo. O daemon Docker sempre é executado como usuário root.


Se você não quiser preceder o comando docker com sudo, crie um grupo Unix chamado docker e adicione usuários a ele. Quando o daemon Docker é iniciado, ele cria um soquete Unix acessível aos membros do grupo docker. Em algumas distribuições Linux, o sistema cria automaticamente este grupo ao instalar o Docker Engine usando um gerenciador de pacotes. Nesse caso, não há necessidade de criar o grupo manualmente.




> [!WARNING]
> O grupo docker concede privilégios de nível raiz ao usuário. Para obter detalhes sobre como isso afeta a segurança do seu sistema, > consulte Docker Daemon Attack Surface.
>
> 

> [!Note]
> Para executar o Docker sem privilégios de root, consulte Executar o daemon do Docker como um usuário não root (Rootless mode).



Para criar o grupo docker e adicionar seu usuário:

  
## Crie o grupo docker.

```sh
 sudo groupadd docker
```

## Adicione seu usuário ao grupo docker.
```sh
 sudo usermod -aG docker $USER
```


## Saia e faça login novamente para que sua participação no grupo seja reavaliada.
> [!Note]
> Se você estiver executando o Linux em uma máquina virtual, pode ser necessário reiniciar a máquina virtual para que as alterações entrem em vigor.

Você também pode executar o seguinte comando para ativar as alterações nos grupos:
```sh
 newgrp docker
```

## Verifique se você pode executar comandos do docker sem sudo.
```sh
 docker run hello-world
```

Este comando baixa uma imagem de teste e a executa em um contêiner. Quando o contêiner é executado, ele imprime uma mensagem e sai.
Se você executou inicialmente comandos Docker CLI usando sudo antes de adicionar seu usuário ao grupo docker, poderá ver o seguinte erro:

WARNING: Error loading config file: /home/user/.docker/config.json -
stat /home/user/.docker/config.json: permission denied

Este erro indica que as configurações de permissão para o diretório ~/.docker/ estão incorretas, devido ao uso do comando sudo anteriormente.

Para corrigir esse problema, remova o diretório ~/.docker/ (ele é recriado automaticamente, mas todas as configurações personalizadas são perdidas) ou altere sua propriedade e permissões usando os seguintes comandos:


```sh
 sudo chown "$USER":"$USER" /home/"$USER"/.docker -R

     sudo chmod g+rwx "$HOME/.docker" -R
```
