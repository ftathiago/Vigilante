# Vigilante

## O que é o vigilante?

Buscando uma maneira fácil de acompanhar o estado do build das versões e compilações específicas, criamos o Vigilante.

Para acompanhar o estado das compilações, é necessário apenas que o usuário informe ao **Vigilante** o link da compilação. Ele notificará o usuário, através das notificações do Windows, até que ele clique na notificação, ou a desligue na tela. Isso permite que, caso o usuário esteja distraído, ou longe do computador, seja informado imediatamente do _status_ das suas compilações.

## O que eu preciso para compilar o **Vigilante**?

Para compilar o projeto, será necessário ter configurado o spring4d - um framework de injeção de dependências para o Delphi.
O Spring4d está disponível gratuitamente em: https://bitbucket.org/sglienke/spring4d/src/master/

Para compilar os testes, estamos utilizando o [DUnitX](https://github.com/VSoftTechnologies/DUnitX) e o [Delphi-Mocks](https://https://github.com/VSoftTechnologies/Delphi-Mocks) todos disponíveis no repositório da [VSoft Technologies](https://github.com/VSoftTechnologies). E para análise de cobertura, estamos utilizando [esta versão do CodeCoverage](https://github.com/DelphiCodeCoverage/DelphiCodeCoverage.git).

Também estou utilizando o [TestInsight](https://bitbucket.org/sglienke/testinsight/issues/119/add-support-for-delphi-103). Um plugin para a IDE Rad Studio, que permite, entre outras coisas, gerenciar os testes de dentro da IDE e rodá-los em paralelo à codificação. Aconselho que a opção de compilação em background esteja ativa.

## Regras de visual e design

Para o design de interface, estamos usando apenas os componentes padrão da VCL, baseando nas guidelines https://docs.microsoft.com/pt-br/windows/uwp/design/. Isto claro, dentro das limitações da ferramenta, dando atenção especial para a tipografia - já que o Metro é basicamente tipográfico.

Pensando na portabilidade do projeto, está vedado o uso de componentes de terceiros. As exceções são abertas após analisadas o seu impacto no código da aplicação.

## Sobre a codificação

Qualquer pessoa que leia código, vai perceber a _overengineering_ que salta aos olhos. Isso é proposital. Por se tratar de um projeto de resolução simples e de regra de negócio bastante acessível, optamos por uma escrita cheia de padrões de projetos e outros conceitos teóricos, na esperança de que a aplicação sirva de exemplo e conteúdo para análise e estudos futuros.

Ainda assim, a aplicação precisa servir ao seu propósito inicial - que é ajudar aos usuários a acompanharem suas compilações no Jenkins. Por isso, alguns trechos de código podem não estar coesos, limpos ou até mesmo repetidos. Para esses casos, fica o convite para a refatoração e limpeza.

### Estilo de codificação e notação

O exerício de criar uma folha de estilos ainda será praticado, quando necessário. De modo geral, segue-se alguns padrões próprios da linguagem Delphi (Como "A" antecedendo nome de parâmetros e "F" antecedendo nome de variáveis de instância).

Para permitir a codificação em grupo, estamos passando a utilizar o GitFlow. https://medium.com/trainingcenter/utilizando-o-fluxo-git-flow-e63d5e0d5e04
