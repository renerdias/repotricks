
> [!NOTE]
> Useful information that users should know, even when skimming content.

> [!TIP]
> Helpful advice for doing things better or more easily.

> [!IMPORTANT]
> Key information users need to know to achieve their goal.

> [!WARNING]
> Urgent info that needs immediate user attention to avoid problems.

> [!CAUTION]
> Advises about risks or negative outcomes of certain actions.


Listas de tarefas

Para criar uma lista de tarefas, coloque um hífen e um espaço seguidos de [ ] antes dos itens de lista. Para marcar uma tarefa como concluída, use [x].

- [x] #739
- [ ] https://github.com/octo-org/octo-repo/issues/740
- [ ] Add delight to the experience when all tasks are complete :tada:

Captura de tela mostrando a versão renderizada do markdown. As referências a problemas são renderizadas como títulos de problema.

Se a descrição de um item da lista de tarefas começar com parênteses, você precisará fazer escape dele com \:

- [ ] \(Optional) Open a followup issue



Sobre a criação de diagramas

Você pode criar diagramas em Markdown usando três sintaxes diferentes: mermaid, geoJSON e topoJSON e ASCII STL. A renderização do diagrama está disponível em GitHub Issues, GitHub Discussions, solicitações de pull, wikis e arquivos markdown.
Criando diagramas do mermaid

O Mermeid é uma ferramenta inspirada em Markdown que transforma texto em diagramas. Por exemplo, o Mermeid pode interpretar gráficos de fluxo, diagramas de sequência, gráficos de pizza e muito mais. Para obter mais informações, confira a documentação do Mermaid.

Para criar um diagrama do Mermaid, adicione a sintaxe do Mermaid dentro de um bloco de código isolado com o identificador de linguagem mermaid. Para saber como criar blocos de código, confira "Criar e realçar blocos de código".

Por exemplo, você pode criar um fluxograma especificando valores e setas.

Here is a simple flow chart:

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
