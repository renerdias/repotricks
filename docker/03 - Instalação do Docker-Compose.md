---
Instalando o docker-compose

O Docker Compose é uma ferramenta desenvolvida pela Docker, Inc. que permite definir e gerenciar aplicações compostas por vários contêineres Docker. Ele é utilizado para simplificar o processo de orquestração de múltiplos serviços Docker, permitindo que você descreva a infraestrutura necessária para sua aplicação em um arquivo YAML.

Com o Docker Compose, você pode definir a estrutura da sua aplicação, incluindo os serviços, redes e volumes necessários para o funcionamento correto da aplicação. Cada serviço é geralmente executado em seu próprio contêiner Docker isolado, mas eles podem se comunicar entre si por meio das redes criadas pelo Docker Compose.

O arquivo YAML do Docker Compose é chamado de "docker-compose.yml" e nele você pode especificar as seguintes informações:

Serviços: Cada serviço representa um contêiner Docker que compõe sua aplicação. Por exemplo, um serviço pode ser o servidor web, outro pode ser o banco de dados e assim por diante.

Imagens: Você especifica a imagem Docker a ser usada para cada serviço. Essas imagens geralmente são hospedadas no Docker Hub ou em um registro de contêiner privado.

Redes: Você pode definir redes personalizadas para seus serviços, permitindo que eles se comuniquem entre si de maneira isolada.

Volumes: É possível especificar volumes que serão montados dentro dos contêineres para persistência de dados ou compartilhamento de arquivos com o host.

Variáveis de ambiente: O Docker Compose permite definir variáveis de ambiente que podem ser injetadas nos contêineres, facilitando a configuração de cada serviço.

Com o arquivo "docker-compose.yml" definido, você pode usar os comandos do Docker Compose para iniciar, parar, reiniciar, construir e gerenciar seus serviços e contêineres de forma simples e automatizada. Essa abordagem facilita a configuração de ambientes de desenvolvimento e produção, bem como a implantação de aplicações em diferentes sistemas.

Em resumo, o Docker Compose é uma ferramenta poderosa para definir, executar e gerenciar aplicativos compostos por múltiplos serviços em contêineres Docker, tornando a orquestração de aplicações mais fácil e escalável.

Para instalar basta executar o seguinte comando

 curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

Basicamente isso faz download do script do docker-compose e coloca no diretório /usr/local/bin/

Caso você tenha problemas de permissões, pode criar um link simbólico

 sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

Após a instalação, você pode checar se tudo correu bem:

docker-compose -v
docker-compose version 1.29.2, build unknown

Fontes:

https://docs.docker.com/engine/install/ubuntu/
https://docs.docker.com/engine/install/linux-postinstall/
https://docs.docker.com/compose/install/standalone/
