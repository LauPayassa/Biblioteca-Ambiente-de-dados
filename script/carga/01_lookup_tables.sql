-- ============================================================
-- Parte 1: Tabelas auxiliares
-- Tabelas: tipo_obra, area_conhecimento
-- ============================================================

USE biblioteca;

INSERT INTO tipo_obra (descricao) VALUES
('Livro'),           -- id 1
('Tese'),            -- id 2
('Dissertação'),     -- id 3
('Periódico'),       -- id 4
('Monografia'),      -- id 5
('Relatório Técnico'); -- id 6

INSERT INTO area_conhecimento (descricao) VALUES
('Banco de Dados'),          -- id 1
('Saúde'),                   -- id 2
('Psicologia'),              -- id 3
('Direito'),                 -- id 4
('Engenharia de Software'),  -- id 5
('Matemática'),              -- id 6
('Literatura'),              -- id 7
('História'),                -- id 8
('Administração'),           -- id 9
('Enfermagem'),              -- id 10
('Física'),                  -- id 11
('Química'),                 -- id 12
('Educação'),                -- id 13
('Ciência da Computação');   -- id 14
