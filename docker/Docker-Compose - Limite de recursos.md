https://www.anselme.com.br/2022/07/31/dicas-e-truques-no-uso-do-docker-compose/

Limites de recursos

Uma questão importante é a definição dos limites de consumo dos conteineres. Quando não há configuração que limite ele pode consumir 100% dos recursos do computador host. Para fazer a configuração é importante atentar-se às possibilidades: limits é o valor máximo, reservation é o valor mínimo caso seja necessário (se a maquina estiver consumindo menos do que isso, o recurso não fica preso); além disso é possível definir quantidade de CPU, RAM, Swap, memória para o Kernel, e outras particularidades. Para mais detalhes consulte https://docs.docker.com/config/containers/resource_constraints/. Veja a seguir um docker-compose.yml de exemplo.

 services:

  meuservico:
    image: nginx
    deploy:
        resources:
            limits:
              cpus: 0.50
              memory: 512M
            reservations:
              cpus: 0.25
              memory: 128M

Para ver em tempo real como está a utilização dos recursos do docker utilize o comando:

 docker stats 
