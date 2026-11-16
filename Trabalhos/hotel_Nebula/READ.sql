USE hotel_nebula;

-- READ
-- Selecionar todos os registros de uma tabela

-- SELECT * FROM hospedes;
-- SELECT * FROM quartos;
-- SELECT * FROM reservas;

-- 1 Quais quartos estão disponíveis em determinado período?
-- (troca as datas pra testar outro periodo)
SELECT numero AS "Quarto", tipo AS "Tipo", preco_diaria AS "Diaria" FROM quartos
WHERE status <> "manutencao"
AND id_quarto NOT IN (
    SELECT id_quarto FROM reservas
    WHERE status <> "cancelada"
    AND data_checkin < "2026-12-05"
    AND data_checkout > "2026-12-01"
)
ORDER BY numero;

-- 2 Quais hóspedes mais realizaram reservas?
SELECT hospedes.nome AS "Hospede", COUNT(reservas.id_reserva) AS "total_reservas"
FROM hospedes
JOIN reservas ON reservas.id_hospede = hospedes.id_hospede
GROUP BY hospedes.nome
ORDER BY total_reservas DESC;

-- 3 Qual foi o faturamento por mês?
SELECT DATE_FORMAT(data_pagamento, "%Y-%m") AS "Mes", SUM(valor) AS "Faturamento"
FROM pagamentos
WHERE status = "aprovado"
GROUP BY Mes
ORDER BY Mes;

-- 4 Quais serviços extras são mais consumidos?
SELECT servicos.nome AS "Servico", SUM(hospedagem_servicos.quantidade) AS "total_consumido"
FROM servicos
JOIN hospedagem_servicos ON hospedagem_servicos.id_servico = servicos.id_servico
GROUP BY servicos.nome
ORDER BY total_consumido DESC;

-- 5 Quais quartos receberam melhores avaliações?
SELECT quartos.numero AS "Quarto", quartos.tipo AS "Tipo", AVG(feedbacks.nota) AS "media_nota", COUNT(*) AS "qtd_avaliacoes"
FROM quartos
JOIN feedbacks ON feedbacks.id_quarto = quartos.id_quarto
GROUP BY quartos.numero, quartos.tipo
ORDER BY media_nota DESC;

-- 6 Quais reservas foram canceladas?
SELECT reservas.id_reserva, hospedes.nome AS "Hospede", reservas.data_checkin AS "Checkin", reservas.observacoes AS "Motivo"
FROM reservas
JOIN hospedes ON hospedes.id_hospede = reservas.id_hospede
WHERE reservas.status = "cancelada";

-- 7 Quantas hospedagens cada profissional atendeu?
SELECT funcionarios.nome AS "Funcionario", funcionarios.cargo AS "Cargo", COUNT(hospedagens.id_hospedagem) AS "total_hospedagens"
FROM funcionarios
LEFT JOIN hospedagens ON hospedagens.id_funcionario = funcionarios.id_funcionario
GROUP BY funcionarios.nome, funcionarios.cargo
ORDER BY total_hospedagens DESC;
