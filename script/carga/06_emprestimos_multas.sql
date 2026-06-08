-- ============================================================
-- Parte 6: Empréstimos e Multas
-- Ordem de execução: 6ª (depende de: usuario, exemplar)
-- Tabelas: emprestimo, multa + UPDATE em exemplar
-- Data de referência: 2026-06-08
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- LEGENDA DE STATUS (calculado em tempo de consulta, não em coluna):
--   Ativo     → data_devolucao_real IS NULL AND data_previsao_devolucao >= CURRENT_DATE
--   Atrasado  → data_devolucao_real IS NULL AND data_previsao_devolucao <  CURRENT_DATE
--   Devolvido → data_devolucao_real IS NOT NULL
-- ─────────────────────────────────────────────────────────────

-- ─────────────────────────────────────────────────────────────
-- 1. EMPRÉSTIMOS
-- ─────────────────────────────────────────────────────────────
INSERT INTO emprestimo
  (usuario_id, exemplar_id, data_emprestimo, data_previsao_devolucao, data_devolucao_real, valor_dia_multa)
VALUES
-- ══ ATIVOS E ATRASADOS (data_devolucao_real = NULL) ══════════

-- emp id 1 — Lucas (aluno), ex 5 — ATRASADO (venceu 2026-06-03, 5 dias de atraso)
(1,  5,  '2026-05-20 09:00:00', '2026-06-03 23:59:59', NULL, 1.50),

-- emp id 2 — Pedro (aluno), ex 8 — ATIVO (vence 2026-06-11)
(3,  8,  '2026-05-28 14:30:00', '2026-06-11 23:59:59', NULL, 1.50),

-- emp id 3 — Mateus (aluno), ex 12 — ATIVO (vence 2026-06-15)
(5,  12, '2026-06-01 10:15:00', '2026-06-15 23:59:59', NULL, 1.50),

-- emp id 4 — Gabriel (aluno bloqueado), ex 17 — ATRASADO (venceu 2026-05-29, 10 dias)
(7,  17, '2026-05-15 11:00:00', '2026-05-29 23:59:59', NULL, 1.50),

-- emp id 5 — Bianca (aluno), ex 22 — ATIVO (vence 2026-06-17)
(10, 22, '2026-06-03 16:00:00', '2026-06-17 23:59:59', NULL, 1.50),

-- emp id 6 — Cristina (prof), ex 25 — ATRASADO (venceu 2026-05-24, 15 dias)
(12, 25, '2026-05-10 08:30:00', '2026-05-24 23:59:59', NULL, 1.50),

-- emp id 7 — Fernando (prof), ex 29 — ATIVO (vence 2026-06-22)
(11, 29, '2026-05-25 09:45:00', '2026-06-22 23:59:59', NULL, 1.50),

-- emp id 8 — Renata (prof), ex 19 — ATIVO (vence 2026-06-25)
(14, 19, '2026-05-28 13:00:00', '2026-06-25 23:59:59', NULL, 1.50),

-- ══ DEVOLVIDOS NO PRAZO (sem multa) ═════════════════════════

-- emp id 9 — Ana (aluno), ex 1 — devolvido no prazo
(2,  1,  '2026-04-10 10:00:00', '2026-04-24 23:59:59', '2026-04-22 14:30:00', 1.50),

-- emp id 10 — Juliana (aluno), ex 3 — devolvido no prazo
(4,  3,  '2026-03-15 09:00:00', '2026-03-29 23:59:59', '2026-03-28 11:00:00', 1.50),

-- emp id 11 — Camila (aluno), ex 7 — devolvido no prazo
(6,  7,  '2026-02-01 14:00:00', '2026-02-15 23:59:59', '2026-02-14 16:00:00', 1.50),

-- emp id 12 — Letícia (aluno), ex 11 — devolvido no prazo
(8,  11, '2026-01-20 10:30:00', '2026-02-03 23:59:59', '2026-02-02 09:00:00', 1.50),

-- emp id 13 — Rafael (aluno), ex 15 — devolvido no prazo
(9,  15, '2025-12-01 11:00:00', '2025-12-15 23:59:59', '2025-12-13 15:30:00', 1.50),

-- emp id 14 — Alexandre (prof), ex 20 — devolvido no prazo
(13, 20, '2025-11-10 09:00:00', '2025-11-24 23:59:59', '2025-11-20 10:00:00', 1.50),

-- emp id 15 — Marco Antônio (prof), ex 33 — devolvido no prazo
(15, 33, '2025-10-05 14:00:00', '2025-10-19 23:59:59', '2025-10-18 16:00:00', 1.50),

