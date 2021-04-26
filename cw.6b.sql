USE firma2;

-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski w nawiasie (+48)
SELECT * FROM ksiegowosc.pracownicy;

-- telefon jest zmienn¹ typu VARCHAR(12) - za ma³o znaków

ALTER TABLE ksiegowosc.pracownicy
ALTER COLUMN Telefon VARCHAR(18);

UPDATE ksiegowosc.pracownicy
SET Telefon = '(+48)' + Telefon;

-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg wzoru: ‘555-222-333’

UPDATE ksiegowosc.pracownicy
SET Telefon = SUBSTRING([Telefon],1,5) + ' ' + SUBSTRING([Telefon],6,3) + '-' + SUBSTRING([Telefon],9,3) + '-' + SUBSTRING([Telefon],12,3)

-- c) Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter

SELECT TOP 1 UPPER(Nazwisko), UPPER(Imie), UPPER(Adres), Telefon
	FROM ksiegowosc.pracownicy
	ORDER BY LEN(Nazwisko) DESC

-- d) Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5

SELECT HASHBYTES('MD5', Imie) AS Imie, HASHBYTES('MD5', Nazwisko) AS Nazwisko, HASHBYTES('MD5', Telefon) AS Telefon, 
		HASHBYTES('MD5', Adres) AS Adres, HASHBYTES('MD5', CAST(Kwota AS VARCHAR(5))) AS Pensja
	FROM ksiegowosc.pracownicy
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji

-- f) Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne.

SELECT Imie, Nazwisko, pensje.Kwota AS Pensja, premia.Kwota AS Premia
	FROM ksiegowosc.pracownicy
	LEFT OUTER JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	LEFT OUTER JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	LEFT OUTER JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii

-- g) wygeneruj raport (zapytanie), które zwróci w wyniku treœæ wg poni¿szego szablonu:
-- Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, gdzie wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 z³

SELECT CONCAT_WS(' ', 'Pracownik', Imie, Nazwisko, 'w dniu', wynagrodzenie.Data, 'otrzyma³ pensjê ca³kowit¹ na kwotê', (pensje.Kwota + ISNULL(premia.Kwota, 0) + (Liczba_godzin-160)*60), 
'z³, gdzie wynagrodzenie zasadnicze wynosi³o:', pensje.Kwota, 'z³, premia:', ISNULL(premia.Kwota, 0), 'z³, nadgodziny:', ((Liczba_godzin-160)*50), 'z³.') AS Podsumowanie
	FROM ksiegowosc.pracownicy
	JOIN ksiegowosc.wynagrodzenie ON pracownicy.ID_pracownika = wynagrodzenie.ID_pracownika
	JOIN ksiegowosc.pensje ON wynagrodzenie.ID_pensji = pensje.ID_pensji
	JOIN ksiegowosc.premia ON wynagrodzenie.ID_premii = premia.ID_premii
	JOIN ksiegowosc.godziny ON wynagrodzenie.ID_godziny = godziny.ID_godziny