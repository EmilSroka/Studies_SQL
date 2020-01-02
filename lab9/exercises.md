# Treść zadań do ćwiczeń z lab 9

1. Przygotuj skrypt kwiaciarnia.sql implementujący bazę danych kwiaciarnia zgodnie z przedstawionym poniżej projektem.  
Uwaga: Baza danych kwiaciarnia ma zostać umieszczona w schemacie kwiaciarnia.  
![Schemat](../assets/kwiaciarnia.png)  

2. Przygotuj odpowiednio dane z pliku /assets/kwiaciarnia2dane-tekst.txt i zaimportuj je do bazy danych.

3. Przygotuj skrypt firma.sql implementujący bazę danych firma zgodnie z przedstawionym poniżej opisem.
Relacja dzialy zawiera atrybuty:
* iddzialu - typ znakowy, dokładnie 5 znaków, klucz główny,
* nazwa - typ znakowy, maksymalnie 32 znaki, wymagane,
* lokalizacja - typ znakowy, maksymalnie 24 znaki, wymagane,
* kierownik - liczba całkowita, klucz obcy odwołujący się do pola idpracownika w relacji pracownicy.  
Relacja pracownicy zawiera atrybuty:
* idpracownika - liczba całkowita, klucz główny,
* nazwisko - typ znakowy, maksymalnie 32 znaki, wymagane,
* imie - typ znakowy, maksymalnie 16 znaków, wymagane,
* dataUrodzenia - data, wymagane,
* dzial - typ znakowy, dokładnie 5 znaków, wymagane, klucz obcy odwołujący się do pola iddzialu w relacji dzialy,
* stanowisko - typ znakowy, maksymalnie 24 znaki,
* pobory - typ stałoprzecinkowy z dokładnością do 2 miejsc po przecinku.