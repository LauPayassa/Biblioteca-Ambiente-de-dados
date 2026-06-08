-- ============================================================
-- Relatório 4: Acervo por Área do Conhecimento
-- ============================================================

WITH volumes AS (
  -- Contagem de exemplares por obra (exclui Descartados do acervo ativo)
  SELECT
    obra_id,
    COUNT(*)                                             AS total_acervo,
    SUM(status = 'Emprestado')                           AS emprestados
  FROM exemplar
  WHERE status != 'Descartado'
  GROUP BY obra_id
),

atrasos AS (
  -- Exemplares com empréstimo ativo e vencido (= volumes em atraso agora)
  SELECT
    ex.obra_id,
    COUNT(DISTINCT e.id)  AS em_atraso
  FROM emprestimo e
  JOIN exemplar ex ON ex.id = e.exemplar_id
  WHERE e.data_devolucao_real   IS NULL
    AND e.data_previsao_devolucao <  CURRENT_DATE
  GROUP BY ex.obra_id
),

multas_pagas AS (
  -- Total efetivamente recebido por obra
  SELECT
    ex.obra_id,
    SUM(m.valor_pago)  AS total_pago
  FROM multa m
  JOIN emprestimo  e  ON e.id  = m.emprestimo_id
  JOIN exemplar   ex  ON ex.id = e.exemplar_id
  WHERE m.status_pagamento = 'Pago'
  GROUP BY ex.obra_id
)

SELECT
  ac.descricao                           AS area_conhecimento,
  o.titulo                               AS obra,
  tp.descricao                           AS tipo_obra,
  COALESCE(v.total_acervo,   0)          AS volumes_acervo,
  COALESCE(v.emprestados,    0)          AS volumes_emprestados,
  COALESCE(at.em_atraso,     0)          AS volumes_em_atraso,
  COALESCE(mp.total_pago,    0.00)       AS multas_pagas

FROM area_conhecimento ac
LEFT JOIN obra          o   ON o.area_conhecimento_id = ac.id
LEFT JOIN tipo_obra     tp  ON tp.id  = o.tipo_obra_id
LEFT JOIN volumes       v   ON v.obra_id  = o.id
LEFT JOIN atrasos       at  ON at.obra_id = o.id
LEFT JOIN multas_pagas  mp  ON mp.obra_id = o.id

ORDER BY
  ac.descricao,
  volumes_emprestados DESC,
  o.titulo;