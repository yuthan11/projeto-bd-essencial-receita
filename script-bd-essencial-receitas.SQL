CREATE TABLE public.ingrediente (
    id_ingrediente serial not null,
    nome  varchar(100) not null,
    categoria  varchar(50) not null,
    unidade_medida_padrao varchar(20) not null,
    constraint ingrediente_pkey primary key (id_ingrediente)
) 

INSERT INTO public.ingrediente (nome, categoria, unidade_medida_padrao) VALUES
('Arroz branco', 'Grãos', 'kg'),
('Feijão carioca', 'Grãos', 'kg'),
('Farinha de trigo', 'Farinhas', 'kg'),
('Açúcar refinado', 'Açúcares', 'kg'),
('Sal', 'Temperos', 'kg'),
('Óleo de soja', 'Óleos', 'litro'),
('Leite integral', 'Laticínios', 'litro'),
('Ovos', 'Proteínas', 'unidade'),
('Frango (peito)', 'Proteínas', 'kg'),
('Carne moída', 'Proteínas', 'kg'),
('Tomate', 'Vegetais', 'kg'),
('Cebola', 'Vegetais', 'kg'),
('Alho', 'Temperos', 'kg'),
('Batata', 'Vegetais', 'kg'),
('Cenoura', 'Vegetais', 'kg'),
('Macarrão', 'Massas', 'kg'),
('Queijo mussarela', 'Laticínios', 'kg'),
('Manteiga', 'Laticínios', 'kg'),
('Fermento em pó', 'Outros', 'unidade'),
('Café em pó', 'Bebidas', 'kg');

SELECT* FROM public.ingrediente;

CREATE TABLE public.mercado_parceiro (
    id_mercado integer not null,
    nome character varying(100) not null,
    categoria character varying(50) not null,
    unidade_medida_padrao character varying(20) not null,
    constraint mercado_parceiro_pkey primary key (id_mercado)
) TABLESPACE pg_default;

create table public.usuario (
  id_usuario serial not null,
  nome character varying(100) not null,
  email character varying(100) not null,
  senha_hash character varying(255) not null,
  cpf_criptografado character varying(255) not null,
  tipo_perfil character varying(255) not null,
  data_nascimento date not null,
  idioma_preferido character varying(5) null,
  eh_assinante_premium boolean null,
  termo_lgpd_aceito boolean not null,
  data_criacao timestamp without time zone null,
  constraint usuario_pkey primary key (id_usuario)
) TABLESPACE pg_default;

INSERT INTO public.usuario (
  nome,
  email,
  senha_hash,
  cpf_criptografado,
  tipo_perfil,
  data_nascimento,
  idioma_preferido,
  eh_assinante_premium,
  termo_lgpd_aceito,
  data_criacao
) VALUES
(
  'Ana Silva',
  'ana.silva@email.com',
  '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
  'encrypted_cpf_12345678901',
  'cliente',
  '1995-03-15',
  'pt-BR',
  true,
  true,
  NOW()
),
(
  'Carlos Mendes',
  'carlos.chef@email.com',
  '$2a$10$X8pL2mK9qR7vT4wY6nB3sA1cD5eF8gH0jK2lM4nP6qR8sT0uV2wX4yZ6',
  'encrypted_cpf_98765432100',
  'chef',
  '1988-07-22',
  'pt-BR',
  true,
  true,
  NOW()
),
(
  'Juliana Costa',
  'juliana.costa@email.com',
  '$2a$10$A1b2C3d4E5f6G7h8I9j0K1l2M3n4O5p6Q7r8S9t0U1v2W3x4Y5z6',
  'encrypted_cpf_11122233344',
  'cliente',
  '2001-11-08',
  'pt-BR',
  false,
  true,
  NOW()
),
(
  'Pedro Almeida',
  'pedro.entregador@email.com',
  '$2a$10$B2c3D4e5F6g7H8i9J0k1L2m3N4o5P6q7R8s9T0u1V2w3X4y5Z6a7',
  'encrypted_cpf_55566677788',
  'entregador',
  '1992-01-30',
  'pt-BR',
  false,
  true,
  NOW()
),
(
  'Mariana Oliveira',
  'mariana.oliveira@email.com',
  '$2a$10$C3d4E5f6G7h8I9j0K1l2M3n4O5p6Q7r8S9t0U1v2W3x4Y5z6A7b8',
  'encrypted_cpf_99988877766',
  'cliente',
  '1998-09-12',
  'pt-BR',
  true,
  true,
  NOW()
);

SELECT*FROM public.usuario

CREATE TABLE public.receita (
    id_receita SERIAL PRIMARY KEY,
    id_autor_chef int,
    titulo varchar(150) not null,
    modo_preparo text not null,
    tempo_preparo_minutos int not null,
    nivel_dificuldade varchar(50),
    eh_exclusive_premium boolean,
    data_cadastro timestamp
);

-- ====================== TABELAS FILHAS (conectadas ao usuario) ======================

