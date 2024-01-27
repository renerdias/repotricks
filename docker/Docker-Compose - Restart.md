https://www.anselme.com.br/2022/07/31/dicas-e-truques-no-uso-do-docker-compose/

Restart

É possível definir que o contêiner será reiniciado em algumas condições específicas. Esse recurso é importante para ambientes que não possuem um orquestrador (Docker Swarm ou Kubernets). Para mais informações consulte https://docs.docker.com/config/containers/start-containers-automatically/. Basicamente há quarto possíveis configurações para essa condição:

no -> Opção padrão. Nada acontece.

on-failure:n -> Após ocorrerem n falhas

always -> Sempre que ocorrer uma falha.

unless-stopped -> Igual ao always porém não reiniciando quando houver um stop manual no Docker.
