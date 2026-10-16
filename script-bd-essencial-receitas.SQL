create table public.mercado_parceiro (
  id_mercado integer not null,
  nome character varying(100) not null,
  categoria character varying(50) not null,
  unidade_medida_padrao character varying(20) not null,
  constraint mercado_parceiro_pkey primary key (id_mercado)
) TABLESPACE pg_default;



