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

-- NIVEL 1
SELECT COUNT(*) FROM indicados_ao_oscar;
-- R 1.1: 10889 Registros 

-- EX 1.2.1
SELECT DISTINCT categoria FROM  indicados_ao_oscar;
-- R 1.2.1:  ACTOR, ACTRESS,"ART DIRECTION",CINEMATOGRAPHY,"DIRECTING (Comedy Picture)","DIRECTING (Dramatic Picture)","ENGINEERING EFFECTS","OUTSTANDING PICTURE","UNIQUE AND ARTISTIC PICTURE","WRITING (Adaptation)","WRITING (Original Story)","WRITING (Title Writing)","SPECIAL AWARD",DIRECTING,WRITING,"OUTSTANDING PRODUCTION","SOUND RECORDING","SHORT SUBJECT (Cartoon)","SHORT SUBJECT (Comedy)","SHORT SUBJECT (Novelty)","ASSISTANT DIRECTOR","FILM EDITING","MUSIC (Scoring)","MUSIC (Song)","DANCE DIRECTION","WRITING (Screenplay)","ACTOR IN A SUPPORTING ROLE","ACTRESS IN A SUPPORTING ROLE","SHORT SUBJECT (Color)","SHORT SUBJECT (One-reel)","SHORT SUBJECT (Two-reel)","IRVING G. THALBERG MEMORIAL AWARD","MUSIC (Original Score)","CINEMATOGRAPHY (Black-and-White)","CINEMATOGRAPHY (Color)","SPECIAL EFFECTS""ART DIRECTION (Black-and-White)""ART DIRECTION (Color)","WRITING (Original Screenplay)","DOCUMENTARY (Short Subject)","MUSIC (Music Score of a Dramatic Picture)","MUSIC (Scoring of a Musical Picture)","OUTSTANDING MOTION PICTURE",DOCUMENTARY,"MUSIC (Music Score of a Dramatic or Comedy Picture)","WRITING (Original Motion Picture Story)","DOCUMENTARY (Feature)","BEST MOTION PICTURE","WRITING (Motion Picture Story)","COSTUME DESIGN (Black-and-White)","COSTUME DESIGN (Color)","SPECIAL FOREIGN LANGUAGE FILM AWARD","WRITING (Story and Screenplay)","HONORARY FOREIGN LANGUAGE FILM AWARD""HONORARY AWARD","FOREIGN LANGUAGE FILM","WRITING (Screenplay--Adapted)","WRITING (Screenplay--Original)","JEAN HERSHOLT HUMANITARIAN AWARD","COSTUME DESIGN","SHORT SUBJECT (Live Action)","WRITING (Screenplay--based on material from another medium)","WRITING (Story and Screenplay--written directly for the screen)",SOUND,"MUSIC (Music Score--substantially original)","MUSIC (Scoring of Music--adaptation or treatment)","BEST PICTURE","SOUND EFFECTS","SPECIAL VISUAL EFFECTS","MUSIC (Original Music Score)","MUSIC (Original Score--for a motion picture [not a musical])","MUSIC (Score of a Musical Picture--original or adaptation)","MUSIC (Song--Original for the Picture)","WRITING (Story and Screenplay--based on material not previously published or produced)","MUSIC (Original Song Score)","WRITING (Story and Screenplay--based on factual material or material not previously published or produced)","MUSIC (Original Dramatic Score)","MUSIC (Scoring: Adaptation and Original Song Score)","SHORT SUBJECT (Animated)","SPECIAL ACHIEVEMENT AWARD (Visual Effects)","MUSIC (Scoring: Original Song Score and Adaptation -or- Scoring: Adaptation)","SHORT FILM (Animated)","SHORT FILM (Live Action)","WRITING (Screenplay Adapted from Other Material)","MUSIC (Original Song)","SPECIAL ACHIEVEMENT AWARD (Sound Effects)","ACTOR IN A LEADING ROLE","ACTRESS IN A LEADING ROLE","MUSIC (Original Song Score and Its Adaptation or Adaptation Score)","WRITING (Screenplay Written Directly for the Screen--based on factual material or on story material not previously published or produced)","VISUAL EFFECTS","SPECIAL ACHIEVEMENT AWARD","SPECIAL ACHIEVEMENT AWARD (Sound Effects Editing)","MUSIC (Adaptation Score)","WRITING (Screenplay Based on Material from Another Medium)","WRITING (Screenplay Written Directly for the Screen)","MUSIC (Original Song Score and Its Adaptation -or- Adaptation Score)","SPECIAL ACHIEVEMENT AWARD (Sound Editing)","SHORT FILM (Dramatic Live Action)",MAKEUP,"SOUND EFFECTS EDITING","MUSIC (Original Song Score or Adaptation Score)","WRITING (Screenplay Based on Material Previously Produced or Published)","MUSIC (Original Musical or Comedy Score)","SOUND EDITING","ANIMATED FEATURE FILM","WRITING (Adapted Screenplay)","SOUND MIXING","MAKEUP AND HAIRSTYLING","PRODUCTION DESIGN","INTERNATIONAL FEATURE FILM","DOCUMENTARY FEATURE FILM","DOCUMENTARY SHORT FILM","GORDON E. SAWYER AWARD", "AWARD OF COMMENDATION"

