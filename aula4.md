## Comando `insert`

No tutorial, o seguinte comando de inserção foi usado:

```SQL
insert into departments (name, location) values
   ('Finance','New York');

insert into departments (name, location) values
   ('Development','San Jose');
```

- Cada um destes `insert`s, insere uma linha de dados na tabela *departments*. Como é fornecida a lista de colunas para a inserção, só os valores das colunas *name* e *location* serão inseridos. Lembre-se, entretanto, que um **trigger** foi definido para a inserção de dados, se na inserção não é fornecido um valor para a coluna *deptno*, o **trigger** insere um número calculado pela função do sistema `sys_guid()`. No Oracle, é necessário um **insert** para cada linha, no MySQL e em alguns outros SGBDs, é possível inserir uma lista de linhas separadas por vírgulas.

## (cont.)

- Observe que os valores textuais (chamados de *string* s) são colocados entre apóstrofes. Alguns SGBDs aceitam também que as strings sejam colocadas entre aspas \("New York"\), mas o padrão no SQL é usar apóstrofes.

> Erro frequente de novatos em programação: esquecer os apóstrofes.

> Qual a consequência de esquecer os apóstrofes? Teste no Worksheet do livesql.

### Exercícios

1. Agora que você sabe inserir dados, insira algumas linhas suas.
2. O que acontece se você inserir a mesma linha mais de uma vez? Teste.

## Comando `select`

No tutorial, para visualizar que a inserção foi bem sucedida, usou-se o comando:

```SQL
select * from departments;
```

- Este comando está dizendo mostre todas as colunas da tabela se houver alguma linha de dado nela.

```SQL
select name, location from departments;
```

- Mostra apenas as colunas *name* e *location*.


## Modelo Entidade-Relacionamento (MER)

O projeto de um banco de dados passa pelo **modelamento dos dados**. O modelamento que usaremos para SGBDs relacionais é chamado de **Modelo Entidade-Relacionamento**. As tabelas representam Entidades quando os atributos dela estão ligadas a apenas um conceito.
Uma tabela de Relacionamento tem dados (atributos) que estão relacionando uma tabela a uma outra ou mais tabelas ou um outro tipo de conceito.

No exemplo das primeiras aulas, *Student* e *Course* são entidades, *Prerequisite* relaciona um *Course* com outro, *Section* relaciona *Course* com um semestre em que a disciplina é ministrada e *Grade_Report* relaciona um aluno com uma disciplina e a nota obtida.

## Passos a serem seguidos no projeto de um BD

1. Investigue e reflita sobre o ambiente de informações que você está modelando. De onde vêm as informações e em qual formato? Com que frequência ela muda? O que é mais crítico em termos de tempo de resposta e disponibilidade?

2. Faça uma lista das entidades com seus atributos ou propriedades. Você também pode listar todos os atributos (dados) antes e depois agrupá-los em entidades.

3. A medida que o trabalho avança, encontre uma maneira sistemática para registrar as decisões de projeto que você está fazendo, pode ser num papel ou num arquivo ou no Trello. Os projetistas começam, em geral, com listas e passam a esquemas das tabelas com os relacionamentos entre elas, estes esquemas  são chamados de diagramas de estruturas de dados ou entidade-relacionamento (diagrama MER ou simplesmente ER).

##

4. Uma vez que você decidiu preliminarmente sobre as entidades e seus atributos, assegure-se de que cada entidade tem um atributo ou um grupo de atributos que você pode usar no futuro para identificar unicamente uma linha na futura tabela. Se não houver tal atributo (que servirá de **chave primária**), você poderá inserir uma coluna artificial para tanto.

5. Agora, considere todos os relacionamentos entre as entidades. Elas são do tipo uma-para-muitas (um aluno cursa várias disciplinas num semestre), ou muitas-para-muitas, um autor pode escrever várias obras e uma obra pode ter vários autores. Você tem maneiras de juntar dados de um tabela com outras relacionadas? Isto é o que fornece as **chaves estrangeiras**.

6. Depois que você tiver um rascunho do projeto do BD, olhe para o todo e analise de acordo com as regras de normalização (que vamos ver) para encontrar erros lógicos. Corrija as violações ou decida mantê-las e documente o por quê desta decisão.

##

7. Agora ponha o BD no SGBD e insira alguns dados de teste. Tente gerar relatórios desejáveis.

8. Reavalie o que você fez, veja se os resultados são satisfatórios, se não recomece.

## Características de um bom projeto

- As interações com o BD são fáceis de entender;
- Garante a consistência do Banco de Dados e
- Cimenta o caminho para o máximo de desempenho que seu sistema pode oferecer.

## Características de um mal projeto

- Fornece respostas dúbias para consultas;
- Aumenta o risco de introdução de inconsistências nos dados;
- Força entradas de dados redundantes e
- Torna difícil sua vida se você precisar mudar a estrutura das tabelas que foram construídas e populadas.

## Exemplo: projeto do BD bookbiz

Bookbiz é um BD para uma pequena editora que tem 3 subsidiárias. O BD armazena informações que editores, administradores e executivos podem querem saber sobre livros, seus autores, seus editores e os acertos financeiros com a companhia. Ele pode produzir muitos tipos de relatórios resumindo as vendas atuais, comparação entre as subsidiárias, listagem dos editores trabalhando com quais autores, etc.

## Questões que o BD deve ser capaz de responder

- Quais autores moram em São Paulo?
- Quais livros de Computação custam mais do que R$ 49,00?
- Quem escreveu mais livros?
- Quanto devemos para o autor de *What is the name of this book?*?
- Qual o valor médio que é dado adiantado para todos os livros de pedagogia?
- Como vai afetar o pagamento dos *direitos autorais* se aumentarmos todos os livros de receitas em 10%?
- Como estão as vendas da subsidiária de Computação?

## Regras de negócio e políticas da organização que afetam os dados

- Um autor pode ter escrito um ou mais livros;
- Um livro pode ser o projeto colaborativo de mais de um autor;
- A ordem dos nomes dos autores na página de título é uma informação crítica, assim como os direitos autorais de cada um;
- Um editor pode está trabalhando em mais de um livro e um livro pode ter mais de um editor e
- Um pedido de venda pode ter mais de um título nele.

## Entidades para o BD de uma editora

Lista preliminar de entidades (sem preocupação com as informações financeiras):

- os **autores** que escreveram livros publicados pelas companhia;
- os **livros**;
- os **editores** que trabalham para a companhia e
- as **subsidiárias** da companhia.

Cada item desta lista é uma entidade com existência independente no mundo em questão. Cada qual terá uma tabela no BD.

## Atributos

Listagem de alguns atributos/propriedades:

- nome do livro
- preço do livro
- data da publicação do livro
- nome do autor
- endereço do autor
- número do telefone do autor
- nome do editor
- endereço do editor
- número do telefone do editor
- nome da subsidiária
- endereço da subsidiária

## Diagrama Entidade-Relacionamento

![Diagrama Entidade-Relacionamento bookbiz preliminar](preBD1.png)
