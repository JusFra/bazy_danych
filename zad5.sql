--1. Stworzenie bazy danych
CREATE DATABASE firma2;
USE firma2;

--2. Schemat
CREATE SCHEMA ksiegowosc

--3. Tabele
-- Tabela pracownicy zawiera: id_pracownika, imi�, nazwisko, adres i telefon
CREATE TABLE ksiegowosc.pracownicy 
(
ID_pracownika	NUMERIC(4)		CONSTRAINT pk_pr PRIMARY KEY	IDENTITY(1,1), 
Imie			VARCHAR(20)		NOT NULL, 
Nazwisko		VARCHAR(30)		NOT NULL, 
Adres			VARCHAR(50), 
Telefon			VARCHAR(12)		CHECK(LEN(telefon)>=9)
)
-- Tabela godziny zawiera: id_godziny, dat�, liczb�_godzin i id_pracownika
CREATE TABLE ksiegowosc.godziny 
(
ID_godziny		NUMERIC(4)		CONSTRAINT pk_g PRIMARY KEY		IDENTITY(1,1),
Data			DATE,
Liczba_godzin	NUMERIC(8),
ID_pracownika	NUMERIC(4)		NOT NULL,
FOREIGN KEY		(ID_pracownika)	REFERENCES ksiegowosc.pracownicy(ID_pracownika)
)
-- Tabela pensje zawiera: id_pensji, stanowisko i kwot�
CREATE TABLE ksiegowosc.pensje 
(
ID_pensji		NUMERIC(4)		CONSTRAINT pk_pe PRIMARY KEY	IDENTITY(1,1),
Stanowisko		VARCHAR(20),
Kwota			FLOAT(8),
)
-- Tabela premia zawiera: id_premii, rodzaj i kwot�
CREATE TABLE ksiegowosc.premia
(
ID_premii		NUMERIC(4)		CONSTRAINT pk_pre PRIMARY KEY	IDENTITY(1,1),
Rodzaj			VARCHAR(20),
Kwota			FLOAT(2)
)
-- Tabela wynagrodzenia zawiera: id_wynagrodzenia, dat�, id_pracownika, id_godziny, id_pensji i id_premii
CREATE TABLE ksiegowosc.wynagrodzenie
(
ID_wynagrodzenia NUMERIC(4)		CONSTRAINT pk_wy PRIMARY KEY	IDENTITY(1,1),
Data			 DATE,
ID_pracownika	 NUMERIC(4)		NOT NULL,
FOREIGN KEY (ID_pracownika)		REFERENCES ksiegowosc.pracownicy(ID_pracownika),
ID_godziny		 NUMERIC(4)		NOT NULL,
FOREIGN KEY (ID_godziny)		REFERENCES ksiegowosc.godziny(ID_godziny),
ID_pensji		 NUMERIC(4)		NOT NULL,
FOREIGN KEY (ID_pensji)			REFERENCES ksiegowosc.pensje(ID_pensji),
ID_premii		 NUMERIC(4)		NOT NULL,
FOREIGN KEY (ID_premii)			REFERENCES ksiegowosc.premia(ID_premii)
);

-- 4. Dodawanie rekord�w do tablic

INSERT INTO ksiegowosc.pracownicy (Imie, Nazwisko, Adres, Telefon)
VALUES ('Anna', 'Walc', 'ul. Topolowa 10, Krak�w', '723882982'),
('Krzysztof', 'Kot', 'ul. Makowa 3a, Kostrzyn', '823221123'),
('Konrad', 'Wir', 'ul. Kokosowa 22, Katowice', '923234432'),
('Sylwia', 'Pond', 'ul. Pi�kna 12, Krak�w', '234234234'),
('Irena', 'Kotlin', 'ul. Radosna 19, Krak�w', '123123123'),
('Wojciech', 'Irys', 'ul. Pokojowa 88, Katowice', '992332091'),
('Rados�aw', 'Wik', 'ul. Spokojna 20a, B�dkowice', '882321299'),
('Aleksandra', 'Klimczak', 'ul. Sosnowa 17, Kobylany', '987987123'),
('Julia', 'Straszewska', 'ul. Lipowa 30, Krak�w', '882883843'),
('Igor', 'Jasik', 'ul. Szeroka 2, Lipno', '923432112');

