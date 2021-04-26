
-- 1. Dla tabeli zamowienia(id_produktu, nazwa_produktu, id_klienta, nazwa_klienta, data_zamowienia, cena_produktu, iloœæ, VAT, suma_brutto, suma_netto) okreœl wszystkie zale¿noœci funkcyjne.
-- Przyjmij nastêpuj¹ce za³o¿enia:

-- VAT ró¿ni siê w zale¿noœci od typu produktu (na przyk³ad ksi¹¿ki 5%, pieczywo 8% itd.).
-- Suma brutto to suma netto powiêkszona o VAT.
-- Zamówienia klientów w tym samym dniu s¹ ³¹czone. Mamy tylko jedno zamówienie dla danego klienta dziennie (zamówienie danego produktu!).
-- Nazwy produktów i nazwy klientów s¹ unikalne.
-- Wypisz zale¿noœci funkcyjne wed³ug wzoru:
--			Id_produktu -> nazwa_produktu, cena_produktu, VAT


ID_produktu -> nazwa_produktu, cena_produktu, VAT
ID_klienta -> nazwa_klienta
ID_klienta, ID_produktu -> data_zamowienia, iloœæ, suma brutto, suma_netto
suma_brutto -> suma_netto, VAT


-- 2. Wypisz wszystkie klucze kandyduj¹ce.
ID_produktu, ID_klienta, 

-- 3. Dla tabeli pomieszczenia(id_pomieszczenia, numer_pomieszczenia, id_budynku, powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy) okreœl wszystkie zale¿noœci funkcyjne oraz klucze kandyduj¹ce.
-- Przyjmij nastêpuj¹ce za³o¿enia:
-- id_pomieszczenia to autoinkrementowany, unikalny identyfikator pomieszczenia w tabeli.

id_pomieszczenia -> numer_pomieszczenia, powierzchnia, liczba_okien, liczba_drzwi
id_budynku -> ulica, miasto, id_pomieszczenia
miasto -> kod_pocztowy

klucze kandyduj¹ce: id_pomieszczenia, id_budynku, miasto