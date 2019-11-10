-- 5.5 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat:
-- 5.5.1 liczby zamówień na poszczególne kwartały
SELECT EXTRACT(YEAR FROM datarealizacji) AS rok, EXTRACT(QUARTER FROM datarealizacji) AS kwartal, COUNT(*) AS ile 
FROM public.zamowienia GROUP BY EXTRACT(YEAR FROM datarealizacji), EXTRACT(QUARTER FROM datarealizacji);
-- 5.5.2 liczby zamówień na poszczególne miesiące
SELECT EXTRACT(YEAR FROM datarealizacji) AS rok, EXTRACT(MONTH FROM datarealizacji) AS miesiac, COUNT(*) AS ile 
FROM public.zamowienia GROUP BY EXTRACT(YEAR FROM datarealizacji), EXTRACT(MONTH FROM datarealizacji)
ORDER BY miesiac;
-- 5.5.3 liczby zamówień do realizacji w poszczególnych tygodniach
SELECT EXTRACT(YEAR FROM datarealizacji) AS rok, EXTRACT(WEEK FROM datarealizacji) AS tydzien, COUNT(*) AS ile 
FROM public.zamowienia GROUP BY EXTRACT(YEAR FROM datarealizacji), EXTRACT(WEEK FROM datarealizacji)
ORDER BY tydzien;
-- 5.5.4 liczby zamówień do realizacji w poszczególnych miejscowościach
SELECT k.miejscowosc, COUNT(*) AS ile 
FROM public.zamowienia z JOIN public.klienci k USING(idklienta) 
GROUP BY k.miejscowosc
ORDER BY k.miejscowosc;

