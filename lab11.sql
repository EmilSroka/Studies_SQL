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

-- 11.3 (baza danych: cukiernia)
-- 11.3.1 Napisz funkcję sumaZamowien obliczającą łączną wartość zamówień złożonych przez klienta, 
-- które czekają na realizację (są w tabeli Zamowienia). Funkcja jako argument przyjmuje identyfikator klienta. 
CREATE OR REPLACE FUNCTION sumaZamowien(id integer)
RETURNS numeric(7,2) AS
$$
DECLARE
	sum numeric(7,2);
BEGIN
	SELECT SUM(sztuk * cena) INTO sum 
	FROM zamowienia JOIN artykuly USING(idzamowienia)
	JOIN pudelka USING(idpudelka)
	WHERE idklienta = id;

	RETURN sum;
END
$$ LANGUAGE PLpgSQL
-- 11.3.2 Napisz funkcję rabat obliczającą rabat jaki otrzymuje klient składający zamówienie. 
-- Funkcja jako argument przyjmuje identyfikator klienta. 
-- Rabat wyliczany jest na podstawie wcześniej złożonych zamówień w sposób następujący:
-- * 4 % jeśli wartość zamówień jest z przedziału 101-200 zł;
-- * 7 % jeśli wartość zamówień jest z przedziału 201-400 zł;
-- * 8 % jeśli wartość zamówień jest większa od 400 zł.
CREATE OR REPLACE FUNCTION rabat(id integer)
RETURNS integer AS 
$$
DECLARE
	discount integer;
	previousValue numeric(7,2); 
BEGIN
	SELECT sumaZamowien(id) INTO previousValue;

	SELECT CASE 
		WHEN previousValue BETWEEN 101 AND 200 THEN 4 -- co z np. 200.50 ? 
		WHEN previousValue BETWEEN 201 AND 400 THEN 7
		WHEN previousValue > 400 THEN 8
		ELSE 0
	END
	INTO discount;

	RETURN discount;
END
$$ LANGUAGE PLpgSQL

-- 11.4 (baza danych: cukiernia) Napisz bezargumentową funkcję podwyzka, która dokonuje podwyżki kosztów produkcji czekoladek o:
-- * 3 gr dla czekoladek, których koszt produkcji jest mniejszy od 20 gr;
-- * 4 gr dla czekoladek, których koszt produkcji jest z przedziału 20-29 gr;
-- * 5 gr dla pozostałych.
-- Funkcja powinna ponadto podnieść cenę pudełek o tyle o ile zmienił się koszt produkcji zawartych w nich czekoladek.
CREATE OR REPLACE FUNCTION podwyzka()
RETURNS void AS
$$
DECLARE 
	czekoladka record;
	contains record;
	rise numeric(7,2);
BEGIN
	FOR czekoladka IN SELECT * FROM czekoladki LOOP 
		rise := CASE 
			WHEN czekoladka.koszt < 0.2 THEN 0.03
			WHEN czekoladka.koszt BETWEEN 0.2 AND 0.29 THEN 0.04
			ELSE 0.05
		END;

		UPDATE czekoladki SET koszt = koszt + rise
		WHERE idczekoladki = czekoladka.idczekoladki;

		FOR contains IN SELECT * FROM zawartosc WHERE idczekoladki = czekoladka.idczekoladki LOOP
			
			UPDATE pudelka SET cena = cena + contains.sztuk * rise WHERE idpudelka = contains.idpudelka;

		END LOOP; 
	END LOOP;
END
$$ LANGUAGE PLpgSQL

-- 11.5 (baza danych: cukiernia) Napisz funkcję obnizka odwracająca zmiany wprowadzone w poprzedniej funkcji.
CREATE OR REPLACE FUNCTION obnizka()
RETURNS void AS 
$$
DECLARE 
	chocolate record;
	contains record;
	decrease numeric(7,2);
BEGIN
	FOR chocolate IN SELECT * FROM czekoladki LOOP
		decrease := CASE 
			WHEN chocolate.koszt < 0.03 THEN 0
			WHEN chocolate.koszt BETWEEN 0.03 AND 0.23 THEN 0.03
			WHEN chocolate.koszt BETWEEN 0.24 AND 0.33 THEN 0.04
			ELSE 0.05
		END;

		UPDATE czekoladki SET koszt = koszt - decrease WHERE idczekoladki = chocolate.idczekoladki;

		FOR contains IN SELECT * FROM zawartosc WHERE idczekoladki = chocolate.idczekoladki LOOP 

			UPDATE pudelka SET cena = cena - contains.sztuk * decrease WHERE idpudelka = contains.idpudelka;

		END LOOP;
	END LOOP;
END
$$ LANGUAGE PLpgSQL

-- 11.6 (baza danych: cukiernia)
-- 11.6.1 Napisz funkcję zwracającą informacje o zamówieniach złożonych przez klienta, 
-- którego identyfikator podawany jest jako argument wywołania funkcji. 
-- W/w informacje muszą zawierać: idzamowienia, idpudelka, datarealizacji.
CREATE OR REPLACE FUNCTION info(id integer)
RETURNS table(
	r_idzamowienia integer,
	r_idpudelka char(4),
	r_datarealizacji date
) AS 
$$
BEGIN
	RETURN QUERY SELECT idzamowienia, idpudelka, datarealizacji
	FROM zamowienia JOIN artykuly USING(idzamowienia)
	WHERE idklienta = id;
END 
$$ LANGUAGE PLpgSQL
-- 11.6.2 Napisz funkcję zwracającą listę klientów z miejscowości, której nazwa podawana jest jako argument wywołania funkcji. 
-- Lista powinna zawierać: nazwę klienta i adres.
CREATE OR REPLACE FUNCTION klienci_z(town varchar(15))
RETURNS table(
	r_nazwa varchar(130),
	r_adres varchar(51)
) AS 
$$
DECLARE 
	client record; 
BEGIN
	FOR client IN SELECT * FROM klienci WHERE miejscowosc = town LOOP
		r_nazwa := client.nazwa;
		r_adres := CONCAT( client.ulica, E'\n', client.kod, ' ', client.miejscowosc );

		RETURN NEXT;
	END LOOP;
END
$$ LANGUAGE PLpgSQL