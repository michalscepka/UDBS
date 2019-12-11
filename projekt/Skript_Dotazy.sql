--Skupina 1

/*1;1;5;
Vypise celkovou utratu jednotlivych uzivatelu na jizdenkach*/
SELECT uzivatel_id, SUM(cena) AS celkem_utrata
FROM jizdenka
GROUP BY uzivatel_id
ORDER BY celkem_utrata DESC

/*1;2;3;
Vypise pocet spoju kazde spolecnosti*/
SELECT spolecnost_id, COUNT(spoj_id) AS pocet_spoju
FROM spoj
GROUP BY spolecnost_id
ORDER BY pocet_spoju ASC

/*1;3;5;
Vypise pocet jizd pro kazdy spoj*/
SELECT spoj_id, COUNT(jizda_id) AS pocet_jizd
FROM jizda
GROUP BY spoj_id

/*1;4;3;
Vypise prumernou cenu za kilometr pro kazdou spolecnost*/
SELECT spolecnost_id, AVG(CAST(cena_za_km AS FLOAT)) AS prumerna_cena_za_km
FROM spoj
GROUP BY spolecnost_id

--Skupina 2

/*2;1;2;
Vypise jizdy ktere se konaji 5.12.2019 nebo 6.12.2019 pro spoj s nazvem LE 400*/
SELECT j.jizda_id, datum, s.nazev AS spoj
FROM jizda j
	JOIN spoj s ON j.spoj_id = s.spoj_id
WHERE (j.datum = '2019-12-05' OR j.datum = '2019-12-06') AND s.nazev = 'LE 400'

/*2;2;9;
Vypise vsechny uzivatele, kteri maji zaznam v atributu posledni_navsteva*/
SELECT uzivatel_id, login, jmeno, prijmeni, email, posledni_navsteva
FROM uzivatel
WHERE posledni_navsteva IS NOT NULL

/*2;3;2;
Vypise vsechny uzivatele, kteri maji email na domene gmail nebo seznam a jmenuji se Martin*/
SELECT uzivatel_id, login, jmeno, prijmeni, email, posledni_navsteva
FROM uzivatel
WHERE (email LIKE '%gmail%' OR email LIKE '%seznam%') AND jmeno = 'Martin'

/*2;4;6;
Vypise vsechny jizdenky, ktere maji cenu nizsi nez 500 kc*/
SELECT jizdenka_id, uzivatel_id, jizda_id, stanice_id_start, stanice_id_cil, cena
FROM jizdenka
WHERE cena < 500

--Skupina 3

/*3;1;1;
Vypise jizdu na kterou neni rezervovana zadna jizdenka*/
SELECT jizda_id
FROM jizda
WHERE jizda_id NOT IN (
	SELECT jizda_id
	FROM jizdenka
)

/*3;2;1;
Vypise jizdu na kterou neni rezervovana zadna jizdenka*/
SELECT jizda_id
FROM jizda j1
WHERE NOT EXISTS (
	SELECT *
	FROM jizdenka r1
	WHERE j1.jizda_id = r1.jizda_id
)

/*3;3;1;
Vypise jizdu na kterou neni rezervovana zadna jizdenka*/
SELECT jizda_id
FROM jizda
WHERE jizda_id != ALL (
	SELECT jizda_id
	FROM jizdenka
)

/*3;4;1;
Vypise jizdu na kterou neni rezervovana zadna jizdenka*/
SELECT jizda_id
FROM jizda
EXCEPT (
	SELECT jizda_id
	FROM jizdenka
)

--Skupina 4

/*4;1;5;
Vypise pocet stanic na kazdem spoji*/
SELECT spoj_id, COUNT(stanice_id) AS pocet_stanic
FROM prijezd
GROUP BY spoj_id

/*4;2;3;
Vypise pocet uzivatelu pro kazdy typ*/
SELECT typ, COUNT(typ) AS pocet
FROM uzivatel
GROUP BY typ

