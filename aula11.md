## Revisão: operação de **join**

- Num banco de dados relacional, podemos trabalhar com várias tabelas ao mesmo tempo.
- No **´SELECT´** para trabalharmos com várias tabelas simultaneamente, basta colocar uma lista de tabelas depois do **`FROM`**:

```SQL
select <lista_de_colunas>
from <lista_de_tabelas>
where <condicional>
```

- Ao colocar uma lista de tabelas no `FROM`, o banco de dados relacional combina todas as tabelas (em teoria dos conjuntos, os matemáticos dizem que o produto cartesiano é realizado).
- Para eliminar as combinações que não fazem sentido, precisamos fazer a operação de **`JOIN`** (juntar) as tabelas. Isto é feito colocando na condição do `WHERE` que existem colunas com valores interligados. Isto é, a chave primária de uma tabela é igual (deve ser igual) à chave estrangeira de uma outra tabela.

## Exemplo: para saber quem escreveu um livro com a palavra Handbook no título fazemos:

```SQL
select au_pnome, au_snome
from autores, titulos, tit_aut
where
  upper(titulo) like '%HANDBOOK%' and
  titulos.tit_id = tit_aut.tit_id and
  autores.au_id = tit_aut.au_id;
```

- Esta instrução pede para o BD mostrar o prenome e sobrenome do autor dos livros que têm a palavra *HANDBOOK* no título.
- A função `upper()` converte o texto da coluna `titulo` para maiúsculas, o operador `like` permite comparar a string com o metacaracter `%` que significa *vários ou nenhum caracter qualquer*. Assim, a comparação deve ser lida como *um título com a palavra handbook em qualquer posição e independente de maiúsculas, ou minúsculas*.

## Exercícios

1. Inserir dados que estão faltado para alguns livros
2. Fazer algumas consultas (queries)
