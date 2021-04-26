USE firma2;

-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48)
SELECT * FROM ksiegowosc.pracownicy;

-- telefon jest zmienn� typu VARCHAR(12) - za ma�o znak�w

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN Telefon VARCHAR(18);

UPDATE ksiegowosc.pracownicy
SET Telefon = '(+48)' + Telefon;

-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333�

UPDATE ksiegowosc.pracownicy
SET Telefon = SUBSTRING([Telefon],1,5) + ' ' + SUBSTRING([Telefon],6,3) + '-' + SUBSTRING([Telefon],9,3) + '-' + SUBSTRING([Telefon],12,3)

-- c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter

SELECT TOP 1 UPPER(Nazwisko), UPPER(Imie), UPPER(Adres), Telefon
	FROM ksiegowosc.pracownicy
	ORDER BY LEN(Nazwisko) DESC

-- d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5

SELECT HASHBYTES('MD5', Imie) AS Imie, HASHBYTES('MD5', Nazwisko) AS Nazwisko, HASHBYTES('MD5', Telefon) AS Telefon, 
		HASHBYTES('MD5', Adres) AS Adres, HASHBYTES('MD5', CAST(Kwota AS VARCHAR(5))) AS Pensja
	FROM ksiegowosc.pracownicy
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji

-- f) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.

SELECT Imie, Nazwisko, pensje.Kwota AS Pensja, premia.Kwota AS Premia
	FROM ksiegowosc.pracownicy
	LEFT OUTER JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	LEFT OUTER JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	LEFT OUTER JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii

-- g) wygeneruj raport (zapytanie), kt�re zwr�ci w wyniku tre�� wg poni�szego szablonu:
-- Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma� pensj� ca�kowit� na kwot� 7540 z�, gdzie wynagrodzenie zasadnicze wynosi�o: 5000 z�, premia: 2000 z�, nadgodziny: 540 z�

SELECT CONCAT_WS(' ', 'Pracownik', Imie, Nazwisko, 'w dniu', wynagrodzenie.Data, 'otrzyma� pensj� ca�kowit� na kwot�', (pensje.Kwota + ISNULL(premia.Kwota, 0) + (Liczba_godzin-160)*60), 
'z�, gdzie wynagrodzenie zasadnicze wynosi�o:', pensje.Kwota, 'z�, premia:', ISNULL(premia.Kwota, 0), 'z�, nadgodziny:', ((Liczba_godzin-160)*50), 'z�.') AS Podsumowanie
	FROM ksiegowosc.pracownicy
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii
	JOIN ksiegowosc.godziny ON wynagrodzenie.ID_godziny = godziny.ID_godziny