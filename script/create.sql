
CREATE DATABASE IF NOT EXISTS biblioteca
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE biblioteca;

CREATE TABLE aluno
(
  id                 INT                                  NOT NULL COMMENT 'Chave primaria e estrangeira referenciando usuario',
  matricula          VARCHAR(50)                          NOT NULL COMMENT 'Matricula academica do aluno',
  curso              VARCHAR(100)                         NOT NULL COMMENT 'Nome do curso de graduacao/pos-graduacao',
  situacao_academica ENUM('Ativa', 'Inativa', 'Trancada') NOT NULL DEFAULT 'Ativa' COMMENT 'Situacao academica do aluno',
  PRIMARY KEY (id)
) COMMENT 'Tabela filha contendo dados especificos de alunos';

ALTER TABLE aluno
  ADD CONSTRAINT UQ_matricula UNIQUE (matricula);

CREATE TABLE area_conhecimento
(
  id        INT          NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria da area do conhecimento',
  descricao VARCHAR(100) NOT NULL COMMENT 'Nome da area (ex: Banco de Dados, Saude, Psicologia, Direito)',
  PRIMARY KEY (id)
) COMMENT 'Areas do conhecimento para classificacao das obras (ex: Banco de Dados, Saude, Psicologia)';

CREATE TABLE autor
(
  id          INT          NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do autor',
  nome        VARCHAR(255) NOT NULL COMMENT 'Nome completo do autor',
  link_lattes VARCHAR(255) NULL     COMMENT 'URL do curriculo Lattes do autor (opcional)',
  PRIMARY KEY (id)
) COMMENT 'Cadastro de autores de obras';

ALTER TABLE autor
  ADD CONSTRAINT UQ_link_lattes UNIQUE (link_lattes);

CREATE TABLE emprestimo
(
  id                      INT          NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do emprestimo',
  usuario_id              INT          NOT NULL COMMENT 'Chave estrangeira referenciando o usuario',
  exemplar_id             INT          NOT NULL COMMENT 'Chave estrangeira referenciando o exemplar fisico',
  data_emprestimo         TIMESTAMP    NOT NULL COMMENT 'Data/hora em que o emprestimo foi realizado',
  data_previsao_devolucao TIMESTAMP    NOT NULL COMMENT 'Data limite prevista para entrega sem multa',
  data_devolucao_real     TIMESTAMP    NULL     COMMENT 'Data real em que o livro foi retornado (NULL=ainda ativo)',
  valor_dia_multa         DECIMAL(5,2) NOT NULL DEFAULT 1.50 COMMENT 'Taxa diaria de multa vigente no momento do emprestimo (auditoria)',
  PRIMARY KEY (id)
) COMMENT 'Registro de transacoes de emprestimos e devolucoes. Status calculado via query: Ativo/Atrasado/Devolvido';

CREATE TABLE exemplar
(
  id                 INT                                                                                          NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do exemplar',
  obra_id            INT                                                                                          NOT NULL COMMENT 'Chave estrangeira apontando para a obra',
  codigo_rfid        VARCHAR(24)                                                                                  NOT NULL COMMENT 'Etiqueta RFID unica associada a este exemplar fisico',
  status             ENUM('Disponivel', 'Emprestado', 'Consulta Local', 'Manutencao', 'Extraviado', 'Descartado') NOT NULL DEFAULT 'Disponivel' COMMENT 'Status de disponibilidade do exemplar',
  estado_conservacao ENUM('Novo', 'Bom', 'Regular', 'Danificado')                                                 NOT NULL DEFAULT 'Novo' COMMENT 'Estado em que se encontra o exemplar',
  data_aquisicao     DATE                                                                                         NULL     COMMENT 'Data em que o exemplar foi adquirido pela biblioteca',
  PRIMARY KEY (id)
) COMMENT 'Copia fisica de uma obra com tag RFID unica para controle fisico';

ALTER TABLE exemplar
  ADD CONSTRAINT UQ_codigo_rfid UNIQUE (codigo_rfid);

