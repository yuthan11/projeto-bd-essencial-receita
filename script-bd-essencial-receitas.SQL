CREATE TABLE ingredientes(
 id_ingrediente SERIAL PRIMARY KEY,
 nome varchar (100) not null,
 categoria varchar (50) not null,
 unidade_medida_padrao varchar (20) not null
);

SELECT * FROM ingredientes;

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

SELECT * FROM usuario;

CREATE TABLE estoque(
 id_estoque SERIAL PRIMARY KEY,
 id_mercado int not null,
 id_inrediente int not null,
 preco_unitario decimal(10,2) not null,
 quantidade_disponivel decimal(10,2) not null
);

SELECT * FROM estoque;
