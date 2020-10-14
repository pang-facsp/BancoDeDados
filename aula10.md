## Triggers

```SQL
create or replace trigger autores_biu
  before insert or update on autores
  for each row
  begin
    if inserting and :new.au_id is null then
      :new.au_id := to_number(sys_guid(),
	     'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
  end;
/
```

## Explicação

Este *trigger* dispara quando se tenta inserir dados ou modificar a tabela **`autores`**. Quando novos dados são inseridos, o trigger roda o código em PL/SQL da Oracle que começa na linha `for each row`. Esta linha de código diz para cada linha deve ser executado o código que está entre o `begin` e `end`. Este código diz que se uma inserção está sendo feita e não existe valor para a coluna **au_id**, então deve ser gerado um número pela chamada da função sys_guid() que retorna um número binário muito grande. A função `to_number()` converte  o número binário em um número decimal com 32 dígitos.

- Fazemos um trigger para cada tabela de entidade, nos mesmos moldes.

## Inserção de Dados das entidades

```SQL
insert into autores (au_pnome, au_snome, cidade)
  values ('Judith S.','Bowman','New York');

insert into editores (ed_pnome, ed_snome, cidade)
  values ('Kathleen','Tibbetts','Boston');

insert into subsidiarias (nome_subs, endereco, cidade)
  values ('Computação','Av. Paulista, 1024','São Paulo');

insert into titulos (titulo, tipo, subs_id, contrato)
  values ('The Practical SQL Handbook: Using Structured Query Language','Computação',
    (select subs_id from subsidiarias where nome_subs = 'Computação'), 1);

insert into vendas (loja_id, po_num, data)
  values (555, 456, '2020-09-30');
```

## Inserção de Dados dos relacionamentos

```SQL
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Bowman'),
          (select tit_id from titulos where titulo like '%SQL Handbook%'), 1);

insert into tit_editores (ed_id, tit_id)
  values ((select ed_id from editores where ed_pnome = 'Kathleen'),
          (select tit_id from titulos where titulo like '%SQL Handbook%'));

insert into det_vendas (ven_num, tit_id, qtdd_pdd)
  values ((select ven_num from vendas where po_num = 456),
          (select tit_id from titulos where titulo like 'Pedagogia%'), 3);

```
