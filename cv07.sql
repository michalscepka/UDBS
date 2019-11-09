-- 2. Vlozte do tabulky 'Spolecnost' tyto tri zaznamy:
INSERT INTO Spolecnost (nazev, mesto, ulice, PSC, zeme, telefon)
VALUES ('Czech airlines', 'Praha', 'Prazska 2', '12000', 'CR', '+420 234 789 111');
INSERT INTO Spolecnost (nazev, mesto, ulice, PSC, zeme, telefon)
VALUES ('Delta', 'Detroit', 'Elm street 55', '15122', 'USA', '+100 900 987 000');
INSERT INTO Spolecnost (nazev, mesto, ulice, PSC, zeme, telefon)
VALUES ('Emirates', 'Dubai', 'Arabic 34', '98000', 'Emirates', '+456 111 123 321');

SELECT * FROM Spolecnost

-- 3. Vlozte do tabulky 'Letadlo' tyto tri zaznamy:
INSERT INTO Letadlo (cislo_letadla, typ_letadla, pocet_mist, pocet_motoru, dolet, rok_vyroby, cislo_spolecnosti)
VALUES (1, 'B737', 100, 4, 20000, 2000, 1);
INSERT INTO Letadlo (cislo_letadla, typ_letadla, pocet_mist, pocet_motoru, dolet, rok_vyroby, cislo_spolecnosti)
VALUES (2, 'A777', 200, 6, 30000, 2008, 1);
INSERT INTO Letadlo (cislo_letadla, typ_letadla, pocet_mist, pocet_motoru, dolet, rok_vyroby, cislo_spolecnosti)
VALUES (3, 'B747', 400, 8, 25000, 2002, 3);

SELECT * FROM Letadlo

-- 4. Pridejte pomoci SQL prikazu do tabulky 'Spolecnost' novy atribut 'vlastnik'
-- typu retezec o velikosti 30, ktery nemusi byt vyplnen.
ALTER TABLE Spolecnost ADD vlastnik VARCHAR(30) NULL;

-- 5. Pridejte pomoci SQL prikazu do tabulky 'Letadlo' novy atribut 'posledni oprava'
-- typu datum, ktery musi byt vyplnen. Vlozte do tabulky libovolne datum,
-- ktere je vyssi nez rok vyroby daneho letadla. 
ALTER TABLE Letadlo ADD posledni_oprava DATE NULL;

UPDATE Letadlo SET posledni_oprava = '2010-02-05' WHERE cislo_letadla = 1;
UPDATE Letadlo SET posledni_oprava = '2013-05-01' WHERE cislo_letadla = 2;
UPDATE Letadlo SET posledni_oprava = '2005-11-27' WHERE cislo_letadla = 3;

ALTER TABLE Letadlo ALTER COLUMN posledni_oprava DATE NOT NULL;

-- 6. Pro atribut 'vzdalenost' tabulky 'Trasa' definujte IO, kde hodnota musi byt mezi 50 a 20000.
ALTER TABLE Trasa ADD CHECK (vzdalenost BETWEEN 50 AND 20000);

-- 7. Prejmenujte atribut 'zeme' na 'stat'.
EXEC sp_RENAME 'Spolecnost.zeme' , 'stat'

-- 8. Vytvorte tabulku 'Pilot', ktera bude uchovavat informace o pilotech, jmenovite 
-- jejich id (generovany klic), jmeno, prijmeni, pohlavi a pocet naletanych hodin.
CREATE TABLE Pilot (
	id INT PRIMARY KEY IDENTITY,
	jmeno VARCHAR(30) NOT NULL,
	prijmeni VARCHAR(30) NOT NULL,
	pohlavi CHAR(1) NOT NULL,
	pocet_hodin INT NOT NULL
);

SELECT * FROM Pilot

-- 9. Definujte IO pro atribut uchovavajici pocet naletanych hodin, aby uchovane
-- hodnoty musely byt vetsi nez 100
ALTER TABLE Pilot ADD CHECK (pocet_hodin > 100);