-- EX 1.2.2
SELECT COUNT(DISTINCT categoria) FROM indicados_ao_oscar;
--  R 1.2.2: 115 Registros

-- EX 1.3
SELECT * FROM indicados_ao_oscar ORDER BY ano_cerimonia; 
--  R 1.3: 1928

-- EX 1.4
SELECT * FROM indicados_ao_oscar ORDER BY ano_cerimonia DESC;
-- R 1.4: 2024

-- EX 1.5
SELECT COUNT(DISTINCT ano_cerimonia) FROM  indicados_ao_oscar;
-- R 1.5: 96 Registros

-- EX 1.6
-- PULADO
-- R 1.6:

-- NIVEL 2

-- EX 2.1
SELECT categoria, COUNT(*)
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY COUNT(*) ;
-- R 2.1: DIRECTING MAIOR COM 469 REGISTRO - SPECIAL ACHIEVEMENT AWARD (Sound Editing) MENOR COM 1 REGISTRO

-- EX 2.2
SELECT categoria, COUNT(*) AS "Contagem"
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY COUNT(*);
-- R 2.2: DIRECTING MAIOR COM 469 REGISTRO

-- EX 2.3
SELECT categoria, COUNT(*)
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY COUNT(*);
-- R 2.3:SPECIAL ACHIEVEMENT AWARD (Sound Editing) MENOR COM 1 REGISTRO

-- EX 2.4
SELECT categoria, ano_cerimonia
FROM indicados_ao_oscar   
WHERE categoria = "ACTRESS" 
ORDER BY ano_cerimonia desc ; 
-- R 2.4: 1976

-- EX 2.5
SELECT categoria, ano_cerimonia
FROM indicados_ao_oscar   
WHERE ano_cerimonia = "1928"
GROUP BY categoria 
ORDER BY categoria; 
-- R 2.5:

-- EX 2.6
SELECT DISTINCT categoria AS "Categorias com a palavra DIRECTING" FROM indicados_ao_oscar
WHERE categoria LIKE "%DIRECTING%"
ORDER BY categoria;
-- R 2.6:

-- NÍVEL 3

-- 3.1 Quantas vezes Natalie Portman foi indicada ao Oscar?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Natalie Portman foi indicada" FROM indicados_ao_oscar
    WHERE nome_indicado = "Natalie Portman";
    
-- 3.2 Quantos Oscars Natalie Portman ganhou?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Natalie Portman foi indicada(e venceu)" FROM indicados_ao_oscar
	WHERE nome_indicado = "Natalie Portman" AND vencedor = 1;

-- 3.3 Em quais anos e por quais filmes Natalie Portman foi indicada?
SELECT ano_cerimonia AS "Ano indicado", nome_filme AS "Filmes indicado" FROM indicados_ao_oscar
    WHERE nome_indicado = "Natalie Portman";

-- 3.4 Liste todas as indicações de Natalie Portman mostrando: ano, categoria, filme e se venceu.
SELECT ano_cerimonia AS "Ano indicado", nome_filme AS "Filmes indicado", categoria AS "Categoria", vencedor  FROM indicados_ao_oscar
    WHERE nome_indicado = "Natalie Portman";

