https://www.anselme.com.br/2022/07/31/dicas-e-truques-no-uso-do-docker-compose/

Uso do Dockerize

Não é incomum que na dependência entre contêineres seja necessário ter certeza se um deles efetivamente subiu ou não. O depends on não serve exatamente para isso: ele serve apenas para indicar a ordem de start dos containeres. A ferramenta dokerize segura o processo e não dá o ok para o Docker subir o próximo se os critérios configurados não estiverem validos.

Para usar o dockerize (https://github.com/jwilder/dockerize) é necessário criar um dockerfile que carregue essa dependência. O uso prático pode ser feito pelo dockerfile mas é mais fácil pelo docker-compose ao chamar essa imagem. Veja o exemplo a seguir:

# Dockerfile que baixa o dokerize
RUN apt-get update && apt-get install -y wget

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Esse é o entrypoint dentro do docker-compose.yml
# substitua o 'docker-entrypoint.sh' pelo entrypoint que quiser. 
#   Nesse caso uma maquina espera que o db esteja ativo na porta 3306, esperando por até 60s
entrypoint: dokerize -wait tcp://db:3306 -timeout 60s docker-entrypoint.sh
