Fonte: https://docs.docker.com/engine/install/debian/

# Pre-requisitos

> [!NOTE]
>
> Se você usa ufw ou firewalld para gerenciar configurações de firewall, esteja ciente de que quando você expõe portas de contêiner usando Docker, essas portas ignoram suas regras de firewall.
>    

<br><br><br>
> [!NOTE]
> Desinstalar versoes antigas, ver arquivo de desinstalação
<br><br><br>



  


> [!CAUTION]
> Verificar o uso do docker.io do debian/ubuntu ao invés do docker-ce do docker.com
> 
---
# Instalar usando um repositório
  
## Configurando o repositório do Docker

### Adicione a chave GPG oficial do Docker:
```sh
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

### Adicione o repositório às fontes do Apt:
```sh
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

> [!NOTE]
> 
> Se você usa uma distribuição derivada, como Kali Linux, pode ser necessário substituir a parte deste comando que deve imprimir o codinome da versão:
> 
>  (. /etc/os-release && echo "$VERSION_CODENAME")
>
> Substitua esta parte pelo codinome da versão Debian correspondente, como bookworm.
>

<br><br>
## Instale os pacotes do Docker.

### Para instalar a versão mais recente, execute:
```sh
 sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Verifique se a instalação foi bem-sucedida executando a imagem hello-world:
```
 sudo docker run hello-world
```

Este comando baixa uma imagem de teste e a executa em um contêiner. Quando o contêiner é executado, ele imprime uma mensagem de confirmação e sai.


