


IMHO, It's actually better to create our own Docker image instead of relying on some third party for such trivial need. Supply chain security is already tricky enough.

Here is the content of my docker file PgClientDockerfile:

FROM alpine:3.15
RUN apk --no-cache add postgresql12-client
ENTRYPOINT [ "psql" ]

Here is an excerpt from my docker-compose.yml:

version: '3.7'
services:
  pg_client:
    environment:
      PGDATABASE: ${pg_database}
      PGHOST: ${pg_host}
      PGPORT: ${pg_port}
      PGUSER: ${pg_user}
      PGPASSWORD: ${pg_password}
    build:
      context: .
      dockerfile: PgClientDockerfile

I have an .env file with values like:

pg_database=mydb
pg_host=mydbhost
pg_port=5432
pg_user=myuser
pg_password=mypassword

And here is an example usage (for my use case):

#!/usr/bin/env bash

docker-compose run --rm pg_client -c 'drop trigger if exists my_trigger on my_table RESTRICT'
docker-compose run --rm another_docker_service ./run_batch_insert.sh
docker-compose run --rm pg_client -c 'create trigger my_trigger after insert or update or delete or truncate on my_table for each statement execute procedure refresh_my_table_finder()'

