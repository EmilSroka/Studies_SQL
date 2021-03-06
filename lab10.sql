-- 10.2 (baza danych: cukiernia) Napisz zapytanie wyświetlające informacje na temat zamówień 
-- (dataRealizacji, idzamowienia) używając odpowiedniego operatora in/not in/exists/any/all, które:
-- 10.2.1 zostały złożone przez klienta, który ma na imię Antoni,
SELECT datarealizacji, idzamowienia FROM zamowienia 
WHERE idklienta IN (SELECT idklienta FROM klienci WHERE nazwa LIKE '% Antoni');
-- 10.2.2 zostały złożone przez klientów z mieszkań (zwróć uwagę na pole ulica),
SELECT datarealizacji, idzamowienia 
FROM zamowienia z 
WHERE idklienta IN (SELECT idklienta FROM klienci WHERE ulica LIKE '%/%');
-- 10.2.3 zostały złożone przez klienta z Krakowa do realizacji w listopadzie 2013 roku.
SELECT datarealizacji, idzamowienia FROM zamowienia
WHERE idklienta IN (SELECT idklienta FROM klienci WHERE miejscowosc = 'Kraków')
AND datarealizacji BETWEEN '2013-11-01' AND '2013-11-30';

-- 10.3 (baza danych: cukiernia) Napisz zapytanie wyświetlające informacje na temat klientów 
-- (nazwa, ulica, miejscowość), używając odpowiedniego operatora in/not in/exists/any/all, którzy:
-- 10.3.1 złożyli zamówienia z datą realizacji 12.11.2013,
SELECT nazwa, ulica, miejscowosc FROM klienci 
WHERE idklienta IN (SELECT idklienta FROM zamowienia WHERE datarealizacji = '2013-11-12');
-- 10.3.2 złożyli zamówienia z datą realizacji w listopadzie 2013,
SELECT nazwa, ulica, miejscowosc FROM klienci 
WHERE idklienta = ANY (
  SELECT idklienta FROM zamowienia 
  WHERE datarealizacji BETWEEN '2013-11-01' AND '2013-11-30'
);
-- 10.3.3 zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,
SELECT DISTINCT nazwa, ulica, miejscowosc FROM klienci JOIN zamowienia USING(idklienta) 
WHERE idzamowienia IN (
    SELECT idzamowienia FROM artykuly JOIN pudelka USING(idpudelka)
    WHERE nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna')
); 
-- 10.3.4 zamówili co najmniej 2 sztuki pudełek Kremowa fantazja lub Kolekcja jesienna w ramach jednego zamówienia,
SELECT DISTINCT nazwa, ulica, miejscowosc FROM klienci JOIN zamowienia USING(idklienta) 
WHERE idzamowienia IN (
    SELECT idzamowienia FROM artykuly JOIN pudelka USING(idpudelka)
    WHERE nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna')
    AND sztuk > 1
); 
-- 10.3.5 zamówili pudełka, które zawierają czekoladki z migdałami,
SELECT DISTINCT nazwa, ulica, miejscowosc FROM klienci 
JOIN zamowienia USING(idklienta) 
JOIN artykuly USING(idzamowienia)
WHERE idpudelka IN (
    SELECT idpudelka FROM zawartosc JOIN czekoladki USING(idczekoladki)
    WHERE orzechy = 'migdały'
); 
-- 10.3.6 złożyli przynajmniej jedno zamówienie,
SELECT nazwa, ulica, miejscowosc FROM klienci
WHERE idklienta IN (SELECT idklienta FROM zamowienia);
-- 10.3.7 nie złożyli żadnych zamówień.
SELECT nazwa, ulica, miejscowosc FROM klienci
WHERE idklienta NOT IN (SELECT idklienta FROM zamowienia);

-- 10.4 (baza danych: cukiernia) Napisz zapytanie wyświetlające informacje na temat pudełek z czekoladkami 
-- (nazwa, opis, cena), używając odpowiedniego operatora, np. in/not in/exists/any/all, które:
-- 10.4.1 zawierają czekoladki o wartości klucza głównego D09,
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
    SELECT idpudelka FROM zawartosc 
    WHERE idczekoladki = 'd09'
); 
-- 10.4.2 zawierają czekoladki Gorzka truskawkowa,
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
    SELECT idpudelka FROM zawartosc 
    JOIN czekoladki USING(idczekoladki)
    WHERE nazwa = 'Gorzka truskawkowa'
); 
-- 10.4.3 zawierają przynajmniej jedną czekoladkę, której nazwa zaczyna się na S,
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
    SELECT idpudelka FROM zawartosc 
    JOIN czekoladki USING(idczekoladki)
    WHERE nazwa LIKE 'S%'
); 
-- 10.4.4 zawierają przynajmniej 4 sztuki czekoladek jednego gatunku (o takim samym kluczu głównym),
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
    SELECT idpudelka FROM zawartosc 
    JOIN czekoladki USING(idczekoladki)
    WHERE sztuk > 3
); 
-- 10.4.5 zawierają co najmniej 3 sztuki czekoladki Gorzka truskawkowa,
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
    SELECT idpudelka FROM zawartosc 
    JOIN czekoladki USING(idczekoladki)
    WHERE sztuk > 2 AND nazwa = 'Gorzka truskawkowa'
); 
-- 10.4.6 zawierają czekoladki z nadzieniem truskawkowym,
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
  SELECT idpudelka FROM zawartosc
  JOIN czekoladki USING(idczekoladki)
  WHERE nadzienie = 'truskawki'
);
-- 10.4.7 nie zawierają czekoladek w gorzkiej czekoladzie,
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka NOT IN (
  SELECT idpudelka FROM zawartosc
  JOIN czekoladki USING(idczekoladki)
  WHERE nadzienie = 'gorzka'
);
-- 10.4.8 nie zawierają czekoladek z orzechami,
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
  SELECT idpudelka FROM zawartosc
  JOIN czekoladki USING(idczekoladki)
  WHERE orzechy IS NULL 
);
-- 10.4.9 zawierają przynajmniej jedną czekoladkę bez nadzienia.
SELECT nazwa, opis, cena FROM pudelka 
WHERE idpudelka IN (
  SELECT idpudelka FROM zawartosc
  JOIN czekoladki USING(idczekoladki)
  WHERE nadzienie IS NULL 
);

-- 10.5 (baza danych: cukiernia) Napisz poniższe zapytania w języku SQL 
-- (używając odpowiedniego operatora, np. in/not in/exists/any/all):
-- 10.5.1 Wyświetl wartości kluczy głównych oraz nazwy czekoladek, 
-- których koszt jest większy od czekoladki o wartości klucza głównego równej D08.
SELECT idczekoladki, nazwa FROM czekoladki 
WHERE koszt > (SELECT koszt FROM czekoladki WHERE idczekoladki = 'd08');
-- 10.5.2 Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Gorka Alicja.
SELECT DISTINCT nazwa FROM klienci 
JOIN zamowienia USING(idklienta) 
JOIN artykuly USING(idzamowienia) 
WHERE idpudelka IN (
  SELECT idpudelka FROM artykuly
  JOIN zamowienia USING(idzamowienia)
  JOIN klienci USING(idklienta)
  WHERE nazwa = 'Górka Alicja'
) AND nazwa <> 'Górka Alicja';
-- 10.5.3 Kto (nazwa klienta, adres) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiali klienci z Katowic.
SELECT DISTINCT nazwa, miejscowosc FROM klienci 
JOIN zamowienia USING(idklienta) 
JOIN artykuly USING(idzamowienia) 
WHERE idpudelka IN (
  SELECT idpudelka FROM artykuly
  JOIN zamowienia USING(idzamowienia)
  JOIN klienci USING(idklienta)
  WHERE miejscowosc = 'Katowice'
) AND miejscowosc <> 'Katowice';

-- 10.6 (baza danych: cukiernia) Wyświetl nazwę pudełka oraz ilość czekoladek, dla:
-- 10.6.1 pudełka o największej liczbie czekoladek (bez użycia klauzuli limit),
SELECT nazwa, sum(sztuk) AS ile_czekoladek FROM pudelka 
JOIN zawartosc USING(idpudelka)
GROUP BY nazwa 
HAVING sum(sztuk) >= ALL (SELECT sum(sztuk) FROM zawartosc GROUP BY idpudelka);
-- 10.6.2 pudełka o najmniejszej liczbie czekoladek (bez użycia klauzuli limit),
SELECT nazwa, sum(sztuk) AS ile_czekoladek FROM pudelka 
JOIN zawartosc USING(idpudelka)
GROUP BY nazwa 
HAVING sum(sztuk) <= ALL (SELECT sum(sztuk) FROM zawartosc GROUP BY idpudelka);
-- 10.6.3 pudełka, w którym liczba czekoladek jest powyżej średniej,
WITH sums AS (
  SELECT sum(sztuk) AS ile_czekoladek FROM zawartosc GROUP BY idpudelka
) 
SELECT nazwa, sum(sztuk) AS ile_czekoladek 
FROM pudelka JOIN zawartosc USING(idpudelka)
GROUP BY nazwa
HAVING sum(sztuk) > (SELECT AVG(ile_czekoladek) FROM sums);
-- 10.6.4 udełka o największej lub najmniejszej liczbie czekoladek.
SELECT nazwa, sum(sztuk) AS ile_czekoladek FROM pudelka 
JOIN zawartosc USING(idpudelka)
GROUP BY nazwa 
HAVING sum(sztuk) <= ALL (SELECT sum(sztuk) FROM zawartosc GROUP BY idpudelka)
OR sum(sztuk) >= ALL (SELECT sum(sztuk) FROM zawartosc GROUP BY idpudelka);