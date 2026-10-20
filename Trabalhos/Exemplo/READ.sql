USE oscar_database;

-- READ
-- Selecionar todos os registros de uma tabela

-- SELECT * FROM indicados_ao_oscar  

SELECT * FROM indicados_ao_oscar  
WHERE nome_indicado = "Al Pacino" AND vencedor = 1
ORDER BY nome_indicado; 

--
SELECT * FROM indicados_ao_oscar
WHERE nome_indicado LIKE "Al%"
ORDER BY ano_cerimonia;
