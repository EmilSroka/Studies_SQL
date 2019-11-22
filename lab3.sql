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