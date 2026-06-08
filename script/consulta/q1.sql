-- ============================================================
-- Relatório 1: Empréstimos nos últimos 12 meses
-- ============================================================

SELECT
  DATE_FORMAT(e.data_emprestimo, '%m/%Y')      AS mes,
  tp.descricao                                 AS tipo_obra,
  COUNT(e.id)                                  AS qtd_emprestimos,
  COUNT(DISTINCT o.id)                         AS qtd_obras_distintas,
  COALESCE(
    SUM(CASE WHEN m.status_pagamento = 'Pago'
             THEN m.valor_pago ELSE 0 END),
    0
  )                                            AS total_multas_pagas

FROM emprestimo e
JOIN exemplar  ex ON ex.id  = e.exemplar_id
JOIN obra       o ON o.id   = ex.obra_id
JOIN tipo_obra tp ON tp.id  = o.tipo_obra_id
LEFT JOIN multa m ON m.emprestimo_id = e.id

WHERE e.data_emprestimo >= DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH)

GROUP BY
  DATE_FORMAT(e.data_emprestimo, '%Y-%m'),
  DATE_FORMAT(e.data_emprestimo, '%m/%Y'),
  tp.id,
  tp.descricao

ORDER BY
  DATE_FORMAT(e.data_emprestimo, '%Y-%m'),
  tp.descricao;
