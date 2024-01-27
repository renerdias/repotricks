
# Apenas para uso em testes
Unix

1º To delete all containers including its volumes use,

docker rm -vf $(docker ps -aq)

2º To delete all the images,
Obs: A imagem não deve ser excluida, sem antes excluir os containers que a usam a imagem

docker rmi -f $(docker images -aq)
