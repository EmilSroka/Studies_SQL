-- 5.1 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat:
-- 5.1.1 łącznej liczby czekoladek w bazie danych,
SELECT COUNT(*) AS ilosc_czekoladek FROM czekoladki;
-- 5.1.2 łącznej liczby czekoladek z nadzieniem (na 2 sposoby) - podpowiedź: count(*), count(nazwaKolumny),
SELECT COUNT(*) AS ilosc_czekoladek FROM czekoladki
WHERE nadzienie IS NOT NULL;
-- OR
SELECT COUNT(nadzienie) AS ilosc_czekoladek FROM czekoladki;
-- 5.1.3 pudełka, w którym jest najwięcej czekoladek (uwaga: konieczne jest użycie LIMIT),
SELECT idpudelka FROM pudelka p JOIN zawartosc z USING(idpudelka)
GROUP BY idpudelka 
ORDER BY SUM(z.sztuk) DESC LIMIT 1;
-- 5.1.4 łącznej liczby czekoladek w poszczególnych pudełkach,
SELECT idpudelka, SUM(z.sztuk) FROM pudelka p JOIN zawartosc z USING(idpudelka)
GROUP BY idpudelka;
-- 5.1.5 łącznej liczby czekoladek bez orzechów w poszczególnych pudełkach,
SELECT idpudelka, SUM(z.sztuk) 
FROM pudelka p JOIN zawartosc z USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy IS NULL
GROUP BY idpudelka;
-- 5.1.6 łącznej liczby czekoladek w mlecznej czekoladzie w poszczególnych pudełkach.
SELECT idpudelka, SUM(z.sztuk) 
FROM pudelka p JOIN zawartosc z USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.czekolada = 'mleczna'
GROUP BY idpudelka;

-- 5.2 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat:
-- 5.2.1 masy poszczególnych pudełek,
SELECT p.idpudelka, p.nazwa, SUM(c.masa * z.sztuk)
FROM pudelka p JOIN zawartosc z USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka, p.nazwa;
-- 5.2.2 pudełka o największej masie,
SELECT p.idpudelka, p.nazwa, SUM(c.masa * z.sztuk) AS masa
FROM pudelka p JOIN zawartosc z USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka, p.nazwa
ORDER BY masa DESC LIMIT 1;
-- 5.2.3 średniej masy pudełka w ofercie cukierni,
SELECT AVG(m.masa) FROM 
(
    SELECT SUM(c.masa * z.sztuk) AS masa
    FROM pudelka p JOIN zawartosc z USING(idpudelka)
    JOIN czekoladki c USING(idczekoladki)
    GROUP BY p.idpudelka, p.nazwa
) m;
-- OR średniej masy pudełka na stanie w cukierni,
SELECT SUM(m.masa * p.stan)/SUM(p.stan) FROM 
(
    SELECT p.idpudelka AS idpudelka, SUM(c.masa * z.sztuk) AS masa
    FROM pudelka p JOIN zawartosc z USING(idpudelka)
    JOIN czekoladki c USING(idczekoladki)
    GROUP BY p.idpudelka, p.nazwa
) m JOIN pudelka p USING(idpudelka);
-- 5.2.4 średniej wagi pojedynczej czekoladki w poszczególnych pudełkach,
SELECT p.idpudelka, p.nazwa, SUM(c.masa * z.sztuk)/SUM(z.sztuk) AS masa
FROM pudelka p JOIN zawartosc z USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka, p.nazwa;

-- 5.3 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat:
-- 5.3.1 liczby zamówień na poszczególne dni,
SELECT datarealizacji, COUNT(*) FROM zamowienia GROUP BY datarealizacji;
-- 5.3.2 łącznej liczby wszystkich zamówień,
SELECT COUNT(*) FROM zamowienia;
-- 5.3.3 łącznej wartości wszystkich zamówień,
SELECT SUM(a.sztuk * p.cena)
FROM artykuly a JOIN pudelka p USING(idpudelka);
-- 5.3.4 klientów, liczby złożonych przez nich zamówień i łącznej wartości złożonych przez nich zamówień.
SELECT k.idklienta, SUM(a.sztuk * p.cena), COUNT(z.idzamowienia)
FROM klienci k JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia) 
JOIN pudelka p USING(idpudelka)
GROUP BY k.idklienta;

-- 5.4 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat:
-- 5.4.1 czekoladki, która występuje w największej liczbie pudełek,
SELECT c.idczekoladki, COUNT(*)
FROM zawartosc z JOIN czekoladki c USING(idczekoladki)
GROUP BY c.idczekoladki
ORDER BY COUNT(*) DESC LIMIT 1;
-- 5.4.2 pudełka, które zawiera najwięcej czekoladek bez orzechów,
SELECT p.idpudelka, SUM(z.sztuk)
FROM  pudelka p JOIN zawartosc z USING(idpudelka) 
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy IS NULL
GROUP BY p.idpudelka
ORDER BY SUM(z.sztuk) DESC;
-- 5.4.3 czekoladki, która występuje w najmniejszej liczbie pudełek,
SELECT c.idczekoladki, COUNT(*)
FROM zawartosc z JOIN czekoladki c USING(idczekoladki)
GROUP BY c.idczekoladki
ORDER BY COUNT(*) ASC LIMIT 1;
-- 5.4.4 pudełka, które jest najczęściej zamawiane przez klientów.
SELECT p.idpudelka, COUNT(*)
FROM zamowienia z JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
GROUP BY p.idpudelka
ORDER BY COUNT(*) DESC LIMIT 1;

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

-- 5.8 (baza danych: cukiernia) Napisz zapytanie wyświetlające: liczbę porządkową i identyfikator pudełka czekoladek (idpudelka). 
-- Identyfikatory pudełek mają być posortowane alfabetycznie, rosnąco. Liczba porządkowa jest z przedziału 1..N, gdzie N jest ilością pudełek.
CREATE SEQUENCE lp START 1;
SELECT NEXTVAL('lp') AS lp, idpudelka FROM public.pudelka ORDER BY idpudelka;
DROP SEQUENCE lp;
