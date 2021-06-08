CREATE DATABASE strato;
USE strato;


CREATE TABLE GeoEon 
(
id_eon INT PRIMARY KEY, 
nazwa_eou VARCHAR(20)
)
CREATE TABLE GeoEra 
(
id_era INT PRIMARY KEY, 
id_eon INT,
nazwa_era VARCHAR(20)
)
CREATE TABLE GeoOkres 
(
id_okres INT PRIMARY KEY, 
id_era INT,
nazwa_okres VARCHAR(20)
)
CREATE TABLE GeoEpoka 
(
id_epoka INT PRIMARY KEY, 
id_okres INT,
nazwa_epoka VARCHAR(20)
)
CREATE TABLE GeoPietro 
(
id_pietro INT PRIMARY KEY, 
id_epoka INT,
nazwa_pietro VARCHAR(20)
)
INSERT INTO GeoEon
VALUES (1, 'Fanerozoik')

SELECT * FROM GeoEpoka

INSERT INTO GeoEra
VALUES (1, 1, 'Kenzoik'), (2, 1, 'Mezozoik'), (3, 1, 'Paleozoik')

INSERT INTO GeoOkres
VALUES (1, 1, 'Czwartorz¹d'), (2, 1, 'Neogen'), (3, 1, 'Paleogen'),
(4, 2, 'Kreda'), (5, 2, 'Jura'), (6, 2, 'Trias'), (7, 3, 'Perm'), (8, 3, 'Karbon'),
(9, 3, 'Dewon')

INSERT INTO GeoEpoka
VALUES (1, 1, 'Halocen'), (2, 1, 'Plejstocen'), (3, 2, 'Pliocen'), (4,2, 'Miocen'),
(5, 3, 'Oligocen'), (6, 3, 'Eocen'), (7, 3, 'Paleocen'), (8, 4, 'Górna'), (9,4,'Dolna'),
(10,5, 'Górna'), (11,5,'Œrodkowa'), (12,5,'Dolna'), (13, 6, 'Górny'), (14, 6, 'Œrodkowy'),
(15, 6, 'Dolny'), (16, 7, 'Górny'), (17, 7, 'Dolny'), (18, 8, 'Górny'), (19,8,'Dolny'),
(20,9,'Górny'), (21,9,'Œrodkowy'), (22, 9, 'Dolny')

INSERT INTO GeoPietro
VALUES (1, 1, 'megalaj'), (2,1,'northgrip'), (3, 1, 'grenland'), (4, 2, 'póŸny'),
(5, 2, 'chiban'), (6,2,'kalabr'), (7, 2, 'gelas'), (8, 3, 'piacent'), (9,3,'zankl'),
(10, 4, 'messyn'),(11,4,'torton'),(12,4,'serrawal'),(13,4,'lang'),(14,4,'burdyga³'),
(15,4,'akwitan'), (16,5,'szat'), (17,5,'rupel'),(18,6,'priabon'),(19,6,'barton'),
(20,6,'lutet'), (21,6,'iprez'), (22,7,'tanet'),(23,7,'zeland'),(24,7,'dan'),(25,8,'mastrycht'),
(26,8,'kampan'),(27,8,'santon'),(28,8,'koniak'),(29,8,'turon'),(30,8,'cenoman')

SELECT id_pietro, nazwa_pietro, GeoPietro.id_epoka, nazwa_epoka, GeoOkres.id_okres, nazwa_okres, GeoEra.id_era, nazwa_era, GeoEon.id_eon, nazwa_eou
INTO GeoTabela2
FROM GeoPietro 
INNER JOIN GeoEpoka ON  GeoPietro.id_epoka=GeoEpoka.id_epoka
INNER JOIN GeoOkres ON  GeoEpoka.id_okres=GeoOkres.id_okres
INNER JOIN GeoEra ON  GeoOkres.id_era=GeoEra.id_era
INNER JOIN GeoEon ON  GeoEra.id_eon=GeoEon.id_eon

SELECT * FROM GeoTabela2;

CREATE TABLE Milion(liczba int,cyfra int, bit int);
CREATE TABLE Dziesiec(cyfra int, bit int);

INSERT INTO Dziesiec
VALUES (0,0), (1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9);


INSERT INTO  Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit 
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;

SELECT * FROM Milion ORDER BY liczba

SELECT COUNT(*) 
FROM Milion 
INNER JOIN GeoTabela2 ON ((Milion.liczba % 30)=(GeoTabela2.id_pietro));

SELECT COUNT(*) 
FROM Milion 
INNER JOIN  GeoPietro  ON ((Milion.liczba % 68)=GeoPietro.id_pietro) 
INNER JOIN GeoEpoka ON  GeoPietro.id_epoka=GeoEpoka.id_epoka
INNER JOIN GeoOkres ON  GeoEpoka.id_okres=GeoOkres.id_okres
INNER JOIN GeoEra ON  GeoOkres.id_era=GeoEra.id_era
INNER JOIN GeoEon ON  GeoEra.id_eon=GeoEon.id_eon

SELECT COUNT(*) 
FROM Milion 
WHERE (Milion.liczba % 68)= (SELECT id_pietro 
							FROM GeoTabela2   
							WHERE (Milion.liczba % 68)=(id_pietro));

SELECT COUNT(*) 
FROM Milion 
WHERE (Milion.liczba % 68)=(SELECT GeoPietro.id_pietro 
							FROM GeoPietro 
							INNER JOIN GeoEpoka ON  GeoPietro.id_epoka=GeoEpoka.id_epoka
							INNER JOIN GeoOkres ON  GeoEpoka.id_okres=GeoOkres.id_okres
							INNER JOIN GeoEra ON  GeoOkres.id_era=GeoEra.id_era
							INNER JOIN GeoEon ON  GeoEra.id_eon=GeoEon.id_eon)