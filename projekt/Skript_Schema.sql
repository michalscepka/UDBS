CREATE TABLE historie_ceny (
    history_id   INTEGER PRIMARY KEY IDENTITY,
    cena         INTEGER NOT NULL,
    datum        datetime NOT NULL,
    spoj_id      INTEGER NOT NULL
)

GO

CREATE TABLE jizda (
    jizda_id   INTEGER PRIMARY KEY IDENTITY,
    datum      DATE NOT NULL,
    spoj_id    INTEGER NOT NULL
)

GO

CREATE TABLE jizdenka (
    jizdenka_id        INTEGER PRIMARY KEY IDENTITY,
    uzivatel_id        INTEGER NOT NULL,
    jizda_id           INTEGER NOT NULL,
    stanice_id_start   INTEGER NOT NULL,
    stanice_id_cil     INTEGER NOT NULL,
    cena               INTEGER NOT NULL
)

GO

CREATE TABLE mesto (
    mesto_id   INTEGER PRIMARY KEY IDENTITY,
    nazev      VARCHAR(30) NOT NULL
)

GO

CREATE TABLE prijezd (
    stanice_id   INTEGER NOT NULL,
    spoj_id      INTEGER NOT NULL,
    cas          time NOT NULL,
    poradi       INTEGER NOT NULL,
    vzdalenost   INTEGER NOT NULL
)

GO

CREATE TABLE spoj (
    spoj_id         INTEGER PRIMARY KEY IDENTITY,
    nazev           VARCHAR(20) NOT NULL,
    cena_za_km      INTEGER NOT NULL,
    kapacita_mist   INTEGER NOT NULL,
    pravidelny      bit NOT NULL,
    spolecnost_id   INTEGER NOT NULL
)

GO

CREATE TABLE spolecnost (
    spolecnost_id   INTEGER PRIMARY KEY IDENTITY,
    nazev           VARCHAR(20) NOT NULL
)

GO

CREATE TABLE stanice (
    stanice_id   INTEGER PRIMARY KEY IDENTITY,
    nazev        VARCHAR(30) NOT NULL,
    mesto_id     INTEGER NOT NULL
)

GO

CREATE TABLE uzivatel (
    uzivatel_id         INTEGER PRIMARY KEY IDENTITY,
    login               VARCHAR(20) NOT NULL,
    jmeno               VARCHAR(20) NOT NULL,
    prijmeni            VARCHAR(20) NOT NULL,
    email               VARCHAR(30) NOT NULL,
    typ                 VARCHAR(20) NOT NULL,
    posledni_navsteva   datetime
)

GO

ALTER TABLE Historie_ceny
    ADD CONSTRAINT historie_ceny_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Jizda
    ADD CONSTRAINT jizda_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_jizda_fk FOREIGN KEY ( jizda_id )
        REFERENCES jizda ( jizda_id )
ON DELETE NO ACTION 
    ON UPDATE no action

GO

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_stanice_fk FOREIGN KEY ( stanice_id_start )
        REFERENCES stanice ( stanice_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_stanice_fkv2 FOREIGN KEY ( stanice_id_cil )
        REFERENCES stanice ( stanice_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Jizdenka
    ADD CONSTRAINT jizdenka_uzivatel_fk FOREIGN KEY ( uzivatel_id )
        REFERENCES uzivatel ( uzivatel_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Prijezd
    ADD CONSTRAINT prijezd_spoj_fk FOREIGN KEY ( spoj_id )
        REFERENCES spoj ( spoj_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Prijezd
    ADD CONSTRAINT prijezd_stanice_fk FOREIGN KEY ( stanice_id )
        REFERENCES stanice ( stanice_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Spoj
    ADD CONSTRAINT spoj_spolecnost_fk FOREIGN KEY ( spolecnost_id )
        REFERENCES spolecnost ( spolecnost_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE Stanice
    ADD CONSTRAINT stanice_mesto_fk FOREIGN KEY ( mesto_id )
        REFERENCES mesto ( mesto_id )
ON DELETE NO ACTION 
    ON UPDATE no action
    
GO

ALTER TABLE uzivatel ADD CHECK (typ IN('spravce drah', 'vlakova spolecnost', 'zakaznik'));

ALTER TABLE prijezd ADD CHECK (vzdalenost >= 0);

ALTER TABLE spoj ADD CHECK (cena_za_km > 0);