-- 3.5 Quantas vezes Viola Davis foi indicada ao Oscar?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Viola Davis foi indicada" FROM indicados_ao_oscar
    WHERE nome_indicado = "Viola Davis";

-- 3.6 Quantos Oscars Viola Davis ganhou?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Viola Davis foi indicada(e venceu)" FROM indicados_ao_oscar
WHERE nome_indicado = "Viola Davis" AND vencedor = 1;

-- 3.7 Por quais filmes Viola Davis foi indicada?
SELECT nome_filme AS "Filmes indicado" FROM indicados_ao_oscar
    WHERE nome_indicado = "Viola Davis";
    
-- 3.8 Amy Adams já ganhou algum Oscar?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Amy Adams venceu?" FROM indicados_ao_oscar
	WHERE nome_indicado = "Amy Adams" AND vencedor = 1;

-- 3.9 Quantas vezes Amy Adams foi indicada sem ganhar?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Amy Adams sem vencer?" FROM indicados_ao_oscar
	WHERE nome_indicado = "Amy Adams" AND vencedor = 0;

-- 3.10 Denzel Washington já ganhou algum Oscar?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Denzel Washington" FROM indicados_ao_oscar
	WHERE nome_indicado = "Denzel Washington" AND vencedor = 1;

-- 3.11 Quantas vezes Denzel Washington foi indicado ao Oscar?
SELECT COUNT(nome_indicado) AS "Quantidade de vezes que Denzel Washington" FROM indicados_ao_oscar
	WHERE nome_indicado = "Denzel Washington";

-- 3.12 Liste todos os Oscars que Denzel Washington ganhou (ano, categoria, filme).
SELECT ano_cerimonia AS "Ano indicado", nome_filme AS "Filmes indicado", categoria AS "Categoria", vencedor  FROM indicados_ao_oscar
    WHERE nome_indicado = "Denzel Washington" AND vencedor = 1;

-- NÍVEL 4 

-- 4.1 Quem ganhou o primeiro Oscar para Melhor Atriz (ACTRESS)? Em que ano e por qual filme?
SELECT nome_indicado AS "Ator/Atriz", ano_cerimonia AS "Ano", nome_filme AS "Filme" FROM indicados_ao_oscar
WHERE categoria = "ACTRESS" and vencedor = true LIMIT 1;

-- 4.2 Quem ganhou o primeiro Oscar para Melhor Ator (ACTOR)? Em que ano e por qual filme?
SELECT nome_indicado AS "Ator/Atriz", ano_cerimonia AS "Ano", nome_filme AS "Filme" FROM indicados_ao_oscar
WHERE categoria = "ACTOR" and vencedor = true LIMIT 1;

-- 4.3 Quantos vencedores existem ao todo na base de dados?
SELECT 	COUNT(vencedor) FROM indicados_ao_oscar WHERE vencedor = true;

-- 4.4 Liste todos os filmes que ganharam o Oscar de Melhor Filme (categoria "OUTSTANDING PICTURE" ou "BEST PICTURE").
SELECT nome_filme AS "Filme" FROM indicados_ao_oscar
WHERE categoria = "OUTSTANDING PICTURE" or categoria = "BEST PICTURE";

-- 4.5 Quantos filmes diferentes já ganharam o Oscar?
SELECT 	COUNT(DISTINCT categoria) FROM indicados_ao_oscar WHERE vencedor = true;

-- NÍVEL 5
-- 5.1 Quais atores/atrizes foram indicados mais de uma vez? Liste o nome e o número de indicações.
SELECT nome_indicado AS "Ator_Atriz", COUNT(nome_indicado) AS "total_indicacoes"
FROM indicados_ao_oscar
GROUP BY nome_indicado
HAVING COUNT(nome_indicado) > 1
ORDER BY total_indicacoes DESC;

