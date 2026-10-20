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
SELECT categoria FROM indicados_ao_oscar
WHERE categoria LIKE "DIRECTING%"
ORDER BY ;
-- R 2.6:

