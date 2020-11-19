## Subselect com IN no WHERE

```SQL
SELECT au_snome, au_pnome
FROM autores
WHERE cidade = 'New York'
AND au_id IN
  (SELECT au_id
   FROM tit_aut
   WHERE au_ord = 2);
```

## Subselect com NOT IN

```SQL
SELECT DISTINCT nome_subs
FROM subsidiarias
WHERE subs_id NOT IN
  (SELECT subs_id
   FROM titulos
   WHERE tipo = 'Computação');
```

## Subselect com ANY ou ALL

```SQL
SELECT titulo, preco
FROM titulos
WHERE preco > ALL
  (select preco
  FROM titulos
  WHERE tipo = 'Xadrez');
```

## Subselect que retorna só um valor

```SQL

```

## Com EXISTS

```SQL

```

## Transações em BDs

![Exemplo de uma transação bancária](transaction_example.gif)

## Transações com SQL da Oracle

- O SQL da Oracle não segue o padrão geral de SQL.
- No padrão do SQL, uma transação começa com o comando `BEGIN TRANSACTION` (ou apenas `BEGIN`).
- Os comandos após o `BEGIN` poderão ser cancelados com um `ROLLBACK`.
- Os comandos após o `BEGIN` tornam-se permanentes com um `COMMIT`.
- Os comandos no SGBD da Oracle realizam *autocommit* após cada comando.
- O equivalente ao `BEGIN TRANSACTION` no Oracle é `SET TRANSACTION`. Além disso, o Oracle permite nomear as transações e definir pontos de retorno (`SAVEPOINT`).