-- 5.2 Qual ator ou atriz tem o maior número de indicações na história do Oscar?
SELECT nome_indicado AS "Ator_Atriz", COUNT(nome_indicado) AS "total_indicacoes"
FROM indicados_ao_oscar
GROUP BY nome_indicado
HAVING COUNT(nome_indicado) > 1
ORDER BY total_indicacoes DESC LIMIT 1;

-- 5.3 Quais atores foram indicados mais de 3 vezes, mas nunca ganharam?
SELECT nome_indicado AS "Ator_Atriz", COUNT(nome_indicado) AS "total_indicacoes"
FROM indicados_ao_oscar
WHERE vencedor = false
GROUP BY nome_indicado
HAVING COUNT(nome_indicado) > 3  
ORDER BY total_indicacoes DESC LIMIT 1;

-- 5.4 Encontre todos os artistas que foram indicados em categorias diferentes (ex: ator e diretor).
 SELECT nome_indicado AS "Artista",
 GROUP_CONCAT(DISTINCT categoria SEPARATOR ', ') AS "Categorias",
 COUNT(DISTINCT categoria) AS "Total_Categorias_Diferentes"
FROM indicados_ao_oscar
GROUP BY nome_indicado
HAVING COUNT(DISTINCT categoria) > 1
ORDER BY Total_Categorias_Diferentes DESC, nome_indicado ASC;

-- 5.5 Quantos indicados têm exatamente 1 indicação na história?
SELECT nome_indicado AS "Ator_Atriz"
FROM indicados_ao_oscar 
GROUP BY nome_indicado 
HAVING COUNT(nome_indicado) = 1;
    
SELECT COUNT(*) AS "Total_Indicados_Com_Uma_Indicacao"
FROM (
    SELECT nome_indicado
    FROM indicados_ao_oscar 
    GROUP BY nome_indicado 
    HAVING COUNT(nome_indicado) = 1
) AS subquery;

-- 5.6 Qual o maior números de indicados em um único ano? Essa é uma pergunta franca.
SELECT ano_cerimonia AS"Ano", COUNT(*) AS "total_indicacoes"
FROM indicados_ao_oscar 
GROUP BY ano_cerimonia 
ORDER BY total_indicacoes DESC 
LIMIT 1;

-- NÍVEL 6
-- 6.1 A série de filmes Toy Story ganhou Oscars em quais anos?
SELECT ano_cerimonia AS "Ano", COUNT(vencedor) AS "Vencedor"
FROM indicados_ao_oscar 
WHERE nome_filme LIKE "%Toy Story%" and vencedor = true
GROUP BY ano_cerimonia;

-- 6.2 Quantas indicações a franquia Toy Story recebeu no total?
SELECT COUNT(nome_filme) AS "Quantidade de Indicações"
FROM indicados_ao_oscar 
WHERE nome_filme LIKE "%Toy Story%";

-- 6.3 Em quais categorias os filmes Toy Story foram indicados?
SELECT DISTINCT categoria AS "Categorias" 
FROM indicados_ao_oscar 
WHERE nome_filme LIKE "%Toy Story%";

-- 6.4 Em qual edição do Oscar o filme "Crash" concorreu?
SELECT ano_cerimonia FROM indicados_ao_oscar
WHERE nome_filme = "Crash"
GROUP BY ano_cerimonia;

-- 6.5 Quantas indicações o filme "Crash" recebeu?
SELECT COUNT(vencedor) FROM indicados_ao_oscar
WHERE nome_filme = "Crash";

-- 6.6 "Crash" ganhou o Oscar de Melhor Filme?
SELECT nome_filme AS "Filme" FROM indicados_ao_oscar
WHERE nome_filme = 'Crash' 
AND vencedor = true 
AND categoria = 'OUTSTANDING PICTURE' OR categoria = 'BEST PICTURE'
GROUP BY nome_filme;

-- 6.7 O filme "Central do Brasil" aparece no banco de dados?
SELECT nome_filme AS "Filme", COUNT(nome_filme) FROM indicados_ao_oscar
WHERE nome_filme = 'Central do Brasil';

-- 6.8 Se sim, quantas indicações "Central do Brasil" recebeu?
SELECT nome_filme AS "Filme", COUNT(ano_cerimonia) FROM indicados_ao_oscar
WHERE nome_filme = 'Central do Brasil';