CREATE TABLE public.pedido (
    id_pedido serial not null,
    id_usuario integer not null,
    data_pedido timestamp not null,
    status varchar(50) not null,
    valor_total numeric(10,2) not null,
    constraint pedido_pkey primary key (id_pedido),
    constraint fk_pedido_usuario foreign key (id_usuario)
        references usuario(id_usuario) on update cascade on delete restrict
);

CREATE TABLE public.despesa_virtual (
    id_despesa serial not null,
    fk_pedido integer null,
    fk_ingrediente integer null,
    quantidade numeric(10, 2) null,
    unidade_medida character varying(20) null,
    data_atualizacao timestamp without time zone null,
    constraint despesa_virtual_pkey primary key (id_despesa),
    constraint fk_despesa_virtual_pedido foreign key (fk_pedido)
        references pedido(id_pedido) on update cascade on delete restrict,
    constraint fk_despesa_virtual_ingrediente foreign key (fk_ingrediente)
        references ingrediente(id_ingrediente) on update cascade on delete restrict
) TABLESPACE pg_default;

CREATE TABLE public.estoque (
    id_estoque serial not null,
    id_mercado integer not null,
    id_ingrediente integer not null,
    preco_unitario numeric(10, 2) not null,
    quantidade_disponivel numeric(10, 2) not null,
    constraint estoque_pkey primary key (id_estoque),
    constraint fk_estoque_mercado foreign key (id_mercado)
        references mercado_parceiro(id_mercado) on update cascade on delete restrict,
    constraint fk_estoque_ingrediente foreign key (id_ingrediente)
        references ingrediente(id_ingrediente) on update cascade on delete restrict
) TABLESPACE pg_default;

CREATE TABLE public.item_pedido (
    id_item_pedido serial not null,
    fk_pedido integer null,
    fk_ingrediente integer null,
    quantidade numeric(10, 2) null,
    preco_unitario numeric(10, 2) null,
    foi_substituido boolean null,
    constraint item_pedido_pkey primary key (id_item_pedido),
    constraint fk_item_pedido foreign key (fk_pedido)
        references pedido(id_pedido) on update cascade on delete restrict,
    constraint fk_item_pedido_ingrediente foreign key (fk_ingrediente)
        references ingrediente(id_ingrediente) on update cascade on delete restrict
) TABLESPACE pg_default;

CREATE TABLE public.ingrediente_receita (
    id_ingrediente_receita SERIAL PRIMARY KEY,
    id_receita int not null,
    id_ingrediente int not null,
    quantidade decimal(10,2),
    unidade_medida varchar(20),
    id_ingrediente_substituto int,
    eh_obrigatorio boolean,
    constraint fk_ingrediente_receita_receita foreign key (id_receita)
        references receita(id_receita) on update cascade on delete restrict,
    constraint fk_ingrediente_receita_ingrediente foreign key (id_ingrediente)
        references ingrediente(id_ingrediente) on update cascade on delete restrict,
    constraint fk_ingrediente_receita_substituto foreign key (id_ingrediente_substituto)
        references ingrediente(id_ingrediente) on update cascade on delete restrict
);


CREATE TABLE public.estoque_mercado (
    id_estoque serial not null,
    id_mercado int not null,
    id_ingrediente int not null,
    preco_unitario decimal(10,2) not null,
    quantidade_disponivel decimal(10,2) not null,
    constraint estoque_mercado_pkey primary key (id_estoque),
    constraint fk_estoque_mercado_mercado foreign key (id_mercado)
        references mercado_parceiro(id_mercado) on update cascade on delete restrict,
    constraint fk_estoque_mercado_ingrediente foreign key (id_ingrediente)
        references ingrediente(id_ingrediente) on update cascade on delete restrict
);

CREATE TABLE public.cupom_desconto (
    id_cupom SERIAL PRIMARY KEY,
    id_mercado int,
    codigo_cupom varchar(30) not null,
    percentual_desconto decimal(5,2),
    valor_desconto_fixo decimal(10,2),
    data_validade timestamp not null,
    ativo boolean
);

INSERT INTO public.cupom_desconto (
  id_mercado,
  codigo_cupom,
  percentual_desconto,
  valor_desconto_fixo,
  data_validade,
  ativo
) VALUES
(
  NULL,
  'BEMVINDO10',
  10.00,
  NULL,
  '2026-12-31 23:59:59',
  true
),
(
  NULL,
  'PRIMEIRACOMPRA',
  15.00,
  NULL,
  '2026-11-30 23:59:59',
  true
),
(
  NULL,
  'FRETEGRATIS',
  NULL,
  10.00,
  '2026-12-15 23:59:59',
  true
),
(
  NULL,
  'DESCONTO20',
  20.00,
  NULL,
  '2026-10-31 23:59:59',
  false
),
(
  NULL,
  'SAVE5',
  NULL,
  5.00,
  '2026-12-31 23:59:59',
  true
);



SELECT * FROM cupom_desconto;