-- ══ DEVOLVIDOS COM ATRASO (com multa) ═══════════════════════

-- emp id 16 — Lucas (aluno), ex 2 — 5 dias de atraso → multa R$ 7,50 (pago)
(1,  2,  '2026-03-01 10:00:00', '2026-03-15 23:59:59', '2026-03-20 14:00:00', 1.50),

-- emp id 17 — Pedro (aluno), ex 6 — 6 dias de atraso → multa R$ 9,00 (pago)
(3,  6,  '2026-02-10 09:00:00', '2026-02-24 23:59:59', '2026-03-02 11:30:00', 1.50),

-- emp id 18 — Mateus (aluno), ex 9 — 6 dias de atraso → multa R$ 9,00 (cancelado)
(5,  9,  '2026-01-05 11:00:00', '2026-01-19 23:59:59', '2026-01-25 10:00:00', 1.50),

-- emp id 19 — Gabriel (aluno), ex 14 — 6 dias de atraso → multa R$ 9,00 (pago)
(7,  14, '2025-11-20 10:00:00', '2025-12-04 23:59:59', '2025-12-10 16:00:00', 1.50),

-- emp id 20 — Rafael (aluno), ex 18 — 12 dias de atraso → multa R$ 18,00 (pendente)
(9,  18, '2025-10-10 09:00:00', '2025-10-24 23:59:59', '2025-11-05 13:00:00', 1.50),

-- emp id 21 — Renata (prof), ex 30 — 3 dias de atraso → multa R$ 4,50 (pago)
(14, 30, '2025-08-15 10:00:00', '2025-08-29 23:59:59', '2025-09-01 09:00:00', 1.50);

-- ─────────────────────────────────────────────────────────────
-- 2. ATUALIZAR STATUS DOS EXEMPLARES EMPRESTADOS
--    (empréstimos ativos: ids 1..8)
-- ─────────────────────────────────────────────────────────────
UPDATE exemplar SET status = 'Emprestado' WHERE id IN (5, 8, 12, 17, 22, 25, 29, 19);

-- ─────────────────────────────────────────────────────────────
-- 3. MULTAS
-- ─────────────────────────────────────────────────────────────
-- Fórmula: valor_multa = dias_atraso * valor_dia_multa do empréstimo
-- Obs.: multas por empréstimos ativos e atrasados são geradas
--       aqui com base nos dias corridos até 2026-06-08.

INSERT INTO multa
  (emprestimo_id, valor_multa, desconto, valor_pago, data_pagamento, status_pagamento)
VALUES
-- ── Empréstimos ATIVOS e ATRASADOS (sem devolução ainda) ─────
-- emp 1 (Lucas, ex 5): venceu 2026-06-03 → 5 dias × R$1,50 = R$7,50 — Pendente
(1,  7.50, 0.00, 0.00, NULL, 'Pendente'),

-- emp 4 (Gabriel, ex 17): venceu 2026-05-29 → 10 dias × R$1,50 = R$15,00 — Pendente
(4,  15.00, 0.00, 0.00, NULL, 'Pendente'),

-- emp 6 (Cristina, ex 25): venceu 2026-05-24 → 15 dias × R$1,50 = R$22,50 — Pendente
(6,  22.50, 0.00, 0.00, NULL, 'Pendente'),

-- ── Empréstimos DEVOLVIDOS COM ATRASO ────────────────────────
-- emp 16 (Lucas, ex 2): 5 dias × R$1,50 = R$7,50 — Pago
(16, 7.50,  0.00, 7.50,  '2026-03-21 10:00:00', 'Pago'),

-- emp 17 (Pedro, ex 6): 6 dias × R$1,50 = R$9,00 — Pago com R$1,00 de desconto
(17, 9.00,  1.00, 8.00,  '2026-03-04 09:30:00', 'Pago'),

-- emp 18 (Mateus, ex 9): 6 dias × R$1,50 = R$9,00 — Cancelado (erro de lançamento)
(18, 9.00,  0.00, 0.00,  NULL,                   'Cancelado'),

-- emp 19 (Gabriel, ex 14): 6 dias × R$1,50 = R$9,00 — Pago
(19, 9.00,  0.00, 9.00,  '2025-12-12 14:00:00', 'Pago'),

-- emp 20 (Rafael, ex 18): 12 dias × R$1,50 = R$18,00 — Pendente
(20, 18.00, 0.00, 0.00,  NULL,                   'Pendente'),

-- emp 21 (Renata, ex 30): 3 dias × R$1,50 = R$4,50 — Pago
(21, 4.50,  0.00, 4.50,  '2025-09-03 11:00:00', 'Pago');
