-- ============================================================
-- Parte 5: Usuários (alunos e professores)
-- Tabelas: usuario, aluno, professor, usuario_endereco, usuario_telefone
-- ============================================================

USE biblioteca;

-- RFID do cartão: US + 10 dígitos (12 chars)
-- ─────────────────────────────────────────────────────────────
-- 1. USUÁRIOS BASE
-- ─────────────────────────────────────────────────────────────
INSERT INTO usuario (nome, email, rfid_cartao, data_nascimento, status_ativo) VALUES
-- Alunos (id 1..10)
('Lucas Silva Ferreira',       'lucas.ferreira@universidade.edu.br',   'US0000000001', '2001-03-15', 'Ativo'),
('Ana Carolina Rodrigues',     'ana.rodrigues@universidade.edu.br',    'US0000000002', '2002-07-22', 'Ativo'),
('Pedro Henrique Oliveira',    'pedro.oliveira@universidade.edu.br',   'US0000000003', '2000-11-08', 'Ativo'),
('Juliana Costa Lima',         'juliana.lima@universidade.edu.br',     'US0000000004', '2003-04-30', 'Ativo'),
('Mateus Alves Souza',         'mateus.souza@universidade.edu.br',     'US0000000005', '2001-09-12', 'Ativo'),
('Camila Fernanda Santos',     'camila.santos@universidade.edu.br',    'US0000000006', '2002-01-25', 'Ativo'),
('Gabriel Mendes Pinto',       'gabriel.pinto@universidade.edu.br',    'US0000000007', '1999-06-17', 'Bloqueado'),
('Letícia Braga Carvalho',     'leticia.carvalho@universidade.edu.br', 'US0000000008', '2003-12-03', 'Ativo'),
('Rafael Torres Medeiros',     'rafael.medeiros@universidade.edu.br',  'US0000000009', '2001-05-28', 'Ativo'),
('Bianca Nunes Rezende',       'bianca.rezende@universidade.edu.br',   'US0000000010', '2004-08-09', 'Ativo'),
-- Professores (id 11..15)
('Fernando José Amaral',       'fernando.amaral@universidade.edu.br',  'US0000000011', '1975-02-14', 'Ativo'),
('Cristina Borges Moura',      'cristina.moura@universidade.edu.br',   'US0000000012', '1980-09-05', 'Ativo'),
('Alexandre Henrique Vieira',  'alexandre.vieira@universidade.edu.br', 'US0000000013', '1972-11-20', 'Ativo'),
('Renata Cavalcanti Lopes',    'renata.lopes@universidade.edu.br',     'US0000000014', '1985-04-18', 'Ativo'),
('Marco Antônio Freitas',      'marco.freitas@universidade.edu.br',    'US0000000015', '1968-07-31', 'Ativo');

-- ─────────────────────────────────────────────────────────────
-- 2. ALUNOS (tabela filha: id = usuario.id)
-- ─────────────────────────────────────────────────────────────
INSERT INTO aluno (id, matricula, curso, situacao_academica) VALUES
(1,  '2021001234', 'Ciência da Computação',        'Ativa'),
(2,  '2022005678', 'Sistemas de Informação',        'Ativa'),
(3,  '2020009012', 'Engenharia de Software',        'Ativa'),
(4,  '2023003456', 'Ciência da Computação',         'Ativa'),
(5,  '2021007890', 'Análise e Desenvolvimento',     'Ativa'),
(6,  '2022002345', 'Sistemas de Informação',        'Ativa'),
(7,  '2019006789', 'Engenharia de Software',        'Trancada'),
(8,  '2023001122', 'Ciência da Computação',         'Ativa'),
(9,  '2021004433', 'Administração',                 'Ativa'),
(10, '2024000011', 'Ciência da Computação',         'Ativa');

