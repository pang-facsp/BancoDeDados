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

-- insert into autores values (42, 'Silva', 'Jose da', '+55 11 454545', 'rua boa vista, 555', 'São Paulo', 'SP', '01000000');

select au_pnome, au_snome, fone as Telefone from autores;

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

insert into editores values (42, 'Oliveira', 'Antonio da', '+55 11 424242', 'rua boa vista, 555', 'São Paulo', 'SP', '01000000');

select * from editores;

create table subsidiarias (
	subs_id number,
	nome_subs varchar2(120) not null,
	endereco varchar2(80) not null,
	cidade varchar2(16),
	estado char(2),
	cep char(8),
	constraint subsidiarias_pk primary key(subs_id)
);

insert into subsidiarias values (1, 'Livros de Computação', 'rua da Consolação, 54', 'São Paulo', 'SP', '01111000');
select * from subsidiarias;

create table titulos (
	tit_id number,
	titulo varchar2(120) not null,
	tipo varchar2(24),
	subs_id number,
	preco number(7,2),
	avanco number(7,2),
	qtdd_vendas number(6),
	contrato number not null,
	notas varchar2(1024),
	data_pub date,
	constraint titulos_pk primary key(tit_id),
	constraint titulos_fk foreign key(subs_id) references subsidiarias
);

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

insert into titulos values (1, 'What is the name of this book?', 'Lógica', 1, 20.50, 0, 5, 1, 'Lógica para todos.', '1978-1-1');

select * from titulos;

create table vendas (
  ven_num number,
  loja_id number,
  po_num number,
  data date not null,
  constraint vendas_pk primary key(ven_num)
);
insert into vendas values (777, 2, 4545, '2020-09-23');
select * from vendas;

create table tit_aut ( 
  au_id number, 
  tit_id number, 
  au_ord number(2), 
  dir_aut number(7,2), 
  constraint tit_aut_pk primary key(au_id, tit_id), 
  constraint tit_aut_fk1 foreign key(au_id) references autores, 
  constraint tit_aut_fk2 foreign key(tit_id) references titulos 
);

-- insert into tit_aut values (42, 1, 1, 0.02);

select * from tit_aut;

create table tit_editores (
  ed_id number,
  tit_id number,
  ed_ord number(2),
  constraint tit_editores_pk primary key(ed_id, tit_id),
  constraint tit_editores_fk1 foreign key(ed_id) references editores,
  constraint tit_editores_fk2 foreign key(tit_id) references titulos
);
 
insert into tit_editores values (42, 1, 1);
 
select * from tit_editores;
 
create table det_vendas (
  ven_num number,
  qtdd_pdd number(3),
  qtdd_evd number(3),
  tit_id number,
  data_env date,
  constraint det_vendas_pk primary key(ven_num, tit_id),
  constraint det_vendas_fk1 foreign key(tit_id) references titulos,
  constraint det_vendas_fk2 foreign key(ven_num) references vendas
);

insert into det_vendas values (777, 5, 3, 1, '2020-09-23');

select * from det_vendas;

create table dir_autorais (
  tit_id number,
  inferior number(7),
  superior number(7),
  direito number(5,2),
  constraint dir_autorais_pk primary key(tit_id, direito),
  constraint dir_autorais_fk foreign key(tit_id) references titulos
);

insert into dir_autorais values (1, 101, 1000, 5.00);
insert into dir_autorais values (1, 1001, 10000, 7.00);

select * from dir_autorais;

/* Comentario estilo C
 * Do tutorial de SQL do livesql da Oracle: exemplo de trigger
   create or replace trigger  DEPARTMENTS_BIU
        before insert or update on DEPARTMENTS
        for each row
    begin
        if inserting and :new.deptno is null then
            :new.deptno := to_number(sys_guid(), 
             'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        end if;
    end;
 */
-- vamos criar triggers para as chaves primárias das tabelas de entidades

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

create or replace trigger editores_biu
  before insert or update on editores
  for each row
