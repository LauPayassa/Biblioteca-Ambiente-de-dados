-- ============================================================
-- Parte 4: Exemplares físicos
-- Ordem de execução: 4ª (depende de: obra)
-- Tabela: exemplar
-- ============================================================

USE biblioteca;

-- RFID pattern: EX + 10 dígitos (12 chars total)
-- estado_conservacao: Novo | Bom | Regular | Danificado
-- status: Disponivel | Emprestado | Consulta Local | Manutencao | Extraviado | Descartado

INSERT INTO exemplar (obra_id, codigo_rfid, status, estado_conservacao, data_aquisicao) VALUES
-- ── Obra 1: SGBD (3 exemplares) ──────────────────────────────────────────────
(1, 'EX0000000001', 'Disponivel',    'Bom',       '2021-02-10'),  -- ex id 1
(1, 'EX0000000002', 'Disponivel',    'Bom',       '2021-02-10'),  -- ex id 2
(1, 'EX0000000003', 'Consulta Local','Regular',   '2019-08-15'),  -- ex id 3

-- ── Obra 2: Introdução a Algoritmos (3 exemplares) ───────────────────────────
(2, 'EX0000000004', 'Disponivel',    'Novo',      '2023-01-20'),  -- ex id 4
(2, 'EX0000000005', 'Disponivel',    'Bom',       '2021-06-01'),  -- ex id 5
(2, 'EX0000000006', 'Disponivel',    'Regular',   '2019-03-12'),  -- ex id 6

-- ── Obra 3: Código Limpo (2 exemplares) ──────────────────────────────────────
(3, 'EX0000000007', 'Disponivel',    'Bom',       '2022-04-05'),  -- ex id 7
(3, 'EX0000000008', 'Disponivel',    'Bom',       '2022-04-05'),  -- ex id 8

-- ── Obra 4: Refatoração (2 exemplares) ───────────────────────────────────────
(4, 'EX0000000009', 'Disponivel',    'Novo',      '2023-09-10'),  -- ex id 9
(4, 'EX0000000010', 'Manutencao',    'Danificado','2021-01-18'),  -- ex id 10

-- ── Obra 5: Padrões de Projeto (3 exemplares) ────────────────────────────────
(5, 'EX0000000011', 'Disponivel',    'Bom',       '2020-05-20'),  -- ex id 11
(5, 'EX0000000012', 'Disponivel',    'Regular',   '2018-11-30'),  -- ex id 12
(5, 'EX0000000013', 'Extraviado',    'Regular',   '2018-11-30'),  -- ex id 13

-- ── Obra 6: Arte da Programação (1 exemplar) ─────────────────────────────────
(6, 'EX0000000014', 'Consulta Local','Bom',       '2017-06-01'),  -- ex id 14

-- ── Obra 7: Administração (2 exemplares) ─────────────────────────────────────
(7, 'EX0000000015', 'Disponivel',    'Novo',      '2023-03-15'),  -- ex id 15
(7, 'EX0000000016', 'Disponivel',    'Bom',       '2021-07-22'),  -- ex id 16

-- ── Obra 8: Psicologia (2 exemplares) ────────────────────────────────────────
(8, 'EX0000000017', 'Disponivel',    'Novo',      '2023-06-10'),  -- ex id 17
(8, 'EX0000000018', 'Disponivel',    'Bom',       '2022-10-03'),  -- ex id 18

-- ── Obra 9: Direito Civil (2 exemplares) ─────────────────────────────────────
(9, 'EX0000000019', 'Disponivel',    'Novo',      '2024-01-15'),  -- ex id 19
(9, 'EX0000000020', 'Disponivel',    'Bom',       '2022-05-08'),  -- ex id 20

-- ── Obra 10: Anatomia (2 exemplares) ─────────────────────────────────────────
(10,'EX0000000021', 'Disponivel',    'Bom',       '2020-09-20'),  -- ex id 21
(10,'EX0000000022', 'Disponivel',    'Regular',   '2019-02-14'),  -- ex id 22

-- ── Obra 11: Dom Casmurro (2 exemplares) ─────────────────────────────────────
(11,'EX0000000023', 'Disponivel',    'Novo',      '2022-08-01'),  -- ex id 23
(11,'EX0000000024', 'Disponivel',    'Bom',       '2020-04-10'),  -- ex id 24

-- ── Obra 12: História Concisa (2 exemplares) ─────────────────────────────────
(12,'EX0000000025', 'Disponivel',    'Bom',       '2021-11-20'),  -- ex id 25
(12,'EX0000000026', 'Disponivel',    'Regular',   '2019-05-15'),  -- ex id 26

-- ── Obra 13: Tese Microsserviços (1 exemplar) ────────────────────────────────
(13,'EX0000000027', 'Consulta Local','Novo',      '2024-01-10'),  -- ex id 27

-- ── Obra 14: Tese Startups (1 exemplar) ──────────────────────────────────────
(14,'EX0000000028', 'Consulta Local','Novo',      '2024-05-20'),  -- ex id 28

-- ── Obra 15: Dissertação BD (1 exemplar) ─────────────────────────────────────
(15,'EX0000000029', 'Disponivel',    'Novo',      '2023-04-12'),  -- ex id 29

-- ── Obra 16: Dissertação Saúde (1 exemplar) ──────────────────────────────────
(16,'EX0000000030', 'Disponivel',    'Novo',      '2023-07-18'),  -- ex id 30

-- ── Obra 17: Journal Eng.SW (1 exemplar) ─────────────────────────────────────
(17,'EX0000000031', 'Consulta Local','Novo',      '2024-06-01'),  -- ex id 31

-- ── Obra 18: IEEE Transactions (1 exemplar) ──────────────────────────────────
(18,'EX0000000032', 'Consulta Local','Novo',      '2024-04-05'),  -- ex id 32

-- ── Obra 19: Monografia Redes Neurais (1 exemplar) ───────────────────────────
(19,'EX0000000033', 'Disponivel',    'Novo',      '2024-02-28'),  -- ex id 33

-- ── Obra 20: Monografia Marketing Digital (1 exemplar) ───────────────────────
(20,'EX0000000034', 'Disponivel',    'Novo',      '2024-03-10'),  -- ex id 34

-- ── Exemplar descartado (Obra 1 — edição antiga) ─────────────────────────────
(1, 'EX0000000035', 'Descartado',   'Danificado', '2015-01-10');  -- ex id 35
