
> [!CAUTION]
> # Apenas para uso em testes
>
  
  

> [!TIP]
> Caso ainda não tenha criado o usuário não root 'docker', use o sudo antes do termo 'docker'...

### 1º Excluir TODOS os containers, incluindo seus volumes usados
```
docker rm -vf $(docker ps -aq)
```

### 2º Excluir TODAS as imagens
Obs: A imagem não deve ser excluida, sem antes excluir os containers que a usam a imagem
```
docker rmi -f $(docker images -aq)
```