begin
  if inserting and :new.ed_id is null then
    :new.ed_id := to_number(sys_guid(),
	   'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
  end if;
end;
/

create or replace trigger subsidiarias_biu
  before insert or update on subsidiarias
  for each row
begin
  if inserting and :new.subs_id is null then
    :new.subs_id := to_number(sys_guid(),
	   'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
  end if;
end;
/

create or replace trigger titulos_biu
  before insert or update on titulos
  for each row
begin
  if inserting and :new.tit_id is null then
    :new.tit_id := to_number(sys_guid(),
	   'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
  end if;
end;
/

create or replace trigger vendas_biu
  before insert or update on vendas
  for each row
begin
  if inserting and :new.ven_num is null then
    :new.ven_num := to_number(sys_guid(),
	   'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
  end if;
end;
/

-- alguns autores

insert into autores (au_pnome, au_snome, cidade)
  values ('Raymond', 'Smullyan', 'Princeton');
insert into autores (au_pnome, au_snome, cidade)
  values ('Judith S.','Bowman','New York');
insert into autores (au_pnome, au_snome, cidade)
  values ('Sandra L.','Emerson','New York');
insert into autores (au_pnome, au_snome, cidade)
  values ('Marcy','Darnovsky','Los Angeles');
insert into autores (au_pnome, au_snome, cidade,estado)
  values ('Machado','de Assis','Rio de Janeiro','RJ');
insert into autores (au_pnome, au_snome, cidade)
  values ('Douglas','Adams','Londres');
insert into autores (au_pnome, au_snome, cidade)
  values ('Hans','Kmoch','New York');
insert into autores (au_pnome, au_snome, cidade)
  values ('Anton','Tchekhov','Moscou');
insert into autores (au_pnome, au_snome, cidade)
  values ('George','Gamow','Boulder');
insert into autores (au_pnome, au_snome, cidade)
  values ('Max','Euwe','Amsterdam');
insert into autores (au_pnome, au_snome, cidade)
  values ('David','Hooper','Reigate');
insert into autores (au_pnome, au_snome, cidade)
  values ('Mark','Dvoretsky','Moscou');
insert into autores (au_pnome, au_snome, cidade)
  values ('Thomas H.','Cormen','Hanover');
insert into autores (au_pnome, au_snome, cidade)
  values ('Charles E.','Leiserson','Cambridge');
insert into autores (au_pnome, au_snome, cidade)
  values ('Ronald L.','Rivest','Cambridge');
insert into autores (au_pnome, au_snome, cidade)
  values ('Clifford','Stein','Hanover');
insert into autores (au_pnome, au_snome, cidade,estado)
  values ('Paulo','Freire','São Paulo','SP');
insert into autores (au_pnome, au_snome, cidade,estado)
  values ('Nivio','Ziviani','Belo Horizonte','MG');

-- alguns editores

insert into editores (ed_pnome, ed_snome, cidade)
  values ('Kathleen','Tibbetts','Boston');
-- todo livro com editor desconhecido é dele
insert into editores (ed_pnome, ed_snome, cidade)
  values ('José','da Silva','Belo Horizonte');

-- algumas subsidiárias

insert into subsidiarias (nome_subs, endereco, cidade)
  values ('Computação','Av. Paulista, 1024','São Paulo');
insert into subsidiarias (nome_subs, endereco, cidade)
  values ('Ficção','Rua XV de novembro, 154','Itu');
insert into subsidiarias (nome_subs, endereco, cidade)
  values ('Romances','Av. Copacabana, 2020','Rio de Janeiro');
insert into subsidiarias (nome_subs, endereco, cidade)
  values ('Xadrez','Praça da República, 60','Salvador');

-- alguns titulos

insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('The Practical SQL Handbook: Using Structured Query Language','Computação',
    (select subs_id from subsidiarias where nome_subs = 'Computação'), 1, 50.00, 5000, 1000);
insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('Endgame Manual','Xadrez', 
    (select subs_id from subsidiarias where nome_subs = 'Xadrez'), 1, 35, 1000, 2000);
insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('Memórias Póstumas de Brás Cubas','',
   (select subs_id from subsidiarias where nome_subs = 'Romances'), 1, 10, 100, 100000);
insert into titulos (titulo, tipo, subs_id, contrato, preco, qtdd_vendas)
  values ('A guide to chess endings','Xadrez',
   (select subs_id from subsidiarias where nome_subs = 'Xadrez'), 1, 10, 2000);
insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('O incrível mundo da Física Moderna','Física',
   (select subs_id from subsidiarias where nome_subs = 'Ficção'), 1, 10, 500, 500);
insert into titulos (titulo, tipo, subs_id, contrato, preco, qtdd_vendas)
  values ('Rubinstein''s Chess Masterpieces/100 selected games','Xadrez',
   (select subs_id from subsidiarias where nome_subs = 'Xadrez'), 1, 10, 200);
insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('Pedagogia da autonomia','Educação',
   (select subs_id from subsidiarias where nome_subs = 'Computação'), 1, 10, 100, 20000);
insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('Introduction to Algorithms','Computação',
   (select subs_id from subsidiarias where nome_subs = 'Computação'), 1, 70, 2000, 1000);
insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('The Hitch Hicker Guide To The Galaxy','Ficção',
   (select subs_id from subsidiarias where nome_subs = 'Ficção'), 1, 10, 100, 3000);
insert into titulos (titulo, tipo, subs_id, contrato, preco, qtdd_vendas)
  values ('O assassino e outras histórias','Ficção',
   (select subs_id from subsidiarias where nome_subs = 'Ficção'), 1, 8, 500);
insert into titulos (titulo, tipo, subs_id, contrato, preco, avanco, qtdd_vendas)
  values ('Projeto de Algoritmos com implementação em Java e C++','Computação',
   (select subs_id from subsidiarias where nome_subs = 'Computação'), 1, 35, 1000, 1500);

-- titulos - autores

insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Bowman'),
          (select tit_id from titulos where titulo like '%SQL Handbook%'), 1);
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Emerson'),
          (select tit_id from titulos where titulo like '%SQL Handbook%'), 2);
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Darnovsky'),
          (select tit_id from titulos where titulo like '%SQL Handbook%'), 3);

insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_snome = 'de Assis'),
          (select tit_id from titulos where titulo like '%Brás Cubas%'));
insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_snome = 'Freire'),
          (select tit_id from titulos where titulo like 'Pedagogia%'));
		  
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Cormen'),
          (select tit_id from titulos where titulo like '%Algorithms'), 1);
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Leiserson'),
          (select tit_id from titulos where titulo like '%Algorithms'), 2);
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Rivest'),
          (select tit_id from titulos where titulo like '%Algorithms'), 3);
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Stein'),
          (select tit_id from titulos where titulo like '%Algorithms'), 4);

insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_snome = 'Ziviani'),
          (select tit_id from titulos where titulo like '%Algoritmos%'));
		  
insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_snome = 'Smullyan'),
          (select tit_id from titulos where titulo like 'What%'));

insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_snome = 'Adams'),
          (select tit_id from titulos where titulo like '%Hicker%'));

insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_pnome = 'Anton'),
          (select tit_id from titulos where titulo like '%assassino%'));
		  
insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_pnome = 'Mark'),
          (select tit_id from titulos where titulo like '%Manual%'));
		  
insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_snome = 'Gamow'),
          (select tit_id from titulos where titulo like '%Física%'));
		  
insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Euwe'),
          (select tit_id from titulos where titulo like '%endings%'), 1);

insert into tit_aut (au_id, tit_id, au_ord)
  values ((select au_id from autores where au_snome = 'Hooper'),
          (select tit_id from titulos where titulo like '%endings%'), 2);

insert into tit_aut (au_id, tit_id)
  values ((select au_id from autores where au_snome = 'Kmoch'),
          (select tit_id from titulos where titulo like '%Rubinstein%'));


-- titulos - editores

insert into tit_editores (ed_id, tit_id)
  values ((select ed_id from editores where ed_pnome = 'Kathleen'),
          (select tit_id from titulos where titulo like '%SQL Handbook%'));

insert into tit_editores (ed_id, tit_id)
  values ((select ed_id from editores where ed_snome = 'da Silva'),
          (select tit_id from titulos where titulo like '%Algorithms'));
insert into tit_editores (ed_id, tit_id)
  values ((select ed_id from editores where ed_snome = 'da Silva'),
          (select tit_id from titulos where titulo like '%Algoritmos%'));

-- vendas

insert into vendas (loja_id, po_num, data)
  values (555, 456, '2020-09-30');

insert into vendas (loja_id, po_num, data)
  values (555, 457, '2020-10-01');

-- detalhes das vendas

insert into det_vendas (ven_num, tit_id, qtdd_pdd)
  values ((select ven_num from vendas where po_num = 456),
  (select tit_id from titulos where titulo like 'Pedagogia%'), 3);
insert into det_vendas (ven_num, tit_id, qtdd_pdd)
  values ((select ven_num from vendas where po_num = 456),
  (select tit_id from titulos where titulo like 'Memórias%'), 2);
  
insert into det_vendas (ven_num, tit_id, qtdd_pdd)
  values ((select ven_num from vendas where po_num = 457),
  (select tit_id from titulos where titulo like 'Pedagogia%'), 2);

update titulos
  set subs_id = (select subs_id from subsidiarias where nome_subs = 'Computação')
  where titulo like 'What%';
 
