## Sintaxe do SELECT

- A sintaxe completa do `SELECT` é:

```SQL
SELECT [ALL | DISTINCT] lista_de_seleções
  FROM {nome-tabela | nome-vista}
    [, {nome-tabela | nome-vista}] ...
  [WHERE condições-de-busca]
  [GROUP BY nome-coluna [, nome-coluna]  ...]
    [HAVING condições-de-busca]
  [ORDER BY {nome-coluna | número-da-seleção}] [ASC | DESC]
    [, {nome-coluna | número-da-seleção}] [ASC | DESC] ...]
```

## Lista de seleções

- A lista_de_seleções não é apenas uma lista de nomes de colunas como vimos na
aula passada. Além do nome das colunas podemos realizar operações com os valores das colunas selecionadas.
- Por exemplo, no lugar de obtermos separadamente o prenome e o sobrenome dos autores, vimos que é possível juntá-los com a operação de concatenação `||`.

`select au_pnome, au_snome ...` $\rightarrow$

`select au_pnome || ' ' || au_snome AS Nome ...`

- Podemos também realizar operações aritméticas com os números: `preco * 1.2`

##

- Os modificadores opcionais `ALL` e `DISTINCT` são importantes, em algumas ocasiões, queremos as repetições dos valores de modo que saibamos quantas vezes eles estão repetidos. Por exemplo, se pedimos todos os autores na tabela tit_aut, vamos descobrir quais são os livros com mais de um autor pela repetição. Em outras ocasiões, nos contentamos com os valores sem as repetições. O padrão (quando não se coloca nada) é o `ALL` está subentendido.

## Sintaxe do `ORDER BY`

- Frequentemente, precisamos que as linhas da resposta estejam ordenadas, fazemos isto com o `ORDER BY`
- Exemplo a lista de títulos ordenada é dada por:

```SQL
select titulo from titulos order by titulo
```

- Teste usando `ASC` e `DESC`.

## Mais ordens

- Ao ordenar por uma coluna, pode ser que vários valores sejam iguais, se houver mais colunas, elas pode ser usadas para *desempate* (critérios secundários de ordenação)
- Exemplo:

```SQL
select titulo, autor from titulos, autores, tit_aut
where titulos.tit_id = tit_aut.tit_id and autores.au_id = tit_aut.au_id
order by titulos DESC, autores ASC
```