CREATE TABLE multa
(
  id               INT                                   NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria da multa',
  emprestimo_id    INT                                   NOT NULL COMMENT 'FK para emprestimo (UNIQUE — 1:1)',
  valor_multa      DECIMAL(10,2)                         NOT NULL COMMENT 'Valor bruto calculado da multa',
  desconto         DECIMAL(10,2)                         NOT NULL DEFAULT 0.00 COMMENT 'Valor de desconto concedido',
  valor_pago       DECIMAL(10,2)                         NOT NULL DEFAULT 0.00 COMMENT 'Valor pago efetivamente',
  data_pagamento   TIMESTAMP                             NULL     COMMENT 'Data de pagamento da multa',
  status_pagamento ENUM('Pendente', 'Pago', 'Cancelado') NOT NULL DEFAULT 'Pendente' COMMENT 'Status de pagamento da multa',
  PRIMARY KEY (id)
) COMMENT 'Multas geradas por atraso nos emprestimos de livros';

ALTER TABLE multa
  ADD CONSTRAINT UQ_emprestimo_id UNIQUE (emprestimo_id);

CREATE TABLE obra
(
  id                   INT          NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria da obra',
  tipo_obra_id         INT          NOT NULL COMMENT 'FK para tipo_obra',
  area_conhecimento_id INT          NOT NULL COMMENT 'FK para area_conhecimento',
  titulo               VARCHAR(255) NOT NULL COMMENT 'Titulo da obra',
  isbn                 VARCHAR(20)  NULL     COMMENT 'Codigo ISBN (opcional para teses/periodicos)',
  subtitulo            VARCHAR(255) NULL     COMMENT 'Subtitulo da obra (opcional)',
  categoria            VARCHAR(100) NOT NULL COMMENT 'Categoria ou assunto da obra',
  numero_paginas       INT          NULL     COMMENT 'Quantidade de paginas da obra',
  data_publicacao      DATE         NULL     COMMENT 'Data de publicacao',
  PRIMARY KEY (id)
) COMMENT 'Catalogo contendo os metadados de obras (livros, teses, dissertacoes, periodicos)';

ALTER TABLE obra
  ADD CONSTRAINT UQ_isbn UNIQUE (isbn);

ALTER TABLE obra
  ADD CONSTRAINT UQ_subtitulo UNIQUE (subtitulo);

CREATE TABLE obra_autor
(
  obra_id  INT     NOT NULL COMMENT 'FK para obra',
  autor_id INT     NOT NULL COMMENT 'FK para autor',
  ordem    TINYINT NULL     DEFAULT 1 COMMENT 'Ordem de autoria (1=principal)',
  PRIMARY KEY (obra_id, autor_id)
) COMMENT 'Tabela associativa N:N entre obra e autor';

CREATE TABLE professor
(
  id                 INT          NOT NULL COMMENT 'Chave primaria e estrangeira referenciando usuario',
  registro_funcional VARCHAR(50)  NOT NULL COMMENT 'Registro funcional do docente',
  departamento       VARCHAR(100) NOT NULL COMMENT 'Departamento ou filiacao departamental',
  titulacao          VARCHAR(50)  NOT NULL COMMENT 'Grau academico do professor',
  cargo              VARCHAR(100) NOT NULL COMMENT 'Cargo ocupado pelo professor',
  PRIMARY KEY (id)
) COMMENT 'Tabela filha contendo dados especificos de professores';

ALTER TABLE professor
  ADD CONSTRAINT UQ_registro_funcional UNIQUE (registro_funcional);

CREATE TABLE registro_acesso
(
  id          INT                      NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do log de acesso',
  usuario_id  INT                      NOT NULL COMMENT 'Chave estrangeira do usuario',
  data_hora   TIMESTAMP                NOT NULL COMMENT 'Data/hora do acesso fisico',
  tipo_acesso ENUM('Entrada', 'Saida') NOT NULL COMMENT 'Sentido de acesso: Entrada ou Saida',
  PRIMARY KEY (id)
) COMMENT 'Logs de entrada e saida fisica da biblioteca via portal RFID';

CREATE TABLE tipo_obra
(
  id        INT         NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do tipo de obra',
  descricao VARCHAR(50) NOT NULL COMMENT 'Descricao do tipo (ex: Livro, Tese, Dissertacao, Periodico)',
  PRIMARY KEY (id)
) COMMENT 'Tabela auxiliar com os tipos de obra disponiveis';