/*4;3;5;
Vypise prumernou utratu vsech uzivatelu, kteri si koupili nekdy jizdenku*/
SELECT uzivatel_id, AVG(cena) AS prumerna_utrata
FROM jizdenka
GROUP BY uzivatel_id

/*4;4;3;
Vypise pocet stanic pro mesta, ktere maji vice nez jednu stanici*/
SELECT mesto_id, COUNT(stanice_id) AS pocet_stanic
FROM stanice
GROUP BY mesto_id
HAVING COUNT(stanice_id) > 1

--Skupina 5

/*5;1;5;
Vypise vsechny uzivatele, kteri maji objednanou nejakou jizdenku*/
SELECT DISTINCT u1.uzivatel_id, u1.login, u1.jmeno, u1.prijmeni, u1.email, u1.typ, u1.posledni_navsteva
FROM uzivatel u1
	JOIN jizdenka j1 ON u1.uzivatel_id = j1.uzivatel_id

/*5;2;5;
Vypise vsechny uzivatele, kteri maji objednanou nejakou jizdenku*/
SELECT DISTINCT u1.uzivatel_id, u1.login, u1.jmeno, u1.prijmeni, u1.email, u1.typ, u1.posledni_navsteva
FROM uzivatel u1
WHERE u1.uzivatel_id IN (
	SELECT j1.uzivatel_id
	FROM jizdenka j1
)

/*5;3;5;
Vypise vsechny uzivatele, kteri nemaji objednanou zadnou jizdenku*/
SELECT u1.uzivatel_id, u1.login, u1.jmeno, u1.prijmeni, u1.email, u1.typ, u1.posledni_navsteva
FROM uzivatel u1
	LEFT JOIN jizdenka j1 ON u1.uzivatel_id = j1.uzivatel_id
GROUP BY u1.uzivatel_id, u1.login, u1.jmeno, u1.prijmeni, u1.email, u1.typ, u1.posledni_navsteva
HAVING COUNT(j1.jizda_id) = 0

/*5;4;8;
Vypise vsechny stanice zacinajici na pismeno P a pocet jizdenek ve kterych jsou jako cilove stanice*/
SELECT s1.stanice_id, s1.nazev, s1.mesto_id, COUNT(j1.jizdenka_id) AS pocet_jizdenek
FROM stanice s1
	LEFT JOIN jizdenka j1 ON s1.stanice_id = j1.stanice_id_cil
WHERE s1.nazev LIKE 'P%'
GROUP BY s1.stanice_id, s1.nazev, s1.mesto_id

--Skupina 6

/*6;1;5;
Vypise vsechny spoje a pocet jejich jizd ve dnech 5.12., 6.12. a 7.12.*/
SELECT s.nazev, (
	SELECT COUNT(spoj_id)
	FROM jizda j
	WHERE DAY(datum) = 5 AND MONTH(datum) = 12 AND s.spoj_id = j.spoj_id
	) AS '5.12.', (
	SELECT COUNT(spoj_id)
	FROM jizda j
	WHERE DAY(datum) = 6 AND MONTH(datum) = 12 AND s.spoj_id = j.spoj_id
	) AS '6.12.', (
	SELECT COUNT(spoj_id)
	FROM jizda j
	WHERE DAY(datum) = 7 AND MONTH(datum) = 12 AND s.spoj_id = j.spoj_id
	) AS '7.12.'
FROM spoj s

/*6;1;5;
Vypise celkove vydelky spoju a pocet jejich jizd serazene vzestupne podle celkoveho vydelku*/
SELECT spoj.nazev, (
	SELECT SUM(jizdenka.cena)
	FROM jizda
		LEFT JOIN jizdenka ON jizda.jizda_id = jizdenka.jizda_id
	WHERE spoj.spoj_id = jizda.spoj_id
) AS vydelek_celkem, (
	SELECT COUNT(jizda.jizda_id)
	FROM jizda
	WHERE spoj.spoj_id = jizda.spoj_id
) AS pocet_jizd
FROM spoj
ORDER BY vydelek_celkem
