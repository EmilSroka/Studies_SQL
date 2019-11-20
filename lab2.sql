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

-- 2.3 Potraktuj psql jak kalkulator i wyznacz:
-- 2.3.1 124 * 7 + 45,
SELECT 124 * 7 + 45 AS wynik;
-- 2.3.2 2 ^ 20,
SELECT 2 ^ 20 AS wynik;
-- 2.3.3 √3,
SELECT sqrt(3) AS wynik;
-- 2.3.4 π.
SELECT pi() AS wynik;

-- 2.4 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek (IDCzekoladki, Nazwa, Masa, Koszt), których:
-- 2.4.1 masa mieści się w przedziale od 15 do 24 g,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24;
-- 2.4.2 koszt produkcji mieści się w przedziale od 25 do 35 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.25 AND 0.35;
-- 2.4.3 masa mieści się w przedziale od 25 do 35 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr.
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki 
WHERE masa BETWEEN 25 AND 35 OR koszt BETWEEN 0.15 AND 0.24;

-- 2.5 (baza danych: cukiernia) Napisz zapytanie w języku SQL wyświetlające informacje na temat czekoladek (idCzekoladki, nazwa, czekolada, orzechy, nadzienie), które:
-- 2.5.1 zawierają jakieś orzechy,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE orzechy IS NOT NULL;
-- 2.5.2 nie zawierają orzechów,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE orzechy IS NULL;
-- 2.5.3 zawierają jakieś orzechy lub jakieś nadzienie,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE orzechy IS NOT NULL OR nadzienie IS NOT NULL;
-- 2.5.4 są w mlecznej lub białej czekoladzie (użyj IN) i nie zawierają orzechów,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE czekolada IN ('mleczna', 'biała') AND orzechy IS NULL;
-- 2.5.5 nie są ani w mlecznej ani w białej czekoladzie i zawierają jakieś orzechy lub jakieś nadzienie,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE czekolada NOT IN ('mleczna', 'biała') AND (orzechy IS NOT NULL OR nadzienie IS NOT NULL);
-- 2.5.6 zawierają jakieś nadzienie,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nadzienie IS NOT NULL;
-- 2.5.7 nie zawierają nadzienia,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nadzienie IS NULL;
-- 2.5.8 nie zawierają orzechów ani nadzienia,
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE orzechy IS NULL AND nadzienie IS NULL;
-- 2.5.9 są w mlecznej lub białej czekoladzie i nie zawierają nadzienia.
SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki 
WHERE czekolada IN ('mleczna', 'biała') AND orzechy IS NULL;

-- 2.6 (baza danych: cukiernia) Napisz zapytanie w języku SQL, które wyświetli czekoladki których:
-- 2.6.1 masa mieści się w przedziale od 15 do 24 g lub koszt produkcji mieści się w przedziale od 15 do 24 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki
WHERE masa BETWEEN 15 AND 24 OR koszt BETWEEN 0.15 AND 0.24;
-- 2.6.2 masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr lub 
-- masa mieści się w przedziale od 25 do 35 g i koszt produkcji mieści się w przedziale od 25 do 35 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki
WHERE masa BETWEEN 15 AND 24 AND koszt BETWEEN 0.15 AND 0.24 
OR masa BETWEEN 25 AND 35 AND koszt BETWEEN 0.25 AND 0.35;
-- 2.6.3 masa mieści się w przedziale od 15 do 24 g i koszt produkcji mieści się w przedziale od 15 do 24 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki
WHERE masa BETWEEN 15 AND 24 AND koszt BETWEEN 0.15 AND 0.24;
-- 2.6.4 masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się w przedziale od 25 do 35 gr,
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki
WHERE masa BETWEEN 25 AND 35 AND koszt NOT BETWEEN 0.25 AND 0.35; 
-- 2.6.5 masa mieści się w przedziale od 25 do 35 g, ale koszt produkcji nie mieści się ani w przedziale od 15 do 24 gr, 
-- ani w przedziale od 25 do 35 gr.
SELECT idczekoladki, nazwa, masa, koszt FROM public.czekoladki
WHERE masa BETWEEN 25 AND 35 AND koszt NOT BETWEEN 0.15 AND 0.35; 