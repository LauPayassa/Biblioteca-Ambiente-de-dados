-- ============================================================
-- Parte 2: Autores
-- Tabela: autor
-- ============================================================

INSERT IGNORE INTO autor (nome, link_lattes) VALUES
-- Autores internacionais (sem Lattes)
('Abraham Silberschatz',   NULL),  -- id 1
('Henry F. Korth',         NULL),  -- id 2
('S. Sudarshan',           NULL),  -- id 3
('Thomas H. Cormen',       NULL),  -- id 4
('Charles E. Leiserson',   NULL),  -- id 5
('Ronald L. Rivest',       NULL),  -- id 6
('Clifford Stein',         NULL),  -- id 7
('Robert C. Martin',       NULL),  -- id 8
('Martin Fowler',          NULL),  -- id 9
('Erich Gamma',            NULL),  -- id 10
('Richard Helm',           NULL),  -- id 11
('Ralph Johnson',          NULL),  -- id 12
('John Vlissides',         NULL),  -- id 13
('Donald E. Knuth',        NULL),  -- id 14
('Machado de Assis',       NULL),  -- id 15
('Boris Fausto',           NULL),  -- id 16
-- Autores nacionais com Lattes
('Ana Paula Oliveira',     'http://lattes.cnpq.br/1111111111111111'),  -- id 17
('Carlos Eduardo Santos',  'http://lattes.cnpq.br/2222222222222222'),  -- id 18
('Fernanda Lima Costa',    'http://lattes.cnpq.br/3333333333333333'),  -- id 19
('Ricardo Gonçalves',      'http://lattes.cnpq.br/4444444444444444'),  -- id 20
('Marcia Helena Ferreira', 'http://lattes.cnpq.br/5555555555555555'),  -- id 21
('Paulo Roberto Mendes',   'http://lattes.cnpq.br/6666666666666666');  -- id 22
