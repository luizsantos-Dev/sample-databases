-- Hotel Nebula
-- CREATE database hotel_nebula;

CREATE DATABASE IF NOT EXISTS hotel_nebula;

-- Escolho o banco para trabalhar
USE hotel_nebula;

-- Apagar as tabelas (na ordem certa por causa das FKs)
DROP TABLE IF EXISTS feedbacks;
DROP TABLE IF EXISTS pagamentos;
DROP TABLE IF EXISTS hospedagem_servicos;
DROP TABLE IF EXISTS hospedagens;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS servicos;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS quartos;
DROP TABLE IF EXISTS hospedes;

-- Regras/constraints usadas:
-- PRIMARY KEY     > torna o campo único e obrigatório
-- AUTO_INCREMENT  > o id vai somando sozinho
-- NOT NULL        > Não Vazio/Obrigatório
-- UNIQUE          > Único
-- DEFAULT         > Se o campo estiver vazio ele preenche com o valor informado
-- FOREIGN KEY     > liga a coluna com o id de outra tabela
-- CHECK           > só aceita valores que passam na regra

-- Hospedes
CREATE TABLE IF NOT EXISTS hospedes(
  id_hospede        INT PRIMARY KEY AUTO_INCREMENT
  ,nome             VARCHAR(100) NOT NULL
  ,email            VARCHAR(100) NOT NULL UNIQUE
  ,cpf              VARCHAR(14) UNIQUE
  ,telefone         VARCHAR(20)
  ,data_nascimento  DATE
  ,cidade           VARCHAR(60)
  ,estado           CHAR(2)
  ,data_cadastro    DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Quartos
CREATE TABLE IF NOT EXISTS quartos(
  id_quarto         INT PRIMARY KEY AUTO_INCREMENT
  ,numero           VARCHAR(10) NOT NULL UNIQUE
  ,tipo             VARCHAR(50) NOT NULL
  ,andar            INT
  ,capacidade       INT NOT NULL
  ,preco_diaria     DECIMAL(10,2) NOT NULL
  ,status           VARCHAR(20) DEFAULT "disponivel"
  ,descricao        VARCHAR(255)
  ,CHECK (status IN ("disponivel", "ocupado", "manutencao"))
);

-- Funcionarios
CREATE TABLE IF NOT EXISTS funcionarios(
  id_funcionario    INT PRIMARY KEY AUTO_INCREMENT
  ,nome             VARCHAR(100) NOT NULL
  ,cpf              VARCHAR(14) NOT NULL UNIQUE
  ,email            VARCHAR(100) UNIQUE
  ,cargo            VARCHAR(50) NOT NULL
  ,salario          DECIMAL(10,2)
  ,data_admissao    DATE
  ,ativo            BOOLEAN DEFAULT true
);

-- Servicos extras do hotel
CREATE TABLE IF NOT EXISTS servicos(
  id_servico        INT PRIMARY KEY AUTO_INCREMENT
  ,nome             VARCHAR(80) NOT NULL
  ,categoria        VARCHAR(40)
  ,preco            DECIMAL(10,2) NOT NULL
  ,ativo            BOOLEAN DEFAULT true
);

-- Reservas (id_funcionario = quem fez a reserva)
CREATE TABLE IF NOT EXISTS reservas(
  id_reserva        INT PRIMARY KEY AUTO_INCREMENT
  ,id_hospede       INT NOT NULL
  ,id_quarto        INT NOT NULL
  ,id_funcionario   INT
  ,data_checkin     DATE NOT NULL
  ,data_checkout    DATE NOT NULL
  ,qtd_hospedes     INT DEFAULT 1
  ,valor_total      DECIMAL(10,2)
  ,status           VARCHAR(20) DEFAULT "pendente"
  ,observacoes      VARCHAR(255)
  ,FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede)
  ,FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto)
  ,FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
  ,CHECK (data_checkout > data_checkin)
  ,CHECK (status IN ("pendente", "confirmada", "em_andamento", "concluida", "cancelada"))
);

-- Hospedagens (cada reserva gera no maximo uma hospedagem)
-- id_funcionario = quem atendeu o hospede
CREATE TABLE IF NOT EXISTS hospedagens(
  id_hospedagem     INT PRIMARY KEY AUTO_INCREMENT
  ,id_reserva       INT NOT NULL UNIQUE
  ,id_funcionario   INT NOT NULL
  ,checkin_real     DATETIME NOT NULL
  ,checkout_real    DATETIME
  ,FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva)
  ,FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

