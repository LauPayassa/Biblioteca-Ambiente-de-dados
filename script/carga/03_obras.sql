-- ============================================================
-- Parte 3: Obras e autoria
-- Ordem de execução: 3ª (depende de: tipo_obra, area_conhecimento, autor)
-- Tabelas: obra, obra_autor
-- ============================================================

USE biblioteca;

-- tipo_obra:  1=Livro | 2=Tese | 3=Dissertação | 4=Periódico | 5=Monografia | 6=Rel.Técnico
-- area:       1=BD | 2=Saúde | 3=Psic | 4=Dir | 5=Eng.SW | 6=Mat | 7=Lit | 8=Hist | 9=Adm | 14=CC

INSERT INTO obra (tipo_obra_id, area_conhecimento_id, titulo, isbn, subtitulo, categoria, numero_paginas, data_publicacao) VALUES
-- ── Livros clássicos ─────────────────────────────────────────────────────────
(1,  1, 'Sistema de Gerenciamento de Banco de Dados',
        '978-85-352-3554-7', NULL,
        'Banco de Dados', 1088, '2020-01-15'),                                  -- id 1

(1, 14, 'Introdução a Algoritmos',
        '978-85-352-3308-6', 'Terceira Edição',
        'Algoritmos e Estruturas de Dados', 1292, '2012-06-01'),                 -- id 2

(1,  5, 'Código Limpo',
        '978-85-7780-285-2', 'Habilidades Práticas do Agile Software Crafter',
        'Engenharia de Software', 431, '2011-02-01'),                            -- id 3

(1,  5, 'Refatoração',
        '978-85-7522-728-0', 'Aperfeiçoando o Projeto de Código Existente',
        'Engenharia de Software', 468, '2020-08-15'),                            -- id 4

(1,  5, 'Padrões de Projeto',
        '978-85-7262-129-7', 'Soluções Reutilizáveis de Software Orientado a Objetos',
        'Engenharia de Software', 395, '2000-10-01'),                            -- id 5

(1,  6, 'A Arte da Programação de Computadores',
        '978-00-2011-570-0', 'Volume 1: Algoritmos Fundamentais',
        'Matemática Computacional', 672, '1997-07-01'),                          -- id 6

(1,  9, 'Administração: Teoria e Prática',
        '978-85-340-0456-7', NULL,
        'Administração Geral', 520, '2019-03-10'),                               -- id 7

(1,  3, 'Psicologia Organizacional e do Trabalho',
        '978-85-431-0567-1', NULL,
        'Psicologia', 380, '2021-05-20'),                                        -- id 8

(1,  4, 'Fundamentos de Direito Civil',
        '978-85-309-7890-3', NULL,
        'Direito Civil', 612, '2022-01-10'),                                     -- id 9

(1,  2, 'Anatomia Humana Sistêmica e Segmentar',
        '978-85-277-1234-5', NULL,
        'Anatomia', 950, '2018-09-15'),                                          -- id 10

(1,  7, 'Dom Casmurro',
        '978-85-209-3210-0', NULL,
        'Literatura Brasileira', 256, '2019-04-01'),                             -- id 11

(1,  8, 'História Concisa do Brasil',
        '978-85-314-0671-9', NULL,
        'História do Brasil', 324, '2015-07-01'),                                -- id 12

-- ── Teses ────────────────────────────────────────────────────────────────────
(2,  5, 'Impacto de Microsserviços em Sistemas de Alta Disponibilidade',
        NULL, NULL,
        'Engenharia de Software', 148, '2023-07-20'),                            -- id 13

(2,  9, 'Gestão da Inovação em Startups de Base Tecnológica no Brasil',
        NULL, NULL,
        'Gestão da Inovação', 162, '2024-02-10'),                                -- id 14

-- ── Dissertações ─────────────────────────────────────────────────────────────
(3,  1, 'Otimização de Consultas em Bancos de Dados Distribuídos',
        NULL, NULL,
        'Banco de Dados', 112, '2022-11-30'),                                    -- id 15

(3,  2, 'Machine Learning no Diagnóstico Precoce de Doenças Cardíacas',
        NULL, NULL,
        'Saúde Digital', 98, '2023-03-15'),                                      -- id 16

-- ── Periódicos ───────────────────────────────────────────────────────────────
(4,  5, 'Journal of Software Engineering Research',
        NULL, 'Volume 15, Número 3',
        'Periódico Científico', NULL, '2024-05-01'),                             -- id 17

(4,  1, 'IEEE Transactions on Knowledge and Data Engineering',
        NULL, 'Volume 36, Número 2',
        'Periódico Científico', NULL, '2024-03-01'),                             -- id 18

-- ── Monografias ──────────────────────────────────────────────────────────────
(5, 14, 'Análise de Desempenho de Redes Neurais em Hardware Embarcado',
        NULL, NULL,
        'Inteligência Artificial', 88, '2023-12-01'),                            -- id 19

(5,  9, 'Estratégias de Marketing Digital para Pequenas Empresas',
        NULL, NULL,
        'Marketing Digital', 76, '2024-01-15');                                  -- id 20

-- ── Autoria (obra_autor) ─────────────────────────────────────────────────────
-- obra_id | autor_id | ordem
INSERT INTO obra_autor (obra_id, autor_id, ordem) VALUES
-- Obra 1: SGBD — Silberschatz, Korth, Sudarshan
(1,  1, 1), (1,  2, 2), (1,  3, 3),
-- Obra 2: Introdução a Algoritmos — CLRS
(2,  4, 1), (2,  5, 2), (2,  6, 3), (2,  7, 4),
-- Obra 3: Código Limpo — Robert C. Martin
(3,  8, 1),
-- Obra 4: Refatoração — Martin Fowler
(4,  9, 1),
-- Obra 5: Padrões de Projeto — Gang of Four
(5, 10, 1), (5, 11, 2), (5, 12, 3), (5, 13, 4),
-- Obra 6: Arte da Programação — Knuth
(6, 14, 1),
-- Obra 7: Administração — Paulo Roberto Mendes
(7, 22, 1),
-- Obra 8: Psicologia — Marcia Helena Ferreira
(8, 21, 1),
-- Obra 9: Direito — Ricardo Gonçalves
(9, 20, 1),
-- Obra 10: Anatomia — Fernanda Lima Costa
(10, 19, 1),
-- Obra 11: Dom Casmurro — Machado de Assis
(11, 15, 1),
-- Obra 12: História Concisa — Boris Fausto
(12, 16, 1),
-- Obra 13: Tese microsserviços — Ana Paula Oliveira
(13, 17, 1),
-- Obra 14: Tese startups — Carlos Eduardo Santos
(14, 18, 1),
-- Obra 15: Dissertação BD — Ricardo Gonçalves
(15, 20, 1),
-- Obra 16: Dissertação saúde — Fernanda Lima Costa + Marcia Helena
(16, 19, 1), (16, 21, 2),
-- Obras 17–20: periódicos/monografias sem autor cadastrado individualmente
(19, 17, 1),
(20, 22, 1);
