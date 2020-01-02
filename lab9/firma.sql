begin;

CREATE SCHEMA firma;

CREATE TABLE firma.dzialy (
    iddzialu               char(5) PRIMARY KEY,
    nazwa                  varchar(32) NOT NULL,
    lokalizacja            varchar(24) NOT NULL,
    kierownik              int
);

CREATE TABLE firma.pracownicy (
    idpracownika               int PRIMARY KEY,
    nazwisko                   varchar(32) NOT NULL,
    imie                       varchar(16) NOT NULL,
    dataUrodzenia              date NOT NULL,
    dzial                      char(5) NOT NULL REFERENCES firma.dzialy (iddzialu),
    stanowisko                 varchar(24),
    pobory                     numeric(9,2)
);

ALTER TABLE firma.dzialy ADD CONSTRAINT dzialy_foreign_key 
FOREIGN KEY(kierownik) REFERENCES firma.pracownicy(idpracownika) ON UPDATE CASCADE DEFERRABLE;

commit;