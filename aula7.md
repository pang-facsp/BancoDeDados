## Implementação do BD bookbiz

![Banco de Dados bookbiz.](bizBD.png)

## Criação das tabelas das Entidades

- Olhando para o diagrama do BD `bookbiz` crie as tabelas `autores`, `editores`, `subsidiarias`, `titulos` e `vendas`.
- Insira dados para ir testando.


## autores

![Autores.](autores.png)

## Código

```SQL
create table autores (
	au_id number,
	au_snome varchar2(20) not null,
	au_pnome varchar2(80),
	fone varchar2(16),
	endereco varchar2(80),
	cidade varchar2(16),
	estado char(2),
	cep char(8),
	constraint autores_pk primary key(au_id)
);
```

### Teste
```SQL
insert into autores values (42, 'Silva', 'Jose da',
  '+55 11 454545', 'rua boa vista, 555', 'São Paulo',
  'SP', '01000000');
select au_pnome, au_snome, fone as Telefone from autores;
```

## editores

![Editores.](editores.png)

## Código

```SQL
create table editores (
	ed_id number,
	ed_snome varchar2(20) not null,
	ed_pnome varchar2(80),
	fone varchar2(16),
	endereco varchar2(80),
	cidade varchar2(16),
	estado char(2),
	cep char(8),
	constraint editores_pk primary key(ed_id)
);
insert into editores values (42, 'Oliveira', 'Antonio da',
  '+55 11 424242', 'rua boa vista, 555', 'São Paulo', 'SP', '01000000');
select * from editores;
```

## subsidiarias

![Subsidiárias.](subsidiarias.png)

## Código

```SQL
create table subsidiarias (
	subs_id number,
	nome_subs varchar2(120) not null,
	endereco varchar2(80) not null,
	cidade varchar2(16),
	estado char(2),
	constraint subsidiarias_pk primary key(subs_id)
);
insert into subsidiarias values (1, 'Livros de Computação',
   'rua da Consolação, 54', 'São Paulo', 'SP');
select * from subsidiarias;
```

## titulos

![Títulos.](titulos.png)

## Código

```SQL
create table titulos (
	tit_id number,
	titulo varchar2(120) not null,
	tipo varchar2(24),
	subs_id number,
	preco number(7,2),
	avanco number(7,2),
	qtdd_vendas number(6),
	contrato number,
	notas varchar2(1024),
	data_pub date,
	constraint titulos_pk primary key(tit_id),
	constraint titulos_fk foreign key(subs_id) references subsidiarias
);
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
insert into titulos values (1, 'What is the name of this book?', 'Lógica', 1, 50.10, 0, 5, 1, 'Lógica para todos.', '1978-1-1');
select * from titulos;
```

## vendas

![Vendas.](vendas.png)

## Código

```SQL
create table vendas (
  ven_num number,
  loja_id number,
  po_num number,
  data date not null,
  constraint vendas_pk primary key(ven_num)
);
insert into vendas values (777, 2, 4545, '2020-09-23');
select * from vendas;
```

## tit_aut

![Títulos-autores.](tit_aut.png)

## Código

```SQL
create table tit_aut (
  au_id number,
  tit_id number,
  au_ord number(2),
  dir_aut number(7,2),
  constraint tit_aut_pk primary key(au_id, tit_id),
  constraint tit_aut_fk1 foreign key(au_id) references autores,
  constraint tit_aut_fk2 foreign key(tit_id) references titulos
);

insert into tit_aut values (42, 1, 1, 0.02);

select * from tit_aut;
```
