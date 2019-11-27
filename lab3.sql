-- 3.1 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat zamówień (idZamowienia, dataRealizacji),
-- które mają być zrealizowane:
-- 3.1.1 między 12 i 20 listopada 2013,
SELECT idzamowienia, datarealizacji FROM public.zamowienia WHERE datarealizacji 
BETWEEN date '2013-11-12' AND date '2013-11-20';
-- 3.1.2 między 1 i 6 grudnia lub między 15 i 20 grudnia 2013
SELECT idzamowienia, datarealizacji FROM public.zamowienia 
WHERE datarealizacji BETWEEN date '2013-12-01' AND date '2013-12-06' 
OR datarealizacji BETWEEN date '2013-12-15' AND date '2013-12-20';
-- 3.1.3 w grudniu 2013 (nie używaj funkcji date_part ani extract),
SELECT idzamowienia, datarealizacji FROM public.zamowienia 
WHERE datarealizacji BETWEEN date '2013-12-01' AND date '2013-12-31';
-- 3.1.4 w listopadzie 2013 (w tym i kolejnych zapytaniach użyj funkcji date_part lub extract),
SELECT idzamowienia, datarealizacji FROM public.zamowienia
WHERE EXTRACT(year FROM datarealizacji) = 2013 
AND EXTRACT(month FROM datarealizacji) = 11;
-- 3.1.5 w listopadzie lub grudniu 2013,
SELECT idzamowienia, datarealizacji FROM public.zamowienia
WHERE EXTRACT(year FROM datarealizacji) = 2013
AND EXTRACT(month FROM datarealizacji) BETWEEN 11 AND 12;
-- 3.1.6 17, 18 lub 19 dnia miesiąca,
SELECT idzamowienia, datarealizacji FROM public.zamowienia
WHERE EXTRACT(day FROM datarealizacji) BETWEEN 17 AND 19;
-- 3.1.7 46 lub 47 tygodniu roku.
SELECT idzamowienia, datarealizacji FROM public.zamowienia
WHERE EXTRACT(week FROM datarealizacji) IN (46, 47);

-- 3.2 (baza danych: cukiernia)Napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek 
-- (idCzekoladki, nazwa, czekolada, orzechy, nadzienie), których nazwa:
-- 3.2.1 rozpoczyna się na literę 'S',
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE nazwa LIKE 'S%';
-- 3.2.2 rozpoczyna się na literę 'S' i kończy się na literę 'i',
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE nazwa LIKE 'S%i';
-- 3.2.3 rozpoczyna się na literę 'S' i zawiera słowo rozpoczynające się na literę 'm',
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE nazwa LIKE 'S_% m%';
-- 3.2.4 rozpoczyna się na literę 'A', 'B' lub 'C',
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE SUBSTR(nazwa, 1, 1) IN ('A', 'B', 'C');
-- 3.2.5 zawiera rdzeń 'orzech' (może on wystąpić na początku i wówczas będzie pisany z wielkiej litery),
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE nazwa ILIKE '%orzech%';
-- 3.2.6 rozpoczyna się na literę 'S' i zawiera w środku literę 'm',
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE nazwa LIKE 'S%m%_';
-- 3.2.7 zawiera słowo 'maliny' lub 'truskawki',
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE nazwa ILIKE '%maliny%' OR nazwa ILIKE '%truskawki%';
-- OR
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE nazwa SIMILAR TO '%((maliny)|(truskawki))%';
-- 3.2.8 nie rozpoczyna się żadną z liter: 'D'-'K', 'S' i 'T',
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE SUBSTR(nazwa, 1, 1) NOT IN ('D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'S', 'T');
-- OR
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE nazwa NOT SIMILAR TO '(D|E|F|G|H|I|J|K|S|T)%';
-- 3.2.9 rozpoczyna się od 'Slod' ('Słod'),
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE nazwa LIKE 'Slod%' OR nazwa LIKE 'Słod%';
-- 3.2.10 składa się dokładnie z jednego słowa.
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie 
FROM public.czekoladki WHERE POSITION(' ' IN nazwa) = 0;

-- 3.3 (baza danych: cukiernia) Napisz zapytanie w języku SQL oparte na tabeli Klienci, które:
-- 3.3.1 wyświetla nazwy miast, z których pochodzą klienci cukierni i które składają się z więcej niż jednego słowa,
SELECT miejscowosc FROM public.klienci WHERE miejscowosc LIKE '_% %_';
-- 3.3.2 wyświetla nazwy klientów, którzy podali numer stacjonarny telefonu,
SELECT nazwa FROM public.klienci WHERE LENGTH(telefon) = 13;
-- 3.3.3 wyświetla nazwy klientów, którzy podali numer komórkowy telefonu,
SELECT nazwa FROM public.klienci WHERE LENGTH(telefon) = 11;

-- 3.4 (baza danych: cukiernia) Korzystając z zapytań z zadania 2.4 oraz operatorów UNION, INTERSECT, EXCEPT 
-- napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek (idCzekoladki, nazwa, masa, koszt), których:
-- 3.4.1 masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24
UNION 
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24;
-- 3.4.2 masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35
EXCEPT
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.25 AND 0.35;
-- 3.4.3 masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr 
-- lub masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr,
    SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24
    INTERSECT
    SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24 
UNION (
    SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35
    INTERSECT
    SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.25 AND 0.35 
);
-- 3.4.4 masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24
INTERSECT
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24;
-- 3.4.5 masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, 
-- ani w przedziale od 29 do 35 gr.
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35
EXCEPT (
    SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24
    UNION
    SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.29 AND 0.35
);

-- 3.5 (baza danych: cukiernia) Korzystając z operatorów UNION, INTERSECT, EXCEPT napisz zapytanie w języku SQL wyświetlające:
-- 3.5.1 identyfikatory klientów, którzy nigdy nie złożyli żadnego zamówienia,
SELECT idklienta FROM klienci EXCEPT SELECT DISTINCT idklienta FROM zamowienia;
-- 3.5.2 identyfikatory pudełek, które nigdy nie zostały zamówione,
SELECT idpudelka FROM pudelka EXCEPT SELECT DISTINCT idpudelka FROM artykuly;
-- 3.5.3 nazwy klientów, czekoladek i pudełek, które zawierają rz (lub Rz),
SELECT nazwa FROM klienci WHERE nazwa ILIKE '%rz%' UNION
SELECT nazwa FROM czekoladki WHERE nazwa ILIKE '%rz%' UNION
SELECT nazwa FROM pudelka WHERE nazwa ILIKE '%rz%';
-- 3.5.4 identyfikatory czekoladek, które nie występują w żadnym pudełku.
SELECT idczekoladki FROM czekoladki EXCEPT SELECT idczekoladki FROM zawartosc;
