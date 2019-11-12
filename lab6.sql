-- 6.1 (baza danych: cukiernia)
-- 6.1.1 Napisz i wykonaj zapytanie (użyj INSERT), które dodaje do tabeli czekoladki następujące informacje:
-- idczekoladki: W98, nazwa: Biały kieł, czekolada: biała, orzechy: laskowe, nadzienie: marcepan, opis: Rozpływające się w rękach i kieszeniach, koszt: 45 gr, masa: 20 g.
INSERT INTO public.czekoladki (idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa)
VALUES ('W98', 'Biały kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', 0.45, 20);
-- 6.1.2 Napisz i wykonaj trzy zapytania (użyj INSERT), które dodadzą do tabeli klienci następujące dane osobowe:
-- idklienta: 90, nazwa: Matusiak Edward,  ulica: Kropiwnickiego 6/3, miejscowosc: Leningrad, kod: 31-471, telefon: 031 423 45 38,
-- idklienta: 91, nazwa: Matusiak Alina, ulica: Kropiwnickiego 6/3, miejscowosc: Leningrad, kod: 31-471, telefon: 031 423 45 38,
-- idklienta: 92, nazwa: Kimono Franek, ulica: Karateków 8, miejscowosc: Mistrz, kod: 30-029, telefon: 501 498 324.
INSERT INTO public.klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon)
VALUES (90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38')
(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');
-- Dodaj do tabeli klienci dane Izy Matusiak (idklienta 93). Pozostałe dane osobowe Izy Matusiak muszą być takie same jak dla Pana Edwarda Matusiaka. Użyj podzapytań.
INSERT INTO public.klienci (idklienta, nazwa, ulica, miejscowosc, kod, telefon)
VALUES (
    93, 
    'Matusiak Iza', 
    (SELECT ulica FROM public.klienci WHERE idklienta=90),
    (SELECT miejscowosc FROM public.klienci WHERE idklienta=90),
    (SELECT kod FROM public.klienci WHERE idklienta=90),
    (SELECT telefon FROM public.klienci WHERE idklienta=90)
);

-- 6.2 (baza danych: cukiernia) Napisz i wykonaj zapytanie, które doda do tabeli czekoladki następujące pozycje, wykorzystaj wartości NULL w poleceniu INSERT:
-- IDCzekoladki: X91, Nazwa: Nieznana Nieznajoma, Opis: Niewidzialna czekoladka wspomagajaca odchudzanie., Koszt: 26 gr, Masa: 0g,
-- IDCzekoladki: M98, Nazwa: Mleczny Raj, Czekolada: Mleczna, Opis: Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem., Koszt: 26 gr, Masa: 36 g,
INSERT INTO public.czekoladki (idczekoladki,nazwa,czekolada,opis,koszt,masa)
VALUES ('X91', 'Nieznana Nieznajoma',NULL, 'Niewidzialna czekoladka wspomagajaca odchudzanie.',0.26,0),
('M98', 'Mleczny Raj','mleczna', 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.',0.26,36);

-- 6.3 (baza danych: cukiernia) Napisz zapytanie, które usunie informacje dodane w Zadaniu 6.2, użyj DELETE.
DELETE FROM czekoladki WHERE idczekoladki IN ('X91', 'M98');

-- 6.4 (baza danych: cukiernia) Napisz instrukcje aktualizujące dane w bazie cukiernia.
-- 6.4.1 Zmiana nazwiska Izy Matusiak na Nowak.
UPDATE public.klienci SET nazwa = 'Nowak Iza'
WHERE nazwa = 'Matusiak Iza';
-- 6.4.2 Obniżenie kosztu czekoladek o identyfikatorach (idczekoladki): W98, M98 i X91, o 10%.
UPDATE czekoladki SET koszt = koszt * 0.9 WHERE idczekoladki IN ('W98', 'M98', 'X91');
-- 6.4.3 Ustalenie kosztu czekoladek o nazwie Nieznana Nieznajoma na taką samą jak cena czekoladki o identyfikatorze W98.
UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98') 
WHERE nazwa ='Nieznana Nieznajoma';
-- 6.4.4 Zmiana nazwy z Leningrad na Piotrograd w tabeli klienci.
UPDATE klienci SET miejscowosc = 'Piotrograd'
WHERE miejscowosc = 'Leningrad';
-- 6.4.5 Podniesienie kosztu czekoladek, których dwa ostatnie znaki identyfikatora (idczekoladki) są większe od 90, o 15 groszy.
UPDATE czekoladki SET koszt = koszt + 0.15
WHERE SUBSTR(idczekoladki,2,2)::int > 90;

-- 6.5 (baza danych: cukiernia) Napisz instrukcje usuwające z bazy danych informacje o:
-- 6.5.1 klientach o nazwisku Matusiak
DELETE FROM klienci WHERE nazwa LIKE 'Matusiak%';
-- 6.5.2 klientach o identyfikatorze większym niż 91
DELETE FROM klienci WHERE idklienta > 91;
-- 6.5.3 czekoladkach, których koszt jest większy lub równy 0.45 lub masa jest większa lub równa 36, lub masa jest równa 0
DELETE FROM czekoladki WHERE koszt >= 0.45 OR masa >= 36 OR masa = 0;

