
Diferença entre Ports e Expose

A exposição de portas para consumo externo é algo natural e desejado quando se publica containers docker. Entretanto há uma questão que, por vezes, gera alguma confusão nas pessoas: qual é a diferença entre PORTS e EXPOSE.

PORTS é a exposição de uma porta do container para uma porta da maquina host. Ele tem um propósito de acesso externo.

EXPOSE é a exposição de uma porta para as maquinas linkadas ao conteiner em questão. Vale notar que esse parâmetro é irrelevante tendo carater apenas ilustrativo nas versões mais recentes do docker.