INSERT INTO ksiegowosc.godziny (Data, Liczba_godzin, ID_pracownika)
VALUES ('10.31.2020', 150, 1),
('12.31.2020', 160, 2),
('12.31.2020', 170, 3),
('12.31.2020', 160 , 4),
('12.31.2020', 150, 5),
('12.31.2020', 165, 6),
('12.31.2020', 160, 7),
('12.31.2020', 170, 8),
('12.31.2020', 160, 9),
('12.31.2020', 170, 10);

INSERT INTO ksiegowosc.premia (rodzaj, kwota)
VALUES ('brak', NULL),
('jedynka', 50.00),
('jedynka+', 100.00),
('dw�jka', 150.00),
('tr�jka', 200.00),
('czw�rka', 250.00),
('pi�tka', 300.00),
('pi�tka+', 350.00),
('pi�tka++', 400.00),
('sz�stka', 450.00);

INSERT INTO ksiegowosc.pensje (stanowisko, kwota)
VALUES ('dyrektor', 5000),
('kierownik projektu', 4500),
('asystent', 3000),
('administrator UNIX', 3500),
('g��wny analityk', 4300),
('sta�ysta', 2500),
('administrator sieci', 4500),
('architekt systemu', 4300),
('administrator UNIX', 32000),
('kierownik projektu', 3200);

INSERT INTO ksiegowosc.wynagrodzenie (Data, ID_pracownika, ID_godziny, ID_pensji, ID_premii)
VALUES ('01.01.2021', 1, 1, 1, 10),
('01.01.2021', 2, 2, 2, 4),
('01.01.2021', 3, 3, 3, 2),
('01.01.2021', 4, 4, 4, 2),
('01.01.2021', 5, 6, 6, 1),
('01.01.2021', 6, 5, 7, 1),
('01.01.2021', 7, 7, 5, 8),
('01.01.2021', 8, 8, 8, 1),
('01.01.2021', 9, 9, 3, 2),
('01.01.2021', 10, 10, 10, 2);

-- 5A. Wy�wietl tylko id pracownika oraz jego nazwisko.
SELECT ID_pracownika, Nazwisko
  FROM ksiegowosc.pracownicy;

-- 5B. Wy�wietl id pracownik�w, kt�rych p�aca jest wi�ksza ni� 1000.
SELECT pracownicy.ID_pracownika
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii
	WHERE pensje.Kwota + ISNULL(premia.Kwota, 0) > 1000

-- 5C. Wy�wietl id pracownik�w nieposiadaj�cych premii,kt�rych p�aca jest wi�ksza ni� 2000.
SELECT pracownicy.ID_pracownika
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii
	WHERE ISNULL(premia.Kwota, 0) = 0 AND pensje.Kwota > 2000

-- 5D. Wy�wietl pracownik�w, kt�rych pierwsza litera imienia zaczyna si� na liter� �J�. 
SELECT *
	FROM ksiegowosc.pracownicy 
	WHERE Imie LIKE 'J%'

-- 5E. Wy�wietl pracownik�w, kt�rych nazwisko zawiera liter� �n� oraz imi� ko�czy si� na liter� �a�.
SELECT *
	FROM ksiegowosc.pracownicy 
	WHERE Imie LIKE '%a' AND Imie LIKE '%n%'

-- 5F. Wy�wietl imi� i nazwisko pracownik�w oraz liczb� ich nadgodzin, przyjmuj�c, i� standardowy czas pracy to 160 h miesi�cznie. 
SELECT Imie, Nazwisko, Liczba_godzin - 160 AS "Nadgodziny"
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.godziny ON wynagrodzenie.ID_godziny = godziny.ID_godziny