-- Tabela que liga hospedagens com servicos (o que foi consumido)
CREATE TABLE IF NOT EXISTS hospedagem_servicos(
  id_consumo        INT PRIMARY KEY AUTO_INCREMENT
  ,id_hospedagem    INT NOT NULL
  ,id_servico       INT NOT NULL
  ,id_funcionario   INT
  ,quantidade       INT DEFAULT 1
  ,preco_unitario   DECIMAL(10,2) NOT NULL
  ,data_consumo     DATETIME
  ,FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem)
  ,FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
  ,FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

-- Pagamentos
CREATE TABLE IF NOT EXISTS pagamentos(
  id_pagamento      INT PRIMARY KEY AUTO_INCREMENT
  ,id_hospedagem    INT NOT NULL
  ,valor            DECIMAL(10,2) NOT NULL
  ,metodo           VARCHAR(30)
  ,parcelas         INT DEFAULT 1
  ,data_pagamento   DATETIME
  ,status           VARCHAR(20) DEFAULT "aprovado"
  ,FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem)
);

-- Feedbacks (nota de 1 a 5, ligado ao hospede, ao quarto e a hospedagem)
CREATE TABLE IF NOT EXISTS feedbacks(
  id_feedback       INT PRIMARY KEY AUTO_INCREMENT
  ,id_hospede       INT NOT NULL
  ,id_quarto        INT NOT NULL
  ,id_hospedagem    INT NOT NULL UNIQUE
  ,nota             INT NOT NULL
  ,comentario       VARCHAR(500)
  ,data_feedback    DATETIME DEFAULT CURRENT_TIMESTAMP
  ,FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede)
  ,FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto)
  ,FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem)
  ,CHECK (nota BETWEEN 1 AND 5)
);

-- INSERTS

INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Ana Souza','ana.souza@email.com','111.111.111-11','(11) 98888-0001','1990-03-12','São Paulo','SP');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Bruno Lima','bruno.lima@email.com','222.222.222-22','(21) 98888-0002','1985-07-25','Rio de Janeiro','RJ');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Carla Mendes','carla.mendes@email.com','333.333.333-33','(31) 98888-0003','1992-11-02','Belo Horizonte','MG');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Diego Alves','diego.alves@email.com','444.444.444-44','(41) 98888-0004','1988-01-30','Curitiba','PR');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Elisa Rocha','elisa.rocha@email.com','555.555.555-55','(51) 98888-0005','1979-05-18','Porto Alegre','RS');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Felipe Costa','felipe.costa@email.com','666.666.666-66','(71) 98888-0006','1995-09-09','Salvador','BA');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Gabriela Nunes','gabriela.nunes@email.com','777.777.777-77','(81) 98888-0007','1991-12-21','Recife','PE');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Henrique Dias','henrique.dias@email.com','888.888.888-88','(61) 98888-0008','1983-04-14','Brasília','DF');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('Isabela Martins','isabela.martins@email.com','999.999.999-99','(85) 98888-0009','1998-08-03','Fortaleza','CE');
INSERT INTO hospedes(nome,email,cpf,telefone,data_nascimento,cidade,estado) VALUES ('João Pereira','joao.pereira@email.com','101.101.101-10','(11) 98888-0010','1975-02-27','Campinas','SP');

INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('101','Standard',1,2,250.00,'disponivel','Cama de casal');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('102','Standard',1,2,250.00,'disponivel','Duas camas de solteiro');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('103','Standard',1,3,290.00,'disponivel','Casal + solteiro');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('201','Luxo',2,2,420.00,'disponivel','Cama king com varanda');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('202','Luxo',2,3,460.00,'ocupado','Cama king + sofá-cama');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('203','Luxo',2,2,420.00,'disponivel','Vista para o mar');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('301','Suite',3,4,780.00,'disponivel','Sala de estar e hidromassagem');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('302','Suite',3,2,690.00,'disponivel','Banheira');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('401','Presidencial',4,4,1500.00,'disponivel','Cobertura com terraço');
INSERT INTO quartos(numero,tipo,andar,capacidade,preco_diaria,status,descricao) VALUES ('104','Standard',1,2,250.00,'manutencao','Banheiro em reforma');

