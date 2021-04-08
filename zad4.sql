--1. Stworzenie bazy danych
--CREATE DATABASE firma;
USE firma;

--2. Schemat
--CREATE SCHEMA rozliczenia

--3. Tabele
CREATE TABLE rozliczenia.pracownicy 
(
ID_pracownika INT PRIMARY KEY, 
Imie VARCHAR(20) NOT NULL, 
Nazwisko VARCHAR(30) NOT NULL, 
Adres VARCHAR(50), 
Telefon VARCHAR(12)
)
CREATE TABLE rozliczenia.godziny 
(
ID_godziny INT PRIMARY KEY,
Data DATE,
Liczba_godzin INT,
ID_pracownika INT NOT NULL,
FOREIGN KEY (ID_pracownika) REFERENCES rozliczenia.pracownicy(ID_pracownika)
)
CREATE TABLE rozliczenia.premie 
(
ID_premii INT PRIMARY KEY,
rodzaj VARCHAR(20),
kwota FLOAT(2)
)
CREATE TABLE rozliczenia.pensje 
(
ID_pensji INT PRIMARY KEY,
stanowisko VARCHAR(20),
kwota FLOAT(2),
ID_premii INT NOT NULL,
FOREIGN KEY (ID_premii) REFERENCES rozliczenia.premie(ID_premii)
);

-- 4. Dodawanie rekordów do tablic

INSERT INTO rozliczenia.pracownicy (ID_pracownika, Imie, Nazwisko, adres, telefon)
VALUES (1, 'Anna', 'Walc', 'ul. Topolowa 10, Kraków', '723882982'),
(2, 'Krzysztof', 'Kot', 'ul. Makowa 3a, Kostrzyn', '823221123'),
(3, 'Konrad', 'Wir', 'ul. Kokosowa 22, Katowice', '923234432'),
(4, 'Sylwia', 'Pond', 'ul. Piêkna 12, Kraków', '234234234'),
(5, 'Irena', 'Kotlin', 'ul. Radosna 19, Kraków', '123123123'),
(6, 'Wojciech', 'Irys', 'ul. Pokojowa 88, Katowice', '992332091'),
(7, 'Rados³aw', 'Wik', 'ul. Spokojna 20a, Bêdkowice', '882321299'),
(8, 'Aleksandra', 'Klimczak', 'ul. Sosnowa 17, Kobylany', '987987123'),
(9, 'Monika', 'Straszewska', 'ul. Lipowa 30, Kraków', '882883843'),
(10, 'Igor', 'Jasik', 'ul. Szeroka 2, Lipno', '923432112');

INSERT INTO rozliczenia.godziny (ID_godziny, Data, Liczba_godzin, ID_pracownika)
VALUES (1, '10.12.2020', 8, 1),
(2, '10.12.2020', 8, 2),
(3, '10.12.2020', 6, 3),
(4, '10.12.2020', 6, 4),
(5, '10.12.2020', 6, 5),
(6, '10.13.2020', 6, 2),
(7, '10.13.2020', 7, 3),
(8, '10.13.2020', 8, 8),
(9, '10.14.2020', 6, 10),
(10, '10.14.2020', 2, 2);

INSERT INTO rozliczenia.premie (ID_premii, rodzaj, kwota)
VALUES (1, 'uznaniowa', 100.00),
(2, 'regulminowa', 100.00),
(3, 'uznaniowa', 150.00),
(4, 'regulminowa', 150.00),
(5, 'uznaniowa', 200.00),
(6, 'regulminowa', 200.00),
(7, 'uznaniowa', 250.00),
(8, 'regulminowa', 250.00),
(9, 'uznaniowa', 300.00),
(10, 'regulminowa', 300.00);

INSERT INTO rozliczenia.pensje (ID_pensji, stanowisko, kwota, ID_premii)
VALUES (1, 'dyrektor', 5000, 10),
(2, 'kierownik projektu', 4500, 8),
(3, 'asystent', 3000, 1),
(4, 'administrator UNIX', 3500, 5),
(5, 'g³ówny analityk', 4300, 8),
(6, 'sta¿ysta', 2500, 1),
(7, 'administrator sieci', 4500, 3),
(8, 'architekt systemu', 4300, 8);

-- 5. Wyœwietlenie nazwisk pracowników i ich adresów

SELECT [Nazwisko]
      ,[Adres]
  FROM [firma].[rozliczenia].[pracownicy];

-- 6. Zamiana daty w tabeli godziny tak, aby wyœwietlana by³a inf jaki dzieñ tyg i miesi¹c

SELECT DATEPART(DW, Data) AS dzieñ_tygodnia, DATEPART(MONTH, Data) AS miesi¹c
FROM rozliczenia.godziny;

-- 7. Kwota: kwota brutto; dodanie kwoty netto:

SELECT * FROM rozliczenia.pensje;
exec sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'Column';

ALTER TABLE rozliczenia.pensje ADD kwota_netto FLOAT(2);

update rozliczenia.pensje
Set kwota_netto = kwota_brutto*0.81;