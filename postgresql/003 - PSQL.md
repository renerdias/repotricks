# PostgreSQL -PSQL

## 3. PSQL

### 3.1. Logar como postgres no SO
```
sudo su postgres
```

### 3.2. Importar DUMP 

#### 3.2.1. Importar banco de dump SEM **create database**
psql -f nomebanco < file.sql

#### 3.2.2. Importar banco de dump COM **create database**
psql -f file.sql



### 3.3. Criar banco
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


### 3.1.2. Excluir banco
```
dropdb teste01
```

### 3.1. Listar bases de dados
```
\list ou \l
```



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