INSERT INTO funcionarios(nome,cpf,email,cargo,salario,data_admissao) VALUES ('Marcos Ribeiro','121.000.000-01','marcos@hotelnebula.com','Recepcionista',2800.00,'2022-02-01');
INSERT INTO funcionarios(nome,cpf,email,cargo,salario,data_admissao) VALUES ('Patrícia Gomes','121.000.000-02','patricia@hotelnebula.com','Recepcionista',2800.00,'2023-05-15');
INSERT INTO funcionarios(nome,cpf,email,cargo,salario,data_admissao) VALUES ('Rafael Teixeira','121.000.000-03','rafael@hotelnebula.com','Gerente',7500.00,'2020-08-10');
INSERT INTO funcionarios(nome,cpf,email,cargo,salario,data_admissao) VALUES ('Sandra Oliveira','121.000.000-04','sandra@hotelnebula.com','Camareira',2100.00,'2021-11-03');
INSERT INTO funcionarios(nome,cpf,email,cargo,salario,data_admissao) VALUES ('Tiago Barbosa','121.000.000-05','tiago@hotelnebula.com','Garçom',2300.00,'2024-01-20');
INSERT INTO funcionarios(nome,cpf,email,cargo,salario,data_admissao) VALUES ('Vanessa Freitas','121.000.000-06','vanessa@hotelnebula.com','Concierge',3200.00,'2022-09-12');

INSERT INTO servicos(nome,categoria,preco) VALUES ('Café da manhã','Alimentação',45.00);
INSERT INTO servicos(nome,categoria,preco) VALUES ('Lavanderia','Limpeza',60.00);
INSERT INTO servicos(nome,categoria,preco) VALUES ('Massagem','Spa',180.00);
INSERT INTO servicos(nome,categoria,preco) VALUES ('Room service','Alimentação',85.00);
INSERT INTO servicos(nome,categoria,preco) VALUES ('Transfer aeroporto','Transporte',120.00);
INSERT INTO servicos(nome,categoria,preco) VALUES ('Estacionamento','Transporte',35.00);
INSERT INTO servicos(nome,categoria,preco) VALUES ('Passeio turístico','Lazer',250.00);
INSERT INTO servicos(nome,categoria,preco) VALUES ('Frigobar','Alimentação',40.00);

INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (1,1,1,'2026-01-10','2026-01-13',2,750.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (2,4,2,'2026-01-15','2026-01-18',2,1260.00,'concluida','Aniversário de casamento');
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (3,7,1,'2026-02-05','2026-02-08',4,2340.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (1,5,2,'2026-02-14','2026-02-16',3,920.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (4,2,1,'2026-02-20','2026-02-22',2,500.00,'cancelada','Cancelada pelo hóspede');
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (5,9,6,'2026-03-01','2026-03-04',4,4500.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (6,3,2,'2026-03-10','2026-03-12',3,580.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (2,8,1,'2026-03-20','2026-03-23',2,2070.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (7,6,2,'2026-04-02','2026-04-05',2,1260.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (1,7,6,'2026-04-18','2026-04-21',4,2340.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (8,1,1,'2026-05-05','2026-05-07',1,500.00,'cancelada','Não compareceu');
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (9,4,2,'2026-05-10','2026-05-14',2,1680.00,'concluida',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (2,2,1,'2026-12-01','2026-12-04',2,750.00,'confirmada',NULL);
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (10,7,6,'2026-12-20','2026-12-27',4,5460.00,'confirmada','Réveillon');
INSERT INTO reservas(id_hospede,id_quarto,id_funcionario,data_checkin,data_checkout,qtd_hospedes,valor_total,status,observacoes) VALUES (3,5,2,'2026-11-15','2026-11-18',3,1380.00,'em_andamento',NULL);

INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (1,1,'2026-01-10 14:10','2026-01-13 11:00');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (2,2,'2026-01-15 15:30','2026-01-18 10:40');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (3,1,'2026-02-05 13:50','2026-02-08 11:55');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (4,2,'2026-02-14 16:00','2026-02-16 12:00');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (6,6,'2026-03-01 12:00','2026-03-04 12:00');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (7,2,'2026-03-10 14:20','2026-03-12 10:15');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (8,1,'2026-03-20 15:05','2026-03-23 11:30');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (9,2,'2026-04-02 14:00','2026-04-05 11:00');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (10,6,'2026-04-18 14:45','2026-04-21 11:20');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (12,1,'2026-05-10 15:00','2026-05-14 10:50');
INSERT INTO hospedagens(id_reserva,id_funcionario,checkin_real,checkout_real) VALUES (15,2,'2026-11-15 14:30',NULL);

INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (1,1,5,4,45.00,'2026-01-11 08:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (1,8,NULL,2,40.00,'2026-01-12 22:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (2,1,5,6,45.00,'2026-01-16 08:30');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (2,3,6,2,180.00,'2026-01-16 15:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (2,4,5,1,85.00,'2026-01-17 21:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (3,1,5,8,45.00,'2026-02-06 08:10');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (3,7,6,1,250.00,'2026-02-07 09:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (3,6,NULL,3,35.00,'2026-02-05 14:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (4,1,5,3,45.00,'2026-02-15 08:20');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (4,2,4,1,60.00,'2026-02-15 10:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (5,1,5,8,45.00,'2026-03-02 08:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (5,3,6,4,180.00,'2026-03-02 16:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (5,5,6,2,120.00,'2026-03-01 10:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (5,4,5,2,85.00,'2026-03-03 20:30');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (6,1,5,3,45.00,'2026-03-11 08:40');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (7,1,5,4,45.00,'2026-03-21 08:15');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (7,3,6,2,180.00,'2026-03-21 17:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (7,8,NULL,3,40.00,'2026-03-22 23:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (8,1,5,4,45.00,'2026-04-03 08:05');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (8,7,6,2,250.00,'2026-04-04 09:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (9,1,5,8,45.00,'2026-04-19 08:30');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (9,6,NULL,3,35.00,'2026-04-18 15:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (9,2,4,2,60.00,'2026-04-20 10:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (10,1,5,6,45.00,'2026-05-11 08:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (10,5,6,1,120.00,'2026-05-10 13:00');
INSERT INTO hospedagem_servicos(id_hospedagem,id_servico,id_funcionario,quantidade,preco_unitario,data_consumo) VALUES (11,1,5,3,45.00,'2026-11-16 08:10');

-- valor = diarias + servicos consumidos (a ultima e so o sinal da hospedagem que ainda ta rolando)
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (1,1010.00,'cartao_credito',1,'2026-01-13 11:00','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (2,1975.00,'pix',1,'2026-01-18 10:40','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (3,3055.00,'cartao_debito',1,'2026-02-08 11:55','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (4,1115.00,'dinheiro',1,'2026-02-16 12:00','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (5,5990.00,'pix',1,'2026-03-04 12:00','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (6,715.00,'cartao_credito',1,'2026-03-12 10:15','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (7,2730.00,'pix',1,'2026-03-23 11:30','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (8,1940.00,'cartao_credito',1,'2026-04-05 11:00','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (9,2925.00,'cartao_debito',1,'2026-04-21 11:20','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (10,2070.00,'pix',1,'2026-05-14 10:50','aprovado');
INSERT INTO pagamentos(id_hospedagem,valor,metodo,parcelas,data_pagamento,status) VALUES (11,414.00,'pix',1,'2026-11-15 14:35','aprovado');

INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (1,1,1,4,'Quarto confortável, café da manhã muito bom','2026-01-13 18:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (2,4,2,5,'Atendimento ótimo, adoramos a decoração','2026-01-18 20:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (3,7,3,5,'Suíte grande, perfeita pra família','2026-02-09 10:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (1,5,4,3,'Ar-condicionado fazendo barulho','2026-02-16 19:30');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (5,9,5,5,'Melhor hotel que já fiquei','2026-03-04 15:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (6,3,6,3,'Ok pelo preço, meio barulhento','2026-03-12 12:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (2,8,7,4,'Banheira excelente, check-in demorou','2026-03-23 17:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (7,6,8,5,'Vista linda','2026-04-05 14:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (1,7,9,4,'Faltou toalha extra','2026-04-21 16:00');
INSERT INTO feedbacks(id_hospede,id_quarto,id_hospedagem,nota,comentario,data_feedback) VALUES (9,4,10,2,'Varanda suja quando cheguei','2026-05-14 13:00');
