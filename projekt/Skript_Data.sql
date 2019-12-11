
INSERT INTO mesto (nazev)
VALUES ('Bohumin'),
		('Ostrava'),
		('Studenka'),
		('Suchodol nad Odrou'),
		('Hranice na Morave'),
		('Prerov'),
		('Olomouc'),
		('Zabreh na Morave'),
		('Pardubice'),
		('Kolin'),
		('Praha'),
		('Plzen'),
		('Stribro'),
		('Plana'),
		('Ceska Trebova'),
		('Havirov');

SELECT * FROM mesto

INSERT INTO stanice (nazev, mesto_id)
VALUES ('Bohumin', 1),
		('Ostrava hl.n.', 2),
		('Ostrava-Svinov', 2),
		('Studenka', 3),
		('Suchodol n. Odrou', 4),
		('Hranice na Morave', 5),
		('Prerov', 6),
		('Olomouc hl.n.', 7),
		('Zabreh na Morave', 8),
		('Pardubice hl.n.', 9),
		('Kolin', 10),
		('Praha-Liben', 11),
		('Praha hl.n.', 11),
		('Praha-Smichov', 11),
		('Plzen hl.n.', 12),
		('Plzen-Jizni Predmesti', 12),
		('Stribro', 13),
		('Plana u Mar.Lazni', 14),
		('Ceska Trebova', 15),
		('Havirov', 16);

SELECT * FROM stanice

INSERT INTO spolecnost (nazev)
VALUES ('Ceske Drahy'),
		('RegioJet'),
		('LeoExpress');

SELECT * FROM spolecnost

INSERT INTO uzivatel (login, jmeno, prijmeni, email, typ, posledni_navsteva)
VALUES ('honza1', 'Jan', 'Novak', 'jannovak@gmail.com', 'zakaznik', '2019-12-3 12:30:50'),
		('janaN', 'Jana', 'Novakova', 'jananovakova@gmail.com', 'zakaznik', '2019-12-2 10:36:52'),
		('modrp', 'Petr', 'Modry', 'modrp@gmail.com', 'zakaznik', '2019-12-1 22:30:54'),
		('noobmaster', 'Thor', 'Odinson', 'noobmaster@gmail.com', 'zakaznik', '2019-11-30 23:23:50'),
		('StarLord', 'Martin', 'Maly', 'malymartin@gmail.com', 'zakaznik', '2019-11-29 11:30:40'),
		('kral', 'Marek', 'Novak', 'marnov@seznam.cz', 'spravce drah', '2019-12-3 05:30:50'),
		('Leo', 'Martin', 'Velky', 'leokral@seznam.cz', 'vlakova spolecnost', '2019-12-2 06:30:50'),
		('regio', 'Martina', 'Velka', 'regio@bing.com', 'vlakova spolecnost', '2019-12-4 08:35:59'),
		('cesd', 'Jakub', 'Motany', 'mot@gmail.com', 'vlakova spolecnost', '2019-12-5 12:30:58'),
		('pepa', 'Pepa', 'Jan', 'pepajan@gmail.com', 'zakaznik', NULL);

SELECT * FROM uzivatel

INSERT INTO spoj (nazev, cena_za_km, kapacita_mist, pravidelny, spolecnost_id)
VALUES ('LE 400', 3, 200, 1, 3),
		('RJ 106', 2, 150, 1, 2),
		('SC 512 Pendolino', 4, 170, 1, 1),
		('RJ 1006', 5, 100, 0, 2),
		('LE 401', 2, 180, 1, 3);

SELECT * FROM spoj

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (1, 1, '13:56', 1, 0),
		(2, 1, '14:04', 2, 8),
		(3, 1, '14:12', 3, 13),
		(4, 1, '14:21', 4, 30),
		(5, 1, '14:28', 5, 42),
		(6, 1, '14:40', 6, 63),
		(7, 1, '15:01', 7, 92),
		(8, 1, '15:17', 8, 114),
		(9, 1, '15:39', 9, 160),
		(10, 1, '16:29', 10, 260),
		(11, 1, '16:48', 11, 302),
		(12, 1, '17:16', 12, 359),
		(13, 1, '17:23', 13, 364);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (1, 2, '14:56', 1, 0),
		(2, 2, '15:04', 2, 8),
		(3, 2, '15:12', 3, 13),
		(4, 2, '15:21', 4, 30),
		(5, 2, '15:28', 5, 42),
		(6, 2, '15:40', 6, 63),
		(7, 2, '16:01', 7, 92),
		(8, 2, '16:17', 8, 114),
		(9, 2, '16:39', 9, 160),
		(10, 2, '17:29', 10, 260),
		(11, 2, '17:48', 11, 302),
		(12, 2, '18:16', 12, 359),
		(13, 2, '18:23', 13, 364);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (1, 3, '7:07', 1, 0),
		(2, 3, '7:15', 2, 8),
		(3, 3, '7:23', 3, 13),
		(8, 3, '8:14', 4, 114),
		(10, 3, '9:23', 5, 260),
		(12, 3, '10:12', 6, 359),
		(13, 3, '10:45', 7, 364),
		(14, 3, '10:53', 8, 368),
		(15, 3, '12:05', 9, 471),
		(16, 3, '12:08', 10, 472),
		(17, 3, '12:31', 11, 504),
		(18, 3, '12:52', 12, 535);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (13, 4, '13:47', 1, 0),
		(10, 4, '14:41', 2, 104),
		(19, 4, '15:16', 3, 164),
		(9, 4, '15:38', 4, 204),
		(8, 4, '16:02', 5, 250),
		(6, 4, '16:35', 6, 301),
		(3, 4, '17:02', 7, 351),
		(2, 4, '17:10', 8, 356),
		(20, 4, '17:29', 9, 374);

