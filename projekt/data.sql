
INSERT INTO mesto (nazev)
VALUES ('Bohumin');
INSERT INTO mesto (nazev)
VALUES ('Ostrava');
INSERT INTO mesto (nazev)
VALUES ('Studenka');
INSERT INTO mesto (nazev)
VALUES ('Suchodol nad Odrou');
INSERT INTO mesto (nazev)
VALUES ('Hranice na Morave');
INSERT INTO mesto (nazev)
VALUES ('Prerov');
INSERT INTO mesto (nazev)
VALUES ('Olomouc');
INSERT INTO mesto (nazev)
VALUES ('Zabreh na Morave');
INSERT INTO mesto (nazev)
VALUES ('Pardubice');
INSERT INTO mesto (nazev)
VALUES ('Kolin');
INSERT INTO mesto (nazev)
VALUES ('Praha');

SELECT * FROM mesto

INSERT INTO stanice (nazev, mesto_id)
VALUES ('Bohumin', 1);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Ostrava hl.n.', 2);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Ostrava-Svinov', 2);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Studenka', 3);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Suchodol n. Odrou', 4);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Hranice na Morave', 5);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Prerov', 6);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Olomouc hl.n.', 7);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Zabreh na Morave', 8);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Pardubice hl.n.', 9);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Kolin', 10);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Praha-Liben', 11);
INSERT INTO stanice (nazev, mesto_id)
VALUES ('Praha hl.n.', 11);

SELECT * FROM stanice

INSERT INTO spolecnost (nazev)
VALUES ('Ceske Drahy');
INSERT INTO spolecnost (nazev)
VALUES ('RegioJet');
INSERT INTO spolecnost (nazev)
VALUES ('LeoExpress');

SELECT * FROM spolecnost

INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ)
VALUES ('honza1', 'Jan', 'Novak', 'jan@gmail.com', 'zakaznik');

SELECT * FROM uzivatel

INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id)
VALUES ('LE400', 3, 200, 'pravidelny', 3)
INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id)
VALUES ('RJ106', 2, 150, 'pravidelny', 2)

SELECT * FROM spoj

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (1, 1, '13:56', 1, 0)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (2, 1, '14:04', 2, 8)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (3, 1, '14:12', 3, 13)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (4, 1, '14:21', 4, 30)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (5, 1, '14:28', 5, 42)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (6, 1, '14:40', 6, 63)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (7, 1, '15:01', 7, 92)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (8, 1, '15:17', 8, 114)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (9, 1, '15:39', 9, 160)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (10, 1, '16:29', 10, 260)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (11, 1, '16:48', 11, 302)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (12, 1, '17:16', 12, 359)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (13, 1, '17:23', 13, 364)

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (1, 2, '13:56', 1, 0)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (2, 2, '14:04', 2, 8)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (3, 2, '14:12', 3, 13)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (4, 2, '14:21', 4, 30)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (5, 2, '14:28', 5, 42)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (6, 2, '14:40', 6, 63)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (7, 2, '15:01', 7, 92)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (8, 2, '15:17', 8, 114)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (9, 2, '15:39', 9, 160)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (10, 2, '16:29', 10, 260)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (11, 2, '16:48', 11, 302)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (12, 2, '17:16', 12, 359)
INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (13, 2, '17:23', 13, 364)

SELECT * FROM prijezd

INSERT INTO jizda (datum, spoj_id)
VALUES ('20191129', 1)
INSERT INTO jizda (datum, spoj_id)
VALUES ('20191129', 2)

SELECT * FROM jizda

INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena)
VALUES (1, 1, 3, 13, (
	SELECT ((
		SELECT vzdalenost
		FROM stanice
			JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 1
		) - (
		SELECT vzdalenost
		FROM stanice
			JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 3 AND jizda.jizda_id = 1
		)) * (
		SELECT cena_za_km
		FROM spoj
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE jizda.jizda_id = 1
		)
	)
)
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena)
VALUES (1, 1, 1, 13, (
	SELECT ((
		SELECT vzdalenost
		FROM prijezd
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 1
		) - (
		SELECT vzdalenost
		FROM prijezd
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 1 AND jizda.jizda_id = 1
		)) * (
		SELECT cena_za_km
		FROM spoj
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE jizda.jizda_id = 1
		)
	)
)
INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena)
VALUES (1, 2, 3, 13, (
	SELECT ((
		SELECT vzdalenost
		FROM prijezd
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 2
		) - (
		SELECT vzdalenost
		FROM prijezd
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 3 AND jizda.jizda_id = 2
		)) * (
		SELECT cena_za_km
		FROM spoj
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE jizda.jizda_id = 2
		)
	)
)

SELECT * FROM jizdenka


/*UPDATE jizdenka
SET cena = (
	((
	SELECT vzdalenost
	FROM jizdenka
		JOIN stanice ON jizdenka.stanice_id_cil = stanice.stanice_id
		JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
	WHERE prijezd.stanice_id = jizdenka.stanice_id_cil AND jizdenka.jizdenka_id = 1 AND spoj_id = 1
	) - (
	SELECT vzdalenost
	FROM jizdenka
		JOIN stanice ON jizdenka.stanice_id_start = stanice.stanice_id
		JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
	WHERE prijezd.stanice_id = jizdenka.stanice_id_start AND jizdenka.jizdenka_id = 1 AND spoj_id = 1
	)) * (
	SELECT cena_za_km
	FROM jizdenka
		JOIN jizda ON jizdenka.jizda_id = jizda.jizda_id
		JOIN spoj ON jizda.spoj_id = spoj.spoj_id
	WHERE jizdenka.jizdenka_id = 1 AND spoj.spoj_id = 1
	)
)
WHERE jizdenka_id = 1

SELECT * FROM jizdenka*/