-- ─────────────────────────────────────────────────────────────
-- 3. PROFESSORES (tabela filha: id = usuario.id)
-- ─────────────────────────────────────────────────────────────
INSERT INTO professor (id, registro_funcional, departamento, titulacao, cargo) VALUES
(11, 'PROF-2005-0042', 'Departamento de Computação',        'Doutor',      'Professor Associado'),
(12, 'PROF-2010-0087', 'Departamento de Ciências Humanas',  'Doutora',     'Professora Adjunta'),
(13, 'PROF-2000-0015', 'Departamento de Computação',        'Doutor',      'Professor Titular'),
(14, 'PROF-2015-0063', 'Departamento de Saúde',             'Doutora',     'Professora Assistente'),
(15, 'PROF-1998-0007', 'Departamento de Administração',     'Doutor',      'Professor Titular');

-- ─────────────────────────────────────────────────────────────
-- 4. ENDEREÇOS
-- ─────────────────────────────────────────────────────────────
INSERT INTO usuario_endereco (usuario_id, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1,  'Rua das Acácias',         '123', 'Apto 45',    'Jardim Primavera',  'São Paulo',      'SP', '01310-100'),
(2,  'Avenida Brasil',          '456', NULL,         'Centro',            'Rio de Janeiro', 'RJ', '20040-020'),
(3,  'Rua Dom Pedro II',        '78',  'Casa',       'Vila Nova',         'Belo Horizonte', 'MG', '30130-140'),
(4,  'Travessa das Flores',     '12',  'Apto 101',   'Boa Vista',         'Recife',         'PE', '50070-010'),
(5,  'Rua Sete de Setembro',    '234', NULL,         'Centro',            'Salvador',       'BA', '40020-000'),
(6,  'Alameda Santos',          '890', 'Cobertura',  'Cerqueira César',   'São Paulo',      'SP', '01419-001'),
(7,  'Rua XV de Novembro',      '55',  NULL,         'Rebouças',          'Curitiba',       'PR', '80020-310'),
(8,  'Rua Oswaldo Cruz',        '321', 'Apto 22',    'Meireles',          'Fortaleza',      'CE', '60125-150'),
(9,  'Rua da Consolação',       '400', NULL,         'Consolação',        'São Paulo',      'SP', '01302-001'),
(10, 'Av. Beira-Mar',           '1500','Apto 303',   'Meireles',          'Fortaleza',      'CE', '60165-121'),
(11, 'Rua Professor Antônio',   '88',  NULL,         'Pici',              'Fortaleza',      'CE', '60440-900'),
(12, 'Rua Barão do Rio Branco', '200', 'Sala 5',     'Centro',            'Fortaleza',      'CE', '60025-060'),
(13, 'Av. da Universidade',     '2853',NULL,         'Benfica',           'Fortaleza',      'CE', '60020-181'),
(14, 'Rua Nogueira Acioli',     '1017','Apto 12',    'Aldeota',           'Fortaleza',      'CE', '60110-140'),
(15, 'Av. Humberto Monte',      '2977',NULL,         'Pici',              'Fortaleza',      'CE', '60356-000');

-- ─────────────────────────────────────────────────────────────
-- 5. TELEFONES
-- ─────────────────────────────────────────────────────────────
INSERT INTO usuario_telefone (usuario_id, numero, tipo) VALUES
(1,  '(11) 99123-4567', 'Celular'),
(2,  '(21) 98765-4321', 'Celular'),
(2,  '(21) 3344-5566',  'Residencial'),
(3,  '(31) 97654-3210', 'Celular'),
(4,  '(81) 98888-1234', 'Celular'),
(5,  '(71) 99999-5678', 'Celular'),
(6,  '(11) 98000-9876', 'Celular'),
(7,  '(41) 97777-6543', 'Celular'),
(8,  '(85) 98765-4321', 'Celular'),
(8,  '(85) 3333-7654',  'Residencial'),
(9,  '(11) 99456-7890', 'Celular'),
(10, '(85) 99123-0001', 'Celular'),
(11, '(85) 99200-0042', 'Celular'),
(11, '(85) 3366-1100',  'Comercial'),
(12, '(85) 98300-0087', 'Celular'),
(13, '(85) 99400-0015', 'Celular'),
(13, '(85) 3366-2200',  'Comercial'),
(14, '(85) 98500-0063', 'Celular'),
(15, '(85) 99600-0007', 'Celular'),
(15, '(85) 3366-3300',  'Comercial');
