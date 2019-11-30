-- Generated by Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   at:        2019-11-30 16:29:27 CET
--   site:      SQL Server 2012
--   type:      SQL Server 2012



CREATE TABLE historie_ceny (
    history_id   INTEGER PRIMARY KEY IDENTITY,
    cena         INTEGER,
    datum        datetime,
    spoj_id      INTEGER NOT NULL
)

CREATE TABLE jizda (
    jizda_id   INTEGER PRIMARY KEY IDENTITY,
    datum      DATE,
    spoj_id    INTEGER NOT NULL
)

CREATE TABLE jizdenka (
    jizdenka_id        INTEGER PRIMARY KEY IDENTITY,
    uzivatel_id        INTEGER NOT NULL,
    jizda_id           INTEGER NOT NULL,
    stanice_id_start   INTEGER NOT NULL,
    stanice_id_cil     INTEGER NOT NULL,
    cena               INTEGER
)

CREATE TABLE mesto (
    mesto_id   INTEGER PRIMARY KEY IDENTITY,
    nazev      VARCHAR(30)
)

CREATE TABLE prijezd (
    stanice_id   INTEGER NOT NULL,
    spoj_id      INTEGER NOT NULL,
    cas          time,
    poradi       INTEGER,
    vzdalenost   INTEGER
)

CREATE TABLE spoj (
    spoj_id         INTEGER PRIMARY KEY IDENTITY,
    nazev           VARCHAR(10),
    cena_za_km      INTEGER,
    kapacita_mist   INTEGER,
    pravidelny      VARCHAR(10),
    spolecnost_id   INTEGER NOT NULL
)

CREATE TABLE spolecnost (
    spolecnost_id   INTEGER PRIMARY KEY IDENTITY,
    nazev           VARCHAR(20)
)

CREATE TABLE stanice (
    stanice_id   INTEGER PRIMARY KEY IDENTITY,
    nazev        VARCHAR(30),
    mesto_id     INTEGER NOT NULL
)

CREATE TABLE uzivatel (
    uzivatel_id         INTEGER PRIMARY KEY IDENTITY,
    login               VARCHAR(20),
    jmeno               VARCHAR(20),
    prijmeni            VARCHAR(20),
    email               VARCHAR(30),
    typ                 VARCHAR(10),
    posledni_navsteva   datetime
)

ALTER TABLE Historie_ceny
    ADD CONSTRAINT historie_ceny_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Jizda
    ADD CONSTRAINT jizda_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_jizda_fk FOREIGN KEY ( jizda_id )
        REFERENCES jizda ( jizda_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_stanice_fk FOREIGN KEY ( stanice_id_start )
        REFERENCES stanice ( stanice_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_stanice_fkv2 FOREIGN KEY ( stanice_id_cil )
        REFERENCES stanice ( stanice_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_uzivatel_fk FOREIGN KEY ( uzivatel_id )
        REFERENCES uzivatel ( uzivatel_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Prijezd
    ADD CONSTRAINT prijezd_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Prijezd
    ADD CONSTRAINT prijezd_stanice_fk FOREIGN KEY ( stanice_id )
        REFERENCES stanice ( stanice_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Spoj
    ADD CONSTRAINT spoj_spolecnost_fk FOREIGN KEY ( spolecnost_id )
        REFERENCES spolecnost ( spolecnost_id )
ON DELETE NO ACTION 
    ON UPDATE no action

ALTER TABLE Stanice
    ADD CONSTRAINT stanice_mesto_fk FOREIGN KEY ( mesto_id )
        REFERENCES mesto ( mesto_id )
ON DELETE NO ACTION 
    ON UPDATE no action



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             19
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0