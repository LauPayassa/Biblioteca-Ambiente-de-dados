-- ============================================================
-- Relatório 2: Estatísticas de uso por obra
-- ============================================================

WITH base AS (
  -- Une obra com todos os seus empréstimos e multas (LEFT JOIN para incluir
  -- obras sem nenhum empréstimo)
  SELECT
    o.id                  AS obra_id,
    o.titulo,
    tp.descricao          AS tipo_obra,
    ac.descricao          AS area_conhecimento,
    e.id                  AS emprestimo_id,
    e.data_emprestimo,
    m.valor_multa,
    m.valor_pago,
    m.status_pagamento
  FROM obra o
  JOIN tipo_obra         tp  ON tp.id = o.tipo_obra_id
  JOIN area_conhecimento ac  ON ac.id = o.area_conhecimento_id
  LEFT JOIN exemplar     ex  ON ex.obra_id = o.id
  LEFT JOIN emprestimo    e  ON e.exemplar_id = ex.id
  LEFT JOIN multa         m  ON m.emprestimo_id = e.id
),

stats AS (
  SELECT
    obra_id,
    titulo,
    tipo_obra,
    area_conhecimento,
    COUNT(emprestimo_id)                                                            AS total_emprestimos,
    MIN(data_emprestimo)                                                            AS primeiro_emprestimo,
    MAX(data_emprestimo)                                                            AS ultimo_emprestimo,
    COALESCE(SUM(valor_multa), 0)                                                   AS total_multas_geradas,
    COALESCE(SUM(CASE WHEN status_pagamento = 'Pago'     THEN valor_pago  END), 0) AS total_multas_pagas,
    COALESCE(SUM(CASE WHEN status_pagamento = 'Pendente' THEN valor_multa END), 0) AS total_multas_pendentes
  FROM base
  GROUP BY obra_id, titulo, tipo_obra, area_conhecimento
)

SELECT
  -- Ranking geral de popularidade
  RANK() OVER (ORDER BY total_emprestimos DESC)  AS ranking_popularidade,

  titulo,
  tipo_obra,
  area_conhecimento,
  total_emprestimos,

  -- Média mensal: total ÷ nº de meses desde o 1º empréstimo
  ROUND(
    total_emprestimos /
    NULLIF(
      TIMESTAMPDIFF(MONTH, primeiro_emprestimo, CURRENT_DATE) + 1,
    0),
    2
  )                                              AS media_emprestimos_por_mes,

  -- Média semestral: total ÷ nº de semestres completos (agrupamento de 6 meses)
  ROUND(
    total_emprestimos /
    NULLIF(
      CEIL((TIMESTAMPDIFF(MONTH, primeiro_emprestimo, CURRENT_DATE) + 1) / 6.0),
    0),
    2
  )                                              AS media_emprestimos_por_semestre,

  primeiro_emprestimo,
  ultimo_emprestimo,

  total_multas_geradas,
  total_multas_pagas,
  total_multas_pendentes

FROM stats
ORDER BY ranking_popularidade;
