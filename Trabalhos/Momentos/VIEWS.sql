SELECT
  funcionarios.funcionario_id AS funcionario_id,
  CONCAT(funcionarios.primeiro_nome, ' ', funcionarios.sobrenome) AS 'funcionario_nome',
  funcionarios.telefone AS telefone,
  funcionarios.email AS email,
  funcionarios.data_contratacao AS data_contratacao,
  cargos.cargo_nome AS cargo,
  funcionarios.salario AS salario,
  cargos.min_salario AS min_salario,
  cargos.max_salario AS max_salario,
  departamentos.departamento_nome AS departamento,
  escritorios.escritorio_nome AS escritorio,
  escritorios.endereco AS endereco,
  paises.pais_nome AS pais,
  regioes.regiao_nome AS regiao
 
 FROM funcionarios
 
INNER JOIN cargos
  ON funcionarios.cargo_id = cargos.cargo_id
INNER JOIN departamentos
  ON funcionarios.departamento_id = departamentos.departamento_id
INNER JOIN escritorios
  ON departamentos.escritorio_id = escritorios.escritorio_id
INNER JOIN paises
  ON escritorios.pais_id = paises.pais_id
INNER JOIN regioes
  ON paises.regiao_id = regioes.regiao_id;