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





O acesso remoto ao PostgreSQL vem desabilitado por padrão. Para habilitá-lo, siga os passos abaixo:

1) Faça o login no servidor onde o PostgreSQL está instalado
2) Edite o arquivo /var/lib/pgsql/data/pg_hba.conf ou /etc/postgresql/8.2/main/pg_hba.conf, caso a versão for a 8.2 ou superior e adicione o seguinte para liberar acesso à rede desejada:

host all all 10.10.29.0/24 trust (altere para a rede que você deseja liberar acesso)

3) Salve e feche o arquivo

4) Edite o arquivo de configuração do PostgreSQL var/lib/pgsql/data/postgresql.conf ou /etc/postgresql/8.2/main/postgresql.conf

5) Encontre a linha listen_addresses=’localhost’ e altere para * para ouvir em todos os ips

6) Salve e feche o arquivo

7) Reinicie o PostgreSQL com o comando abaixo:

# /etc/init.d/postgresql restart

8) Certifique-se de que o iptables não está bloqueando o acesso à porta 5432. Para garantir, adicione as linhas abaixo no arquivo /etc/sysconfig/iptables (para RHEL)

Passo 5: Make sure iptables is not blocking communication, open port 5432 (append rules to your iptables scripts or file /etc/sysconfig/iptables):

iptables -A INPUT -p tcp -s 0/0 –sport 1024:65535 -d 10.10.29.50 –dport 5432 -m state –state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s 10.10.29.50 –sport 5432 -d 0/0 –dport 1024:65535 -m state –state ESTABLISHED -j ACCEPT

9) Reinicie o firewall com o comando abaixo:

# /etc/init.d/iptables restart

10) Faça um teste de acesso com o comando abaixo:

$ psql -h IP_DO_SERVIDOR -U USUARIO -d DATABASE