-- 5G. Wy�wietl imi� i nazwisko pracownik�w, kt�rych pensja zawiera si� w przedziale 1500 �3000PLN.
SELECT Imie, Nazwisko
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	WHERE pensje.Kwota >= 1500 AND pensje.Kwota <= 3000

-- 5H. Wy�wietl imi� i nazwisko pracownik�w, kt�rzy pracowali w nadgodzinachi nie otrzymali premii.
SELECT Imie, Nazwisko
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.godziny ON wynagrodzenie.ID_godziny = godziny.ID_godziny
	JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii
	WHERE ISNULL(premia.Kwota, 0) = 0 AND godziny.Liczba_godzin > 160

-- 5I. Uszereguj pracownik�w wed�ug pensji.
SELECT Imie, Nazwisko, Kwota
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	ORDER BY Kwota

-- 5J. Uszereguj pracownik�w wed�ug pensji i premii malej�co.
SELECT Imie, Nazwisko, pensje.Kwota + ISNULL(premia.Kwota, 0) AS 'p�aca'
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii
	ORDER BY pensje.Kwota + ISNULL(premia.Kwota, 0) DESC

-- 5K. Zlicz i pogrupuj pracownik�w wed�ug pola �stanowisko�.
SELECT Stanowisko, COUNT(*) AS 'Liczba pracownik�w'
	FROM ksiegowosc.pracownicy 
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	GROUP BY Stanowisko

-- 5L. Policz �redni�, minimaln� i maksymaln� p�ac� dla stanowiska �kierownik� (je�eli takiego nie masz, to przyjmij dowolne inne).
SELECT AVG(pensje.Kwota) AS '�rednie wynagrodzenie', MIN(pensje.Kwota) AS 'Minimalne', MAX(pensje.Kwota) AS 'Maksymalne'
	FROM ksiegowosc.pensje
	JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji
	JOIN ksiegowosc.premia ON premia.ID_premii = wynagrodzenie.ID_premii
	WHERE Stanowisko LIKE '%kierownik%'
	GROUP BY Stanowisko

-- 5M. Policz sum� wszystkich wynagrodze�.
SELECT SUM(pensje.Kwota) AS 'Pensja', SUM(premia.Kwota) AS 'Premia', SUM(pensje.Kwota) + SUM(premia.Kwota) AS 'Razem'
	FROM ksiegowosc.pensje
	JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji
	JOIN ksiegowosc.premia ON premia.ID_premii = wynagrodzenie.ID_premii

-- 5N. Policz sum� wynagrodze� w ramach danego stanowiska.
SELECT Stanowisko, SUM(pensje.Kwota) + SUM(ISNULL(premia.Kwota, 0)) AS 'Wynagrodzenie'
	FROM ksiegowosc.pensje
	JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji
	JOIN ksiegowosc.premia ON premia.ID_premii = wynagrodzenie.ID_premii
	GROUP BY Stanowisko

-- 5O. Wyznacz liczb� premii przyznanych dla pracownik�w danego stanowiska.
SELECT Stanowisko, COUNT(*) AS 'Liczba premii'
	FROM ksiegowosc.pensje
	JOIN ksiegowosc.wynagrodzenie ON pensje.ID_pensji = wynagrodzenie.ID_pensji
	JOIN ksiegowosc.premia ON premia.ID_premii = wynagrodzenie.ID_premii
	WHERE ISNULL(premia.Kwota, 0) != 0
	GROUP BY Stanowisko

-- 5P. Usu� wszystkich pracownik�w maj�cych pensj� mniejsz� ni� 1200 z�.

DELETE ksiegowosc.pracownicy
	FROM ksiegowosc.pracownicy
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji	
	WHERE pensje.Kwota < 1200
