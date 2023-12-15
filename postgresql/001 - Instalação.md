# PostgreSQL - Instalação / Configuração

Fonte: <a href="https://wiki.postgresql.org/wiki/Apt">https://wiki.postgresql.org/wiki/Apt</a>


## 1. Instalação

### 1.1. Verificando se existe uma instalação anterior do PostgreSQL:
```
???
```
e / ou
```
sudo apt-cache search ??? | grep postgresql --color
```

### 1.2. Instalando dependencias:
```
sudo apt-get install curl ca-certificates gnupg
```

### 1.3. Importando chave do repositório:
```
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```
ou
```
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```
Substituido por
```
curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/postgresql.gpg
```

### 1.4. Adicionando repositório ao sources.list:

`$(lsb_release -cs)` **Pode ser sustituído pelo codename da distro base (ubuntu/debian)**
```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
```

### 1.5. Atualizando lista de pacotes, e iniciando a instalação:
```
sudo apt-get update
sudo apt-get install postgresql -y
```

### 1.6. Verificar instalação
```
sudo systemctl status postgresql
```

