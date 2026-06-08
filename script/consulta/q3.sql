-- ============================================================
-- Relatório 3: Usuários com obras em atraso (não devolvidas)
-- ============================================================

-- Status "Atrasado" = empréstimo ativo (sem devolução) e prazo vencido
-- Multa calculada = dias corridos desde o vencimento × valor_dia_multa do empréstimo

SELECT
  u.nome                                                         AS usuario,
  CASE
    WHEN a.id IS NOT NULL THEN 'Aluno'
    ELSE 'Professor'
  END                                                            AS tipo_usuario,

  o.titulo                                                       AS obra,
  tp.descricao                                                   AS tipo_obra,

  DATE_FORMAT(e.data_previsao_devolucao, '%d/%m/%Y')            AS data_vencimento,
  DATEDIFF(CURRENT_DATE, e.data_previsao_devolucao)              AS dias_atraso,

  -- Multa calculada no momento da emissão (pode diferir do registro em multa,
  -- pois o registro é feito na devolução; aqui é o valor acumulado hoje)
  ROUND(
    DATEDIFF(CURRENT_DATE, e.data_previsao_devolucao) * e.valor_dia_multa,
    2
  )                                                              AS multa_calculada_hoje,

  -- Status da multa já registrada (se houver)
  COALESCE(m.status_pagamento, 'Não registrada')                AS status_multa,

  -- Somente o telefone do tipo Celular
  ut.numero                                                      AS telefone_celular

FROM emprestimo e

JOIN usuario            u   ON u.id  = e.usuario_id
LEFT JOIN aluno         a   ON a.id  = u.id          -- NULL = professor
JOIN exemplar           ex  ON ex.id = e.exemplar_id
JOIN obra               o   ON o.id  = ex.obra_id
JOIN tipo_obra          tp  ON tp.id = o.tipo_obra_id
LEFT JOIN multa         m   ON m.emprestimo_id = e.id
LEFT JOIN usuario_telefone ut
  ON  ut.usuario_id = u.id
  AND ut.tipo       = 'Celular'

WHERE
  e.data_devolucao_real   IS NULL                -- ainda não devolvido
  AND e.data_previsao_devolucao < CURRENT_DATE   -- prazo vencido

ORDER BY
  dias_atraso DESC,
  u.nome;
