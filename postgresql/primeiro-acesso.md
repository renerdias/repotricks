Fazer o primeiro acesso e configurar senha

Acessar o bash (terminal, telinha preta dos hackers) e executar o comando:

sudo -i -u postgres

Este comando acima vai alterar o usuário do bash. Esse comando faz com que o sudo execute o comando especificado como um usuário diferente do root. Ao executar o comando vai perceber que o terminal agora é acessado com o usuário postgres. Isso é um pré-requisito para acessar a instância do banco de dados.
man page do comando sudo.

Após a execução desse comando será possível acessar a instância do banco de dados via linha de comando, utilizando o psql:

psql

Ao executar este comando já estará acessando a instância do banco de dados via o sgbd.

Agora será necessário criar uma senha para o usuário postgres (o usuário que está atualmente logado no banco de dados via o método de autenticação peer).

para criar a senha digite:

\password

Este comando será executado no prompt do psql. Vou ilustrar abaixo a saída do comando acima:

postgres=# \password
Enter new password: 
Enter it again: 

Após ter criado a senha, terminamos a configuração no sgbd, para sair digite o comando:

\q

Também é possível sair com o comando exit, aqui serei didático, não vou utilizar o exit, para não confundir.

Com esses passos terminamos a configuração da senha do usuário.

Agora será necessário sair da sessão (bash) do usuário postgres. Para isso basta executar o comando exit no terminal.

Este é um exemplo de execução no seu terminal, veja que ele está no seguinte estado,  e como ficará após a execução do comando exit.

postgres@<sistema>:~$
postgres@<sistema>:~$ exit
<usuario>@<sistema>:~$ 

Configurar pg_hba.conf

Agora vamos configurar o pg_hba.conf para mudar o método de autenticação para md5. Para isso você deve acessar o arquivo pg_hba.conf este arquivo varia de localização de acordo com a versão do postgres instalada em sua máquina, em meu exemplo estou utilizando a versão 13. (psql (PostgreSQL) 13.5 (Ubuntu 13.5-0ubuntu0.21.10.1)

Com base nesta informação acesse o diretório para acessar o arquivo pg_hba.conf

cd /etc/postgresql/<versão>/main
# para o meu caso seria:
# cd /etc/postgresql/13/main

Supondo que está no diretório correto, agora basta editar o arquivo pg_hba.conf os arquivo deste diretório só podem ser editados com permissão sudo use o seu editor favorito para editar o arquivo:

sudo vim pg_hba.conf

Esse arquivo possui por volta de 100 linhas e em sua maioria são comentários que explicam as possibilidades de autenticação. O que importa neste arquivo são as linhas que não estão comentadas, elas estão no final do arquivo.
Localize as seguintes linhas:

# Database administrative login by Unix domain socket
local   all             postgres                                peer

Agora basta substituir a palavra peer por md5

# Database administrative login by Unix domain socket
local   all             postgres                                md5

Após a mudança, salvar e sair.

Agora basta reiniciar a instância do banco de dados, para que as alterações tenham efeito:

sudo service postgresql restart

Testando o acesso com usuário e senha

psql -U postgres

Ao digitar este comando a senha será solicitada, basta preencher corretamente e poderá acessar o psql, agora com o método de autenticação usuário e senha. Repare que o argumento -U deve ser maiúsculo (uma versão mais verbosa poderia ser psql --username postgres). Consulte a documentação para mais opções.

Após fazer estes passos, é só configurar a sua aplicação com as credenciais corretas e será possível fazer o acesso à instância do banco de dados através da sua aplicação.
