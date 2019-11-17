-- 2.1 (baza danych: cukiernia) Napisz zapytanie w języku SQL, które:
-- 2.1.1 wyświetla listę klientów (nazwa, ulica, miejscowość) posortowaną według nazw klientów,
SELECT nazwa, ulica, miejscowosc FROM public.klienci ORDER BY nazwa;
-- 2.1.2 wyświetla listę klientów posortowaną malejąco według nazw miejscowości, a w ramach tej samej miejscowości rosnąco według nazw klientów,
SELECT nazwa, ulica, miejscowosc FROM public.klienci ORDER BY miejscowosc DESC, nazwa ASC;
-- 2.1.3 wyświetla listę klientów z Krakowa lub z Warszawy posortowaną malejąco według nazw miejscowości,
--  a w ramach tej samej miejscowości rosnąco według nazw klientów (zapytanie utwórz na dwa sposoby stosując w kryteriach or lub in).
SELECT nazwa, ulica, miejscowosc FROM public.klienci WHERE miejscowosc IN ('Kraków', 'Warszawa') ORDER BY miejscowosc DESC, nazwa ASC;
SELECT nazwa, ulica, miejscowosc FROM public.klienci WHERE miejscowosc='Kraków' OR  miejscowosc='Warszawa' ORDER BY miejscowosc DESC, nazwa ASC;
-- 2.1.4 wyświetla listę klientów posortowaną malejąco według nazw miejscowości,
SELECT nazwa, ulica, miejscowosc FROM public.klienci ORDER BY miejscowosc DESC;
-- 2.1.5 wyświetla listę klientów z Krakowa posortowaną według nazw klientów.
SELECT nazwa, ulica, miejscowosc FROM public.klienci WHERE miejscowosc='Kraków' ORDER BY nazwa;

-- 2.2 (baza danych: cukiernia) Napisz zapytanie w języku SQL, które:
-- 2.2.1 wyświetla nazwę i masę czekoladek, których masa jest większa niż 20 g,
SELECT nazwa, masa FROM public.czekoladki WHERE masa > 20;
-- 2.2.2 wyświetla nazwę, masę i koszt produkcji czekoladek, których masa jest większa niż 20 g i koszt produkcji jest większy niż 25 gr,
SELECT nazwa, masa, koszt FROM public.czekoladki WHERE masa > 20 AND koszt > 0.25;
-- 2.2.3 j.w. ale koszt produkcji musi być podany w groszach,
SELECT nazwa, masa, CAST(koszt*100 AS INT) AS koszt FROM public.czekoladki WHERE masa > 20 AND koszt > 0.25;
SELECT nazwa, masa, (koszt*100)::INT AS koszt FROM public.czekoladki WHERE masa > 20 AND koszt > 0.25; -- PostgreSQL cast operator
-- 2.2.4 wyświetla nazwę oraz rodzaj czekolady, nadzienia i orzechów dla czekoladek, które są w mlecznej czekoladzie i nadziane malinami 
-- lub są w mlecznej czekoladzie i nadziane truskawkami lub zawierają orzechy laskowe, ale nie są w gorzkiej czekoladzie,
SELECT nazwa, czekolada, nadzienie, orzechy FROM public.czekoladki WHERE 
czekolada='mleczna' AND nadzienie='maliny' OR
czekolada='mleczna' AND nadzienie='truskawki' OR
orzechy='laskowe' AND czekolada<>'gorzka';
-- 2.2.5 wyświetla nazwę i koszt produkcji czekoladek, których koszt produkcji jest większy niż 25 gr,
SELECT nazwa, koszt FROM public.czekoladki WHERE koszt > 0.25;
-- 2.2.6 wyświetla nazwę i rodzaj czekolady dla czekoladek, które są w białej lub mlecznej czekoladzie.
SELECT nazwa, czekolada FROM public.czekoladki WHERE czekolada IN ('mleczna', 'biała');