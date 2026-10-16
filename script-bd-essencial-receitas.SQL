CREATE TABLE ingredientes(
 id_ingrediente SERIAL PRIMARY KEY,
 nome varchar (100) not null,
 categoria varchar (50) not null,
 unidade_medida_padrao varchar (20) not null

CREATE TABLE receita (
  id_receita SERIAL PRIMARY KEY,
  id_autor_chef int,
  titulo varchar(150) not null,
  modo_preparo text not null,
  tempo_preparo_minutos int not null,
  nivel_dificuldade varchar (255),
  eh_exclusive_premium boolean,
  data_cadastro timestamp

create table public.mercado_parceiro (
  id_mercado integer not null,
  nome character varying(100) not null,
  categoria character varying(50) not null,
  unidade_medida_padrao character varying(20) not null,
  constraint mercado_parceiro_pkey primary key (id_mercado)
) TABLESPACE pg_default;
