-- 1.2 (baza danych: siatkowka, oprogramowanie: psql)
-- 1.2.3 Utwórz schemat siatkowka
CREATE SCHEMA siatkowka;
-- 1.2.6 Wykonaj zapytanie select imie, nazwisko from siatkarki; 
-- Dlaczego serwer generuje błąd? Jak należy zmodyfikować zapytanie?
SELECT imie, nazwisko FROM siatkowka.siatkarki;

-- 1.3 (baza danych: cukiernia)
-- 1.3.5 Korzystając z możliwości filtrowania danych, wyszukaj dane o czekoladkach:
-- które są w mlecznej czekoladzie;
SELECT * FROM public.czekoladki WHERE czekolada='mleczna';
-- które są w mlecznej czekoladzie i zawierają orzechy laskowe;
SELECT * FROM public.czekoladki WHERE czekolada='mleczna' AND orzechy='laskowe';
-- które są w mlecznej lub w gorzkiej czekoladzie (użyj in);
SELECT * FROM public.czekoladki WHERE czekolada IN ('mleczna', 'gorzka');
-- których masa jest większa niż 25 g.
SELECT * FROM public.czekoladki WHERE masa > 25;
-- 1.3.6 Korzystając z możliwości filtrowania danych, wyszukaj dane o klientach:
-- którzy są z Gdańska, Krakowa lub Warszawy;
SELECT * FROM public.klienci WHERE miejscowosc IN ('Kraków', 'Gdańsk', 'Warszawa');
-- którzy nie są z Gdańska;
SELECT * FROM public.klienci WHERE miejscowosc <> 'Gdańsk';
-- którzy mieszkają (mają siedzibę) przy ulicy Akacjowej
SELECT * FROM public.klienci WHERE ulica LIKE 'Akacjowa %';
