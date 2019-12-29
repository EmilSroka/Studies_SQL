begin;

CREATE SCHEMA cukiernia;

CREATE TABLE cukiernia.klienci (
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

CREATE TABLE cukiernia.kompozycje (
    idkompozycji         char(5) PRIMARY KEY,
    nazwa                varchar(40) NOT NULL,
    opis                 varchar(100),
    cena                 numeric(7,2) CHECK(cena >= 40),
    minimum              int,
    stan                 int
);

CREATE TABLE cukiernia.odbiorcy (
    idodbiorcy         serial PRIMARY KEY,
    nazwa              varchar(40) NOT NULL,
    miasto             varchar(40) NOT NULL,
    kod                char(6) NOT NULL,
    adres              varchar(40) NOT NULL
);

CREATE TABLE cukiernia.zamowienia (
    idzamowienia                   int PRIMARY KEY,
    idklienta                      varchar(10) NOT NULL REFERENCES cukiernia.klienci,
    idodbiorcy                     int NOT NULL REFERENCES cukiernia.odbiorcy,
    idkompozycji                   char(5) NOT NULL REFERENCES cukiernia.kompozycje,
    termin                         date NOT NULL,
    cena                           numeric(7,2),
    zaplacone                      boolean,
    uwagi                          varchar(200)
);

CREATE TABLE cukiernia.historia (
    idzamowienia                   int PRIMARY KEY,
    idklienta                      varchar(10),
    idkompozycji                   char(5),
    cena                           numeric(7,2),
    termin                         date
);

CREATE TABLE cukiernia.zapotrzebowanie (
    idkompozycji                   char(5) PRIMARY KEY REFERENCES cukiernia.kompozycje,
    data                           date
);

commit;