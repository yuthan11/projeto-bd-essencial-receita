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


CREATE TABLE usuario(
 id_usuario SERIAL PRIMARY KEY,
 nome varchar(100) not null,
 email varchar(100) not null,
 senha_hash varchar(255) not null,
 cpf_criptografado varchar(255) not null,
 tipo_perfil varchar(255) not null,
 data_nascimento date not null, 
 idioma_preferido varchar(5),
 eh_assinante_premium  boolean,
 termo_lgpd_aceito boolean not null,
 data_criacao timestamp
);

create table public.despesa_virtual (
  id_despesa serial not null,
  fk_despesa integer null,
  fk_ingrediente integer null,
  quantidade numeric(10, 2) null,
  unidade_medida character varying(20) null,
  data_atualizacao timestamp without time zone null,
  constraint despesa_virtual_pkey primary key (id_despesa)
) TABLESPACE pg_default;

create table public.estoque (
  id_estoque serial not null,
  id_mercado integer not null,
  id_inrediente integer not null,
  preco_unitario numeric(10, 2) not null,
  quantidade_disponivel numeric(10, 2) not null,
  constraint estoque_pkey primary key (id_estoque)
) TABLESPACE pg_default;

create table public.item_pedido (
  id_item_pedido serial not null,
  fk_pedido integer null,
  fk_ingrediente integer null,
  quantidade numeric(10, 2) null,
  preco_unitario numeric(10, 2) null,
  foi_substituido boolean null,
  constraint item_pedido_pkey primary key (id_item_pedido)
) TABLESPACE pg_default;


CREATE TABLE cupom_desconto(
 id_cupom SERIAL PRIMARY KEY,
 id_mercado int,
 codigo_cupom  varchar(30) not null,
 percentual_desconto  decimal(5,2),
 valor_desconto_fixo  decimal(10,2),
 data_validade   timestamp not null,
 ativo  boolean
);

SELECT * FROM cupom_desconto; 

