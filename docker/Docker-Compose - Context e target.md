https://www.anselme.com.br/2022/07/31/dicas-e-truques-no-uso-do-docker-compose/

Context e target

Em muitos casos o docker-compose carrega informações sobre uma imagem que se deseja dar build e não apenas de uma imagem pronta. Nesse caso basta adicionar uma entrada para build: imagem. Entretanto é possível ser mais específico, como no exemplo a seguir.

services:
  web:
    build:
      context: angular
      target: builder
    ports:
      - 4200:4200
    volumes:
      - ./angular:/project
      - /project/node_modules

Context -> é a pasta onde está o dockerfile em questão
Target -> qual será o estágio a ser gerado no multistage building

Veja o dockerfile do cenário

# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM node:17.0.1-bullseye-slim as builder
RUN mkdir /project
WORKDIR /project
RUN npm install -g @angular/cli@13
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
CMD ["ng", "serve", "--host", "0.0.0.0"]

FROM builder as dev-envs
RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends git
EOF

RUN <<EOF
useradd -s /bin/bash -m vscode
groupadd docker
usermod -aG docker vscode
EOF

COPY --from=gloursdocker/docker / /
CMD ["ng", "serve", "--host", "0.0.0.0"]
