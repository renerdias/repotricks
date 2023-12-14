# PostgreSQL - Configuração

## 2. Configuração

### 2.1. Criar senha para usuario postgres

#### 2.1.1. Alterar a senha para conectar ao banco
```
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres'"
```

#### 2.1.2. Alterar a senha de usuário no SO, para o usuário 'postgres'
```
sudo passwd postgres
```
Após executar o comando aparecerão as seguintes mensagens:
```
Digite a nova senha UNIX:
Redigite a nova senha UNIX:
```


## 3. Liberar acesso remoto

### 3.1 No arquivo pg_hba.conf
   - No Ubuntu e derivados, normalmente está localizado em /etc/postgresql/$VERSION/main/pg_hba.conf
   - Você pode procurar usando o comando find / -name pg_hba.conf

Adicionar a linha abaixo
```bash
host    all             postgres        192.168.0.1/24          trust
```

### 3.2 No firewall

É necessário liberar a porta no firewall
```sh
sudo iptables -A INPUT -p tcp --dport 5432 -j ACCEPT
```

