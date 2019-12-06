-- 4.2 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat zamówień (data realizacji, idzamowienia), które:
-- 4.2.1 zostały złożone przez klienta, który ma na imię Antoni,
SELECT z.datarealizacji, z.idzamowienia
FROM zamowienia	z JOIN klienci k USING(idklienta)
WHERE k.nazwa LIKE '%_ Antoni';
-- 4.2.2 zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica),
SELECT z.datarealizacji, z.idzamowienia
FROM zamowienia	z JOIN klienci k USING(idklienta)
WHERE k.ulica LIKE '%/%';
-- 4.2.3 zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.
SELECT z.datarealizacji, z.idzamowienia
FROM zamowienia	z JOIN klienci k USING(idklienta)
WHERE k.miejscowosc = 'Kraków' AND
datarealizacji BETWEEN '2013-11-01' AND '2013-11-30';

-- 4.3 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat klientów (nazwa, ulica, miejscowość), którzy:
-- 4.3.1 złożyli zamówienia z datą realizacji nie starszą niż sprzed pięciu lat,
SELECT k.nazwa, k.ulica, k.miejscowosc 
FROM klienci k JOIN zamowienia z USING(idklienta)
WHERE AGE(z.datarealizacji) < '5 years';
-- 4.3.2 zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia) 
JOIN pudelka p USING(idpudelka)
WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna');
-- 4.3.3 złożyli przynajmniej jedno zamówienie,
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k JOIN zamowienia z USING(idklienta);
-- 4.3.4 nie złożyli żadnych zamówień,
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k LEFT JOIN zamowienia z USING(idklienta)
WHERE z.idzamowienia IS NULL;
-- 4.3.5 złożyli zamówienia z datą realizacji w listopadzie 2013,
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k JOIN zamowienia z USING(idklienta)
WHERE z.datarealizacji BETWEEN '2013-11-01' AND '2013-11-30';
-- 4.3.6 zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia,
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia) 
JOIN pudelka p USING(idpudelka)
WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna') 
AND a.sztuk > 1;
-- 4.3.7 zamówili pudełka, które zawierają czekoladki z migdałami.
SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc
FROM klienci k JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia) 
JOIN pudelka p USING(idpudelka)
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy = 'migdały';

-- 4.4 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek i ich zawartości (nazwa, opis, nazwa czekoladki, opis czekoladki):
-- 4.4.1 wszystkich pudełek
SELECT p.nazwa, p.opis, c.nazwa AS "nazwa czekoladki", c.opis AS "opis czekoladki"  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
ORDER BY nazwa;
-- 4.4.2 pudełka o wartości klucza głównego heav
SELECT p.idpudelka, p.nazwa, p.opis, c.nazwa AS "nazwa czekoladki", c.opis AS "opis czekoladki"  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE idpudelka = 'heav';
-- 4.4.3 pudełek, których nazwa zawiera słowo Kolekcja
SELECT p.nazwa, p.opis, c.nazwa AS "nazwa czekoladki", c.opis AS "opis czekoladki"  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE p.nazwa LIKE '%Kolekcja%';

-- 4.5 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat pudełek z czekoladkami (nazwa, opis, cena), które:
-- 4.5.1 zawierają czekoladki o wartości klucza głównego d09
SELECT c.idczekoladki, p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE c.idczekoladki = 'd09';
-- 4.5.2 zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S
SELECT DISTINCT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE c.nazwa LIKE 'S%';
-- 4.5.3 zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym)
SELECT DISTINCT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE z.sztuk >= 4;
-- 4.5.4 zawierają czekoladki z nadzieniem truskawkowym
SELECT DISTINCT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE nadzienie = 'truskawki';
-- 4.5.5 nie zawierają czekoladek w gorzkiej czekoladzie
SELECT nazwa, opis, cena FROM pudelka
EXCEPT 
SELECT DISTINCT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE czekolada = 'gorzka';
-- 4.5.6 zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa
SELECT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE c.nazwa='Gorzka truskawkowa' AND z.sztuk >= 3;
-- 4.5.7 nie zawierają czekoladek z orzechami
SELECT nazwa, opis, cena FROM pudelka
EXCEPT 
SELECT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE orzechy IS NOT NULL;
-- 4.5.8 zawierają czekoladki Gorzka truskawkowa
SELECT DISTINCT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE c.nazwa='Gorzka truskawkowa';
-- 4.5.9 zawierają przynajmniej jedną czekoladkę bez nadzienia
SELECT DISTINCT p.nazwa, p.opis, p.cena  
FROM public.pudelka p JOIN public.zawartosc z USING(idpudelka)
JOIN public.czekoladki c USING(idczekoladki)
WHERE c.nadzienie IS NULL;

-- 4.6 (baza danych: cukiernia) Napisz poniższe zapytania w języku SQL:
-- 4.6.1 Wyświetl wartości kluczy głównych oraz nazwy czekoladek, których koszt jest większy od kosztu czekoladki o wartości klucza głównego równej d08
SELECT idczekoladki, nazwa FROM public.czekoladki 
WHERE koszt > (SELECT koszt FROM public.czekoladki WHERE idczekoladki = 'd08');
-- 4.6.2 Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Górka Alicja.
WITH zamowilaAlicja AS (
    SELECT a.idpudelka FROM
    klienci k JOIN zamowienia z USING (idklienta)
    JOIN artykuly a USING (idzamowienia)
    WHERE k.nazwa = 'Górka Alicja'
)
SELECT k.nazwa FROM 
klienci k JOIN zamowienia USING (idklienta)
JOIN artykuly USING (idzamowienia)
JOIN zamowilaAlicja USING (idpudelka)
WHERE k.nazwa <> 'Górka Alicja'
GROUP BY k.nazwa;
-- inna interpretacja: Kto złożył zamówienia na dokładnie takie same pudełka
SELECT k.nazwa FROM 
klienci k JOIN zamowienia USING (idklienta)
JOIN artykuly a USING (idzamowienia)
WHERE k.nazwa <> 'Górka Alicja' AND a.idpudelka IN (
    SELECT a.idpudelka FROM
    klienci k JOIN zamowienia z USING (idklienta)
    JOIN artykuly a USING (idzamowienia)
    WHERE k.nazwa = 'Górka Alicja'
)
GROUP BY k.nazwa
HAVING COUNT(*) = (
    SELECT COUNT(*) FROM
    klienci k JOIN zamowienia z USING (idklienta)
    JOIN artykuly a USING (idzamowienia)
    WHERE k.nazwa = 'Górka Alicja'
);
-- 4.6.3 Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic
WITH zamowieniaZKatowic AS (
    SELECT a.idpudelka FROM
    klienci k JOIN zamowienia z USING (idklienta)
    JOIN artykuly a USING (idzamowienia)
    WHERE k.miejscowosc = 'Katowice'
)
SELECT k.nazwa, CONCAT(k.ulica, ', ', k.kod, ' ' , k.miejscowosc) AS adres FROM 
klienci k JOIN zamowienia USING (idklienta)
JOIN artykuly USING (idzamowienia)
JOIN zamowieniaZKatowic USING (idpudelka)
WHERE k.miejscowosc <> 'Katowice'
GROUP BY k.nazwa, k.ulica, k.kod, k.miejscowosc;