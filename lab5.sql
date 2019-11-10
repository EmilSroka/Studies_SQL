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

-- 5.6 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat:
-- 5.6.1 łącznej masy wszystkich pudełek czekoladek znajdujących się w cukierni
SELECT SUM(cz.masa * z.sztuk * p.stan) AS masa FROM public.czekoladki cz 
JOIN public.zawartosc z USING(idczekoladki) 
JOIN public.pudelka p USING(idpudelka);
-- 5.6.2 łącznej wartości wszystkich pudełek czekoladek znajdujących się w cukierni
SELECT SUM(cena * stan) AS wartosc FROM public.pudelka;

-- 5.7 (baza danych: cukiernia) Zakładając, że koszt wytworzenia pudełka czekoladek jest równy kosztowi wytworzenia zawartych w nim czekoladek, napisz zapytanie wyznaczające:
-- 5.7.1 zysk ze sprzedaży jednej sztuki poszczególnych pudełek (różnica między ceną pudełka i kosztem jego wytworzenia)
SELECT p.idpudelka, p.nazwa, p.cena - SUM(cz.koszt * z.sztuk) AS zysk FROM public.czekoladki cz 
JOIN public.zawartosc z USING(idczekoladki) 
JOIN public.pudelka p USING(idpudelka)
GROUP BY p.idpudelka, p.nazwa
ORDER BY zysk DESC;
-- 5.7.2 zysk ze sprzedaży zamówionych pudełek
WITH zysk AS (
    SELECT p.idpudelka, p.nazwa, p.cena - SUM(cz.koszt * z.sztuk) AS zysk FROM public.czekoladki cz 
    JOIN public.zawartosc z USING(idczekoladki) 
    JOIN public.pudelka p USING(idpudelka)
    GROUP BY p.idpudelka, p.nazwa
) SELECT SUM(a.sztuk * z.zysk) AS "calkowity zysk" FROM public.artykuly a
JOIN zysk z USING(idpudelka);
-- 5.7.3 zysk ze sprzedaży wszystkich pudełek czekoladek w cukierni
WITH zysk AS (
    SELECT p.idpudelka, p.nazwa, p.cena - SUM(cz.koszt * z.sztuk) AS zysk FROM public.czekoladki cz 
    JOIN public.zawartosc z USING(idczekoladki) 
    JOIN public.pudelka p USING(idpudelka)
    GROUP BY p.idpudelka, p.nazwa
) SELECT SUM(p.stan * z.zysk) AS "calkowity zysk" FROM public.pudelka p
JOIN zysk z USING(idpudelka);

