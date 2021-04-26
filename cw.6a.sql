
-- 1. Dla tabeli zamowienia(id_produktu, nazwa_produktu, id_klienta, nazwa_klienta, data_zamowienia, cena_produktu, ilo��, VAT, suma_brutto, suma_netto) okre�l wszystkie zale�no�ci funkcyjne.
-- Przyjmij nast�puj�ce za�o�enia:

-- VAT r�ni si� w zale�no�ci od typu produktu (na przyk�ad ksi��ki 5%, pieczywo 8% itd.).
-- Suma brutto to suma netto powi�kszona o VAT.
-- Zam�wienia klient�w w tym samym dniu s� ��czone. Mamy tylko jedno zam�wienie dla danego klienta dziennie (zam�wienie danego produktu!).
-- Nazwy produkt�w i nazwy klient�w s� unikalne.
-- Wypisz zale�no�ci funkcyjne wed�ug wzoru:
--			Id_produktu -> nazwa_produktu, cena_produktu, VAT


ID_produktu -> nazwa_produktu, cena_produktu, VAT
ID_klienta -> nazwa_klienta
ID_klienta, ID_produktu -> data_zamowienia, ilo��, suma brutto, suma_netto
suma_brutto -> suma_netto, VAT


-- 2. Wypisz wszystkie klucze kandyduj�ce.
ID_produktu, ID_klienta, 

-- 3. Dla tabeli pomieszczenia(id_pomieszczenia, numer_pomieszczenia, id_budynku, powierzchnia, liczba_okien, liczba_drzwi, ulica, miasto, kod_pocztowy) okre�l wszystkie zale�no�ci funkcyjne oraz klucze kandyduj�ce.
-- Przyjmij nast�puj�ce za�o�enia:
-- id_pomieszczenia to autoinkrementowany, unikalny identyfikator pomieszczenia w tabeli.

id_pomieszczenia -> numer_pomieszczenia, powierzchnia, liczba_okien, liczba_drzwi
id_budynku -> ulica, miasto, id_pomieszczenia
miasto -> kod_pocztowy

klucze kandyduj�ce: id_pomieszczenia, id_budynku, miasto