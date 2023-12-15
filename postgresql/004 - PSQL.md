# PostgreSQL -PSQL

## 4. PSQL

### 4.1. Logar como postgres no SO
```
sudo su postgres
```

### 4.2. Importar DUMP 

#### 4.2.1. Importar banco de dump SEM **create database**
```
psql -f nomebanco < file.sql
psql --dbname=escola --filename=rh.sql
```
#### 4.2.2. Importar banco de dump COM **create database**
```
psql -f file.sql
```


### 4.3. Criar banco

```
createdb -h localhost -p 5432 -E UTF8 --echo --encoding=UTF8 --lc-ctype='pt_BR.UTF-8' --lc-collate='pt_BR.UTF-8' escola "Banco de informações escolares."
```
```sh
!/bin/bash

# 1. CRIAR BANCO DE DADOS

# \set ON_ERROR_STOP true

# Exclui o banco de dados, caso exista
dropdb escola --echo --if-exists
echo
echo

# Cria o banco de dados
createdb \
    -h localhost \
    -p 5432 \
    -E UTF8 \
    --echo \
    --encoding=UTF8 \
    --lc-ctype='pt_BR.UTF-8' \
    --lc-collate='pt_BR.UTF-8' \
    escola "Banco de informações institucionais."
echo
echo
```


### 4.1.2. Excluir banco
```
dropdb teste01
```

### 4.1. Listar bases de dados
```
\list ou \l
```

https://www.datacamp.com/tutorial/10-command-line-utilities-postgresql?utm_source=google&utm_medium=paid_search&utm_campaignid=19589720824&utm_adgroupid=157156376591&utm_device=c&utm_keyword=&utm_matchtype=&utm_network=g&utm_adpostion=&utm_creative=683184495242&utm_targetid=dsa-2218886984820&utm_loc_interest_ms=&utm_loc_physical_ms=20094&utm_content=&utm_campaign=230119_1-sea~dsa~tofu_2-b2c_3-row-p2_4-prc_5-na_6-na_7-le_8-pdsh-go_9-na_10-na_11-na-dec23&gad_source=1&gclid=EAIaIQobChMIkqGlv_qQgwMVfF5IAB0qaAACEAAYASAAEgI5aPD_BwE


entrar no banco com psql
$ psql teste01
teste01=# \l

# Com usuário postgres
psql -U postgres -d rh -a -f 2-create-schema.sql


psql -f /some/path/my_script_name.sql

Options for the ‘psql’ command to run a SQL file in Postgres
Following is a brief explanation of each of the options, or flags, used for the psql command that will execute the SQL script file:

psql -U USER_NAME_HERE — The -U flag is used to specify the user role that will execute the script. This option can be omited if this option’s username is the first parameter. The default username is the system’s current username, if one has not been explicitly specified.

psql -h 127.0.0.1 — The -h flag is for the remote host or domain IP address where the PostgreSQL server is running. Use 127.0.0.1 for a localhost server.

psql -d some_database — The -d option is used for the database name.

psql -a — The -a or --echo-all flags will print all of the lines in the SQL file that conatin any content.

psql -f /some/path/my_script_name.sql — The -f option will instruct psql to execute the file. This is arguably the most critical of all the options.

Execute the SQL file in PostgreSQL from the terminal
The final step in this process is to execute the file using the psql command while connecting with an username, host and database. Note that this example uses the objectrocket role.

The following command can be used to access the test.sql file created earlier:

1
psql objectrocket -h 127.0.0.1 -d some_database -f test.sql

Use the ‘-a’ option to print everything while executing a SQL file in Postgres
The -a option, also referred to as the --echo-all option, is used to echo, or print, all of the input lines that contain any content. This includes the SQL comments and the original SQL commands or statements being executed.

The following is an example of the --echo-all option:

1
psql objectrocket -h 127.0.0.1 -d some_database -f -a test.sql
The results should resemble the following:
