begin;

CREATE SCHEMA kwiaciarnia;

CREATE TABLE kwiaciarnia.klienci (
    idklienta         varchar(10) PRIMARY KEY,
    haslo             varchar(10) CHECK(LENGTH(haslo) > 3) NOT NULL,
    nazwa             varchar(40) NOT NULL,
    miasto            varchar(40) NOT NULL,
    kod               char(6) NOT NULL,
    adres             varchar(40) NOT NULL,
    email             varchar(40) NOT NULL,
    telefon           varchar(16) NOT NULL,
    fax               varchar(16),
    nip               char(13),
    regon             char(9)
);

CREATE TABLE kwiaciarnia.kompozycje (
    idkompozycji         char(5) PRIMARY KEY,
    nazwa                varchar(40) NOT NULL,
    opis                 varchar(100),
    cena                 numeric(7,2) CHECK(cena >= 40),
    minimum              int,
    stan                 int
);

CREATE TABLE kwiaciarnia.odbiorcy (
    idodbiorcy         serial PRIMARY KEY,
    nazwa              varchar(40) NOT NULL,
    miasto             varchar(40) NOT NULL,
    kod                char(6) NOT NULL,
    adres              varchar(40) NOT NULL
);

CREATE TABLE kwiaciarnia.zamowienia (
    idzamowienia                   int PRIMARY KEY,
    idklienta                      varchar(10) NOT NULL REFERENCES kwiaciarnia.klienci,
    idodbiorcy                     int NOT NULL REFERENCES kwiaciarnia.odbiorcy,
    idkompozycji                   char(5) NOT NULL REFERENCES kwiaciarnia.kompozycje,
    termin                         date NOT NULL,
    cena                           numeric(7,2),
    zaplacone                      boolean,
    uwagi                          varchar(200)
);

CREATE TABLE kwiaciarnia.historia (
    idzamowienia                   int PRIMARY KEY,
    idklienta                      varchar(10),
    idkompozycji                   char(5),
    cena                           numeric(7,2),
    termin                         date
);

CREATE TABLE kwiaciarnia.zapotrzebowanie (
    idkompozycji                   char(5) PRIMARY KEY REFERENCES kwiaciarnia.kompozycje,
    data                           date
);

commit;