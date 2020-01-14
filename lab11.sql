-- 11.1 (baza danych: cukiernia)
-- 11.1.1 Napisz funkcję masaPudelka wyznaczającą masę pudełka jako sumę masy czekoladek w nim zawartych. 
-- Funkcja jako argument przyjmuje identyfikator pudełka.
CREATE OR REPLACE FUNCTION masaPudelka(id char(4))
RETURNS numeric(7,2) AS 
$$
DECLARE
	sum numeric(7,2);
BEGIN
	SELECT sum(sztuk * masa) INTO sum 
	FROM zawartosc JOIN czekoladki USING(idczekoladki)
	WHERE idpudelka = id;
	
	RETURN sum;
END
$$ LANGUAGE PLpgSQL
-- 11.1.2 Napisz funkcję liczbaCzekoladek wyznaczającą liczbę czekoladek znajdujących się w pudełku. 
-- Funkcja jako argument przyjmuje identyfikator pudełka.
CREATE OR REPLACE FUNCTION liczbaCzekoladek(id char(4))
RETURNS integer AS 
$$
DECLARE
	sum integer;
BEGIN
	SELECT sum(sztuk) INTO sum FROM zawartosc
	WHERE idpudelka = id;
	
	RETURN sum;
END
$$ LANGUAGE PLpgSQL

-- 11.2 (baza danych: cukiernia)
-- 11.2.1 Napisz funkcję zysk obliczającą zysk jaki cukiernia uzyskuje ze sprzedaży jednego pudełka czekoladek, 
-- zakładając, że zysk ten jest różnicą między ceną pudełka, a kosztem wytworzenia zawartych w nim czekoladek i kosztem opakowania 
-- (0,90 zł dla każdego pudełka). Funkcja jako argument przyjmuje identyfikator pudełka.
CREATE OR REPLACE FUNCTION zysk(id char(4))
RETURNS numeric(7,2) AS 
$$
DECLARE
	koszt_czekoladek numeric(7,2);
	zysk numeric(7,2);
BEGIN
	SELECT sum(sztuk * koszt) INTO koszt_czekoladek 
	FROM zawartosc JOIN czekoladki USING(idczekoladki) 
	WHERE idpudelka = id;
	
	SELECT cena - koszt_czekoladek - 0.9 INTO zysk FROM pudelka
	WHERE idpudelka = id;

	RETURN zysk;
END
$$ LANGUAGE PLpgSQL
-- 11.2.2 Napisz instrukcję select obliczającą zysk jaki cukiernia uzyska ze sprzedaży pudełek zamówionych w wybranym dniu
SELECT sum(sztuk * zysk(idpudelka)) 
FROM public.zamowienia JOIN public.artykuly USING(idzamowienia)
WHERE datarealizacji = '2013-10-30'; 