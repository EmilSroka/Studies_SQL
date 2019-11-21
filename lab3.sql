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