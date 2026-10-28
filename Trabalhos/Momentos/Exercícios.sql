use momento
/* 1.1 Você acabou de ser contratado pela Momento! Vamos começar incluindo você no sistema. */
INSERT INTO funcionarios(funcionario_id,primeiro_nome,sobrenome,email,senha,telefone,data_contratacao,cargo_id,salario,gerente_id,departamento_id) 
VALUES (167,'Luiz','Gonzaga','luiz.santos@momento.org','@4@8@15@16','515.123.4567','1987-06-17',4,50000.00,NULL,9);

/* 1.2 Agora que você faz parte da equipe, quantos funcionários temos ao total na empresa? */
SELECT COUNT(*) FROM funcionarios;

/* 1.3 Quantos funcionários trabalham especificamente no Departamento de Tecnologia? */
SELECT COUNT(funcionario_id) AS "funcionarios de tecnologia" FROM funcionarios
JOIN departamentos ON funcionarios.departamento_id = departamentos.departamento_id
WHERE departamento_nome = "tecnologia";
 
/* 1.4 Liste todos os departamentos que existem na empresa. Quantos são? */
SELECT DISTINCT departamento_nome AS "Departamentos da empresa" FROM departamentos;
SELECT COUNT(DISTINCT departamento_nome) AS "Total de departamentos" FROM departamentos;

/* 1.5 Quantos escritórios a Momento possui? Em quais países? */
SELECT COUNT(escritorio_id) AS "Quantidade de escritórios", pais_nome AS "Paises" FROM escritorios 
JOIN paises ON 
escritorios.pais_id = paises.pais_id 
GROUP BY paises.pais_nome;

/*-----------NÍVEL 2--------------	*/
/* 2.1 Quantos funcionários trabalham no Departamento de Vendas? */
SELECT 