INSERT INTO prijezd (stanice_id, spoj_id, cas, poradi, vzdalenost)
VALUES (13, 5, '16:09', 1, 0),
		(12, 5, '16:16', 2, 5),
		(11, 5, '16:46', 3, 62),
		(10, 5, '17:05', 4, 104),
		(9, 5, '17:58', 5, 204),
		(8, 5, '18:20', 6, 250),
		(7, 5, '18:38', 7, 272),
		(6, 5, '18:57', 8, 301),
		(5, 5, '19:09', 9, 322),
		(4, 5, '19:16', 10, 334),
		(3, 5, '19:27', 11, 351),
		(2, 5, '19:35', 12, 356),
		(1, 5, '19:49', 13, 364);

SELECT * FROM prijezd

INSERT INTO jizda (datum, spoj_id)
VALUES ('20191205', 1),
		('20191205', 2),
		('20191205', 3),
		('20191205', 5),
		('20191206', 1),
		('20191206', 2),
		('20191206', 3),
		('20191206', 5),
		('20191207', 1),
		('20191207', 2),
		('20191207', 3),
		('20191207', 4),
		('20191207', 5);

SELECT * FROM jizda

INSERT INTO historie_ceny(cena, datum, spoj_id)
VALUES(10, '20191201', 1),
		(9, '20191201', 2),
		(5, '20191202', 3),
		(9, '20191203', 4),
		(5, '20191204', 5),
		(7, '20191202', 1),
		(1, '20191201', 2);

SELECT * FROM historie_ceny

INSERT INTO jizdenka (uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena)
VALUES (1, 1, 3, 13, (
	SELECT ((
		SELECT DISTINCT vzdalenost
		FROM stanice
			JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 1
		) - (
		SELECT DISTINCT vzdalenost
		FROM stanice
			JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
			JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE prijezd.stanice_id = 3 AND jizda.jizda_id = 1
		)) * (
		SELECT DISTINCT cena_za_km
		FROM spoj
			JOIN jizda ON spoj.spoj_id = jizda.spoj_id
		WHERE jizda.jizda_id = 1
		)
	)),
		(1, 1, 1, 13, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM prijezd
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 1
				) - (
				SELECT DISTINCT vzdalenost
				FROM prijezd
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 1 AND jizda.jizda_id = 1
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 1
				)
			)),
		(1, 2, 3, 13, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM prijezd
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 2
				) - (
				SELECT DISTINCT vzdalenost
				FROM prijezd
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 3 AND jizda.jizda_id = 2
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 2
				)
			)),
		(2, 1, 5, 11, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 11 AND jizda.jizda_id = 1
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 5 AND jizda.jizda_id = 1
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 1
				)
			)),
		(2, 4, 13, 6, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 6 AND jizda.jizda_id = 4
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 4
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 4
				)
			)),
		(3, 5, 2, 5, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 5 AND jizda.jizda_id = 5
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 2 AND jizda.jizda_id = 5
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 5
				)
			)),
		(3, 12, 13, 20, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 20 AND jizda.jizda_id = 12
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 12
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 12
				)
			)),
		(4, 7, 14, 17, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 17 AND jizda.jizda_id = 7
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 14 AND jizda.jizda_id = 7
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 7
				)
			)),
		(4, 9, 3, 6, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 6 AND jizda.jizda_id = 9
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 3 AND jizda.jizda_id = 9
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 9
				)
			)),
		(4, 13, 13, 6, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 6 AND jizda.jizda_id = 13
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 13
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 13
				)
			)),
		(5, 6, 4, 10, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 10 AND jizda.jizda_id = 6
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 4 AND jizda.jizda_id = 6
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 6
				)
			)),
		(5, 5, 2, 12, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 12 AND jizda.jizda_id = 5
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 2 AND jizda.jizda_id = 5
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 5
				)
			)),
		(5, 3, 10, 13, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 13 AND jizda.jizda_id = 3
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 10 AND jizda.jizda_id = 3
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 3
				)
			)),
		(5, 8, 10, 5, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 5 AND jizda.jizda_id = 8
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 10 AND jizda.jizda_id = 8
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 8
				)
			)),
		(5, 11, 12, 15, (
			SELECT ((
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 15 AND jizda.jizda_id = 11
				) - (
				SELECT DISTINCT vzdalenost
				FROM stanice
					JOIN prijezd ON stanice.stanice_id = prijezd.stanice_id
					JOIN spoj ON prijezd.spoj_id = spoj.spoj_id
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE prijezd.stanice_id = 12 AND jizda.jizda_id = 11
				)) * (
				SELECT DISTINCT cena_za_km
				FROM spoj
					JOIN jizda ON spoj.spoj_id = jizda.spoj_id
				WHERE jizda.jizda_id = 11
				)
			));

SELECT * FROM jizdenka
