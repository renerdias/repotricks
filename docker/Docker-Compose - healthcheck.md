https://www.anselme.com.br/2022/07/31/dicas-e-truques-no-uso-do-docker-compose/

Comandos de healthcheck

Esse é um recurso fundamental que define condições de existência do contêiner. Uma ferramenta deve validar se o contêiner está ok e o Docker fará uso dessa ferramenta (ou linha de comando). Além disso há parâmetros como o intervalo entre as verificações, retentativas em caso de falha, a partir de quando começa e qual é o timeout. Veja o docker-compose.yml com o healthcheck.

services:
  web:
    build: app/aspnetapp
    ports:
      - 80:80
  db:
    environment:
      ACCEPT_EULA: "Y"
      SA_PASSWORD: example_123
 
    image: mcr.microsoft.com/azure-sql-edge:1.0.4

    restart: always
    healthcheck:
        test: ["CMD-SHELL", "/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P example_123 -Q 'SELECT 1' || exit 1"]
        interval: 10s
        retries: 10
        start_period: 10s
        timeout: 3s     

Service_healthy

É possível indicar que o contêiner tem como dependência a sua saúde. Esse é um item muito relevante que se conecta diretamente com a ideia do healthcheck. Utiliza-se assim:

# Desse modo o backend depende do serviço db estar saudável, caso contrário ele também estará falho
services:
  backend:
    depends_on:
      db:
        condition: service_healthy