-- 10. Definujte IO pro atribut uchovavajici pohlavi pilota, aby uchovane hodnoty
-- musely byt jenom 'M' nebo 'Z'.
ALTER TABLE Pilot ADD CHECK (pohlavi IN ('M', 'Z'));

-- 11. Do tabulky Pilot vlozte tri zaznamy o pilotech.
INSERT INTO Pilot (jmeno, prijmeni, pohlavi, pocet_hodin)
VALUES ('Teemo', 'Motak', 'M', 101);
INSERT INTO Pilot (jmeno, prijmeni, pohlavi, pocet_hodin)
VALUES ('Carl', 'Johnson', 'M', 999);
INSERT INTO Pilot (jmeno, prijmeni, pohlavi, pocet_hodin)
VALUES ('Michael', 'De Santa', 'M', 500);

-- 12. Pridejte do tabulky 'Letovy_plan' atribut 'id_pilota', ktery bude referencovat
-- do tabulky 'Pilot' a vytvorte dva letove plany.
ALTER TABLE Letovy_plan ADD pilot_id INTEGER NULL;

ALTER TABLE Letovy_plan ADD FOREIGN KEY(pilot_id) REFERENCES Pilot(id)

INSERT INTO Trasa(START, cil, vzdalenost, mezipristani, pocet_pasazeru)
VALUES ('Praha', 'Londyn', 600, 0, 100);
INSERT INTO Trasa(START, cil, vzdalenost, mezipristani, pocet_pasazeru)
VALUES ('Londyn', 'New York', 5567, 0, 150);

UPDATE Trasa SET vzdalenost = 1200 WHERE cislo_trasy = 1;

INSERT INTO Letovy_plan(Letadlo_cislo_letadla, Trasa_cislo_trasy, pilot_id)
VALUES (1, 1, 1);
INSERT INTO Letovy_plan(Letadlo_cislo_letadla, Trasa_cislo_trasy, pilot_id)
VALUES (2, 2, 3);

SELECT * FROM Pilot
SELECT * FROM Trasa
SELECT * FROM Letovy_plan

-- 13. Vytvorte tabulku 'Letiste', ktera bude uchovavat informace o letistich,
-- jmenovite jejich kodove oznaceni, mesto a stat, kde se nachazi.
CREATE TABLE Letiste (
	kod VARCHAR(15) PRIMARY KEY,
	mesto VARCHAR(20) NOT NULL,
	stat VARCHAR(20) NOT NULL
)

SELECT * FROM Letiste

-- 14. Upravte tabulku 'Trasa' tak, ze atributy 'start a 'cil' budou cizi klice do tabulky 'Letiste'.
INSERT INTO Letiste (kod, mesto, stat)
VALUES ('001', 'Ostrava', 'CR')
INSERT INTO Letiste (kod, mesto, stat)
VALUES ('002', 'Praha', 'CR')
INSERT INTO Letiste (kod, mesto, stat)
VALUES ('003', 'Londyn', 'GB')
INSERT INTO Letiste (kod, mesto, stat)
VALUES ('004', 'New York', 'USA')

EXEC sp_rename 'Trasa.START', '_start';
EXEC sp_rename 'Trasa.cil', '_cil';

ALTER TABLE Trasa ADD start VARCHAR(15) NULL;
ALTER TABLE Trasa ADD cil VARCHAR(15) NULL;

ALTER TABLE Trasa ADD FOREIGN KEY (start) REFERENCES Letiste(kod);
ALTER TABLE Trasa ADD FOREIGN KEY (cil) REFERENCES Letiste(kod);

UPDATE Trasa
SET 
	start = (SELECT kod FROM Letiste WHERE mesto = _start),
	cil = (SELECT kod FROM Letiste WHERE mesto = _cil);

ALTER TABLE Trasa DROP COLUMN _start;
ALTER TABLE Trasa DROP COLUMN _cil;

ALTER TABLE TRASA ALTER COLUMN start VARCHAR(15) NOT NULL;
ALTER TABLE TRASA ALTER COLUMN cil VARCHAR(15) NOT NULL;

SELECT * FROM Trasa

-- smazani tabulky
DROP TABLE dbo.Letiste;
