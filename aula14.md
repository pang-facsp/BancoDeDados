## Join

- Precisamos realizar a operação de `JOIN` quando $\rightarrow$ temos mais de uma tabela no `FROM`.
- A operação DE `JOIN` ocorre com as condições na clausura `WHERE` com as operações de `JOIN` entre as **colunas de conexão**.
- Para obter um bom `JOIN`:
  - uma coluna de conexão deve ser uma coluna chave na sua tabela, pode ser *primária* ou *estrangeira*.
  - quando uma chave é composta (como as chaves estrangeiras da tabela tit_aut), você terá de fazer `join` com todas as colunas da chave.
- Colunas que participam do `join` devem ter o mesmo tipo, ou tipos similares que podem ser convertidos.
- As colunas de conexão não precisam ter o mesmo nome.
- Para melhorar a legibilidade dos `joins` use apelidos curtos para as tabelas.

## Exemplo 1

```SQL
select au_snome, au_pnome
from autores a, subsidiarias s
where a.cidade = s.cidade
```

- Observe que neste caso, as duas tabelas não têm relacionamentos entre elas e que não foram usadas chaves na operação de `join`. Apenas queremos os autores que moram na mesma cidade de uma subsidiária.

## Exemplo 2

```SQL
select distinct a1.au_pnome, a1.au_snome, a1.cidade
from autores a1, autores a2
where a1.au_id != a2.au_id
and a1.cidade = a2.cidade
```

- O que faz esta instrução?
- Observe que temos um caso de `JOIN` de uma tabela com ela mesma.

## `JOIN` a esquerda

- Um tipo de `join` diferente é o join a esquerda (**`LEFT JOIN`**). Neste `join`, quando a condição de `join` não é atendida (verdadeira), as colunas da linha da tabela à esquerda são colocadas na resposta e as colunas da tabela à direita são marcadas com `NULL`.

```SQL
select distinct a1.au_pnome, a1.au_snome, a1.cidade
from autores a1 left join autores a2
on a1.cidade = a2.cidade
where a1.au_id != a2.au_id
```