CREATE TABLE usuario
(
  id              INT                        NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do usuario',
  nome            VARCHAR(255)               NOT NULL COMMENT 'Nome completo do usuario',
  email           VARCHAR(255)               NOT NULL COMMENT 'Endereco de e-mail institucional do usuario',
  rfid_cartao     VARCHAR(24)                NOT NULL COMMENT 'Codigo RFID do cartao fisico do usuario',
  data_nascimento DATE                       NULL     COMMENT 'Data de nascimento do usuario',
  status_ativo    ENUM('Ativo', 'Bloqueado') NOT NULL DEFAULT 'Ativo' COMMENT 'Status do usuario',
  PRIMARY KEY (id)
) COMMENT 'Tabela pai de usuarios do sistema (alunos e professores)';

ALTER TABLE usuario
  ADD CONSTRAINT UQ_email UNIQUE (email);

ALTER TABLE usuario
  ADD CONSTRAINT UQ_rfid_cartao UNIQUE (rfid_cartao);

CREATE TABLE usuario_endereco
(
  id          INT          NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do endereco',
  usuario_id  INT          NOT NULL COMMENT 'Chave estrangeira referenciando usuario',
  logradouro  VARCHAR(255) NOT NULL COMMENT 'Rua, Avenida, etc.',
  numero      VARCHAR(20)  NULL     COMMENT 'Numero',
  complemento VARCHAR(100) NULL     COMMENT 'Complemento (ex: Apto 101)',
  bairro      VARCHAR(100) NULL     COMMENT 'Bairro',
  cidade      VARCHAR(100) NOT NULL COMMENT 'Cidade',
  estado      CHAR(2)      NOT NULL COMMENT 'Unidade federativa (ex: RJ, SP)',
  cep         VARCHAR(10)  NOT NULL COMMENT 'CEP',
  PRIMARY KEY (id)
) COMMENT 'Tabela de enderecos associados ao usuario (1:N)';

CREATE TABLE usuario_telefone
(
  id         INT                                         NOT NULL AUTO_INCREMENT COMMENT 'Chave primaria do telefone',
  usuario_id INT                                         NOT NULL COMMENT 'Chave estrangeira referenciando usuario',
  numero     VARCHAR(20)                                 NOT NULL COMMENT 'Numero de telefone com DDD',
  tipo       ENUM('Celular', 'Residencial', 'Comercial') NOT NULL DEFAULT 'Celular' COMMENT 'Tipo do telefone',
  PRIMARY KEY (id)
) COMMENT 'Tabela de telefones associados ao usuario (1:N)';

ALTER TABLE aluno
  ADD CONSTRAINT FK_usuario_TO_aluno
    FOREIGN KEY (id)
    REFERENCES usuario (id);

ALTER TABLE professor
  ADD CONSTRAINT FK_usuario_TO_professor
    FOREIGN KEY (id)
    REFERENCES usuario (id);

ALTER TABLE exemplar
  ADD CONSTRAINT FK_obra_TO_exemplar
    FOREIGN KEY (obra_id)
    REFERENCES obra (id);

ALTER TABLE usuario_telefone
  ADD CONSTRAINT FK_usuario_TO_usuario_telefone
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id);

ALTER TABLE usuario_endereco
  ADD CONSTRAINT FK_usuario_TO_usuario_endereco
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id);

ALTER TABLE emprestimo
  ADD CONSTRAINT FK_usuario_TO_emprestimo
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id);

ALTER TABLE emprestimo
  ADD CONSTRAINT FK_exemplar_TO_emprestimo
    FOREIGN KEY (exemplar_id)
    REFERENCES exemplar (id);

ALTER TABLE multa
  ADD CONSTRAINT FK_emprestimo_TO_multa
    FOREIGN KEY (emprestimo_id)
    REFERENCES emprestimo (id);

ALTER TABLE registro_acesso
  ADD CONSTRAINT FK_usuario_TO_registro_acesso
    FOREIGN KEY (usuario_id)
    REFERENCES usuario (id);

ALTER TABLE obra
  ADD CONSTRAINT FK_tipo_obra_TO_obra
    FOREIGN KEY (tipo_obra_id)
    REFERENCES tipo_obra (id);

ALTER TABLE obra
  ADD CONSTRAINT FK_area_conhecimento_TO_obra
    FOREIGN KEY (area_conhecimento_id)
    REFERENCES area_conhecimento (id);

ALTER TABLE obra_autor
  ADD CONSTRAINT FK_autor_TO_obra_autor
    FOREIGN KEY (autor_id)
    REFERENCES autor (id);

ALTER TABLE obra_autor
  ADD CONSTRAINT FK_obra_TO_obra_autor
    FOREIGN KEY (obra_id)
    REFERENCES obra (id);

