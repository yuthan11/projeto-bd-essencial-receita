CREATE TABLE receita (
  id_receita SERIAL PRIMARY KEY,
  id_autor_chef int,
  titulo varchar(150) not null,
  modo_preparo text not null,
  tempo_preparo_minutos int not null,
  nivel_dificuldade varchar (255),
  eh_exclusive_premium boolean,
  data_cadastro timestamp
);



  SELECT * FROM usuario;

