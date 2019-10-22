--------------------------------------------------------------------------------------------
-- 1.A
-- Vypište produkty, které byly vždy reklamovány muži, kteří je koupili.
-- Jinými slovy, vypište produkty, které, když koupil muž, tak je i reklamoval.
-- Nevypisujte produkty, které nikdy muž nekoupil.
-- NEFUNGUJE

SELECT DISTINCT p.pID, p.serialNr
FROM test.Customer c
JOIN test.Purchase pu1 on c.cID = pu1.cID
JOIN test.Product p ON pu1.pID = p.pID
WHERE c.gender = 'muz' AND NOT EXISTS
(
	SELECT *
	FROM test.Purchase pu2
	JOIN test.Customer z ON pu2.cID = z.cID
	WHERE z.gender = 'muz' AND pu2.pID = p.pID AND not exists
	(
		SELECT *
		FROM test.Complaint co
		where pu2.nID = co.nID
	)
)

-- 1.B
-- Vypište produkty, které byly vždy reklamovány ženami, které je koupily.
-- Jinými slovy, vypište produkty, které, když koupila žena, tak je i reklamovala.
-- Nevypisujte produkty, které nikdy žena nekoupila.
-- NEFUNGUJE

SELECT DISTINCT p.pID, p.serialNr
FROM test.Customer c
JOIN test.Purchase pu1 on c.cID = pu1.cID
JOIN test.Product p ON pu1.pID = p.pID
WHERE c.gender = 'zena' AND NOT EXISTS
(
	SELECT *
	FROM test.Purchase pu2
	JOIN test.Customer z ON pu2.cID = z.cID
	WHERE z.gender = 'zena' AND pu2.pID = p.pID AND not exists
	(
		SELECT *
		FROM test.Complaint co
		where pu2.nID = co.nID
	)
)

-- 2.A
-- Pro každého zákazníka vypište počet jeho nákupů, kde byla cena pod průměrnou cenou daného produktu.

SELECT cu.cID, cu.name, COUNT(pu1.pID) AS pocet_nakupu
FROM test.Customer cu
	LEFT JOIN test.Purchase pu1 ON pu1.cID = cu.cID
	AND pu1.price > (
		SELECT AVG(price)
		FROM test.Purchase pu2
		WHERE pu1.pID = pu2.pID
	)
GROUP BY cu.cID, cu.name

-- 2.B
-- Pro každý produkt vypište počet jeho nákupů u kterých byla cena pod průměrnou cenou daného produktu.

SELECT pr1.pID, pr1.serialNr, COUNT(pu1.pID) AS pocet_nakupu
FROM test.Product pr1
	LEFT JOIN test.Purchase pu1 ON pr1.pID = pu1.pID
	AND pu1.price < (
		SELECT AVG(pu2.price)
		FROM test.Purchase pu2
		WHERE pu2.pID = pu2.pID
	)
GROUP BY pr1.pID, pr1.serialNr

-- 3.A
-- Vypiste jmeno nejvice nakupujiciho zakaznika zenskeho pohlavi. 
-- Jinymi slovy jde nam o zenu, ktera ma mezi zenami nejvyssi celkovy pocet nakoupenych kusu zbozi.

SELECT c.cID, c.gender, SUM(pu1.pieces)
FROM test.Customer c
	JOIN test.Purchase pu1 ON c.cID = pu1.cID
WHERE c.gender = 'zena'
GROUP BY c.cID, c.gender
HAVING SUM(pu1.pieces) >= ALL (
	SELECT SUM(pu2.pieces)
	FROM test.Customer c2
		JOIN test.Purchase pu2 ON c2.cID = pu2.cID
	WHERE c2.gender = 'zena'
	GROUP BY c2.cID
)

-- 3.B
-- Vypiste jmeno nejvice nakupujiciho zakaznika, ktery si nechava zasilat reklamu. 
-- Jinymi slovy jde nam o zakaznika, ktery ma nejvyssi celkovy pocet nakoupenych
-- kusu zbozi mezi zakazniky, kteri si nechavaji zasilat reklamu.

SELECT c1.cID, c1.name, SUM(pu1.pieces)
FROM test.Customer c1
	JOIN test.Purchase pu1 ON c1.cID = pu1.cID
WHERE c1.sendNews = 1
GROUP BY c1.cID, c1.name
HAVING SUM(pu1.pieces) >= ALL (
	SELECT SUM(pu2.pieces)
	FROM test.Customer c2
		JOIN test.Purchase pu2 ON c2.cID = pu2.cID
	WHERE c2.sendNews = 1
	GROUP BY c2.cID
)
--------------------------------------------------------------------------------------------
-- 1.A
-- U každého zákazníka, který má alespoň jeden nákup, vypište kolik reklamací má průměrně na jeden nákup. 
-- Pro korektní zobrazení výsledku je potřeba počty nákupů před počítáním průměru přetypovat na float s pomocí CAST(count(*) as FLOAT).
-- Vypište (cID, jmeno, průměr)
-- NEVIM

SELECT zID, jmeno, avg(reklamaci)
FROM
(
	SELECT n.nID, n.zID, z.jmeno, cast(count(r.nID) as float) reklamaci
	FROM test.Nakup n
	JOIN test.Zakaznik z on n.zID = z.zID
	left JOIN test.Reklamace r on n.nID = r.nID
	group by n.nID, n.zID, z.jmeno
) zak_rekl
group by zID, jmeno
order by zID

-- 1.B
-- U každého produktu vypište kolik reklamací má průměrně na jeden nákup. Setřiďte podle pID.
-- Pro korektní zobrazení výsledku je potřeba počty nákupů přetypovat s pomocí CAST(hodnota as FLOAT).
-- Vypište (pID, oznaceni, průměr)
-- NEVIM

SELECT pID, oznaceni, avg(reklamaci)
FROM
(
	SELECT n.nID, n.pID, p.oznaceni, cast(count(r.nID) as float) reklamaci
	FROM test.Nakup n
	JOIN test.Produkt p on n.pID = p.pID
	left JOIN test.Reklamace r on n.nID = r.nID
	group by n.nID, n.pID, p.oznaceni
) zak_rekl
group by pID, oznaceni
order by pID

-- 2.A
-- Vypište cID a jméno zákazníků, kteří nakoupili největší počet kusů jednoho zboží.

SELECT DISTINCT c.cID, c.name, SUM(pu1.pieces) AS pocet
FROM test.Customer c
	JOIN test.Purchase pu1 ON c.cID = pu1.cID
GROUP BY c.cID, c.name, pu1.pID				--pu1.pID protoze nas zajimaji konkretni zbozi
HAVING SUM(pu1.pieces) >= ALL (
	SELECT SUM(pu2.pieces)
	FROM test.Purchase pu2
		JOIN test.Customer c2 ON pu2.cID = c2.cID
	GROUP BY pu2.pID, c2.cID
)

-- 2.B
-- Vypište pID a označení produktů, které byly koupeny jedním zákazníkem v nejvíce kusech

SELECT p1.pID, p1.serialNr, SUM(pu1.pieces)
FROM test.Purchase pu1
	JOIN test.Product p1 ON pu1.pID = p1.pID
GROUP BY p1.pID, p1.serialNr, pu1.cID
HAVING SUM(pu1.pieces) >= ALL (
	SELECT SUM(pu2.pieces)
	FROM test.Purchase pu2
		JOIN test.Product p2 ON pu2.pID = p2.pID
	GROUP BY pu2.cID, p2.pID
)

-- 3.A
-- Vypište měsíce ve kterých nikdy nebyl prodán výrobek značky 'Whirpool'.
-- Množinu všech měsíců je možné získat s pomocí funkce month(test.nakup.den) a tabulky test.nakup.

SELECT DISTINCT MONTH(pu1.purchaseDay) mesic
FROM test.Purchase pu1
EXCEPT
SELECT DISTINCT MONTH(pu2.purchaseDay) mesic
FROM test.Purchase pu2
	JOIN test.Product p1 ON pu2.pID = p1.pID
WHERE p1.trademark = 'Whirpool'

-- 3.B
-- Vypište měsíce ve kterých nikdy nebyl prodán výrobek značky 'Green line'.
-- Množinu všech měsíců je možné získat s pomocí funkce month(test.nakup.den) a tabulky test.nakup.

SELECT DISTINCT MONTH(pu1.purchaseDay) AS mesic
FROM test.Purchase pu1
EXCEPT
SELECT DISTINCT MONTH(pu2.purchaseDay) AS mesic
FROM test.Purchase pu2
	JOIN test.Product p1 ON pu2.pID = p1.pID
WHERE p1.trademark = 'Green line'

--------------------------------------------------------------------------------------------
-- 1.A 
-- Vypište všechny produkty, které nebyly v žádném roce koupeny dvakrát.

SELECT *
FROM test.Product p1
WHERE 2 != ALL (
	SELECT COUNT(*)
	FROM test.Purchase pu1
	WHERE p1.pID = pu1.pID
	GROUP BY YEAR(pu1.purchaseDay)
)

SELECT *
FROM test.Product p1
WHERE NOT EXISTS (
	SELECT COUNT(*)
	FROM test.Purchase pu1
	WHERE p1.pID = pu1.pID
	GROUP BY YEAR(pu1.purchaseDay)
	HAVING COUNT(*) = 2
)

SELECT *
FROM test.Product p1
WHERE p1.pID NOT IN (
	SELECT pu1.pID
	FROM test.Purchase pu1
	WHERE pu1.pID = p1.pID
	GROUP BY YEAR(pu1.purchaseDay), pu1.pID
	HAVING COUNT(*) = 2
)

-- 1.B
-- Vypište všechny zákazníky, kteří v žádném roce neprovedli dva nákupy.

SELECT *
FROM test.Customer c1
WHERE 2 != ALL (
	SELECT COUNT(*)
	FROM test.Purchase p1
	WHERE c1.cID = p1.cID
	GROUP BY YEAR(p1.purchaseDay)
)

SELECT *
FROM test.Customer c1
WHERE NOT EXISTS (
	SELECT COUNT(*)
	FROM test.Purchase p1
	WHERE c1.cID = p1.cID
	GROUP BY YEAR(p1.purchaseDay)
	HAVING COUNT(*) = 2
)

SELECT *
FROM test.Customer c1
WHERE c1.cID NOT IN (
	SELECT p1.cID
	FROM test.Purchase p1
	WHERE p1.cID = c1.cID
	GROUP BY p1.cID, YEAR(p1.purchaseDay)
	HAVING COUNT(*) = 2
)

-- 2.A
-- Vypište všechny produkty, které byly reklamovány za cenu vyšší než dva tisíce korun maximálně jednou.
-- Vypište pID, označení a počet reklamací.
-- Eliminujte produkty, které nebyly nikdy koupeny

SELECT p1.pID, p1.serialNr, COUNT(c1.price)
FROM test.Product p1
	JOIN test.Purchase pu1 ON p1.pID = pu1.pID
	JOIN test.Complaint c1 ON pu1.nID = c1.nID AND c1.price > 2000
GROUP BY p1.pID, p1.serialNr
HAVING COUNT(c1.price) < 2

-- 2.B
-- Vypište všechny produkty, které u niž délka reklamace přesáhla 10 dní maximálně jednou. Vypište pID, označení a počet reklamací.
-- Eliminujte produkty, které nebyly nikdy koupeny

SELECT  p1.pID, p1.trademark, COUNT(c1.nID) AS pocet_reklamaci
FROM test.Product p1
	JOIN test.Purchase pu1 ON p1.pID = pu1.pID
	LEFT JOIN test.Complaint c1 ON pu1.nID = c1.nID
WHERE c1.durationInDays > 10
GROUP BY p1.pID, p1.trademark
HAVING COUNT(c1.nID) < 2

-- 3.A
-- U každého zákazníka vypište: (1) kolik různých produktů reklamoval, (2) v kolika různých letech nakupoval zboží.
-- Pro druhou hodnotu použijte funkci YEAR(test.Nakup.den), která vrátí rok nákupu.

SELECT c.cID, c.name, (
	SELECT COUNT(DISTINCT p.pID)
	FROM test.Purchase p
		JOIN test.Complaint co1 ON p.nID = co1.nID
	WHERE p.cID = c.cID
), (
	SELECT COUNT(DISTINCT YEAR(p.purchaseDay))
	FROM test.Purchase p
	WHERE p.cID = c.cID
)
FROM test.Customer c

-- 3.B
-- U každého produktu vypište: (1) kolik různých zákazníků jej reklamovalo, (2) v kolika různých letech bylo toto zboží nakoupeno. 
-- Pro druhou hodnotu použijte funkci YEAR(test.Nakup.den), která vrátí rok nákupu.

SELECT p.pID, p.serialNr, (
	SELECT COUNT(DISTINCT pu1.cID)
	FROM test.Purchase pu1
		JOIN test.Complaint c1 ON pu1.nID = c1.nID
	WHERE p.pID = pu1.pID
), (
	SELECT COUNT(DISTINCT YEAR(pu1.purchaseDay))
	FROM test.Purchase pu1
	WHERE p.pID = pu1.pID
)
FROM test.Product p

--------------------------------------------------------------------------------------------
-- 1.A 
-- Vypište produkty (pID, oznaceni, znacka), které v roce 2014 kupovali výhradně muži, nebo výhradně ženy.

SELECT DISTINCT pu1.pID, pr1.serialNr, pr1.trademark, 'pouze muzi'
FROM test.Purchase pu1
	JOIN test.Customer c1 ON c1.cID = pu1.cID
	JOIN test.Product pr1 ON pu1.pid = pr1.pID
WHERE c1.gender = 'muz' AND YEAR(pu1.purchaseDay) = 2014 AND NOT EXISTS (
	SELECT *
	FROM test.Purchase pu2
		JOIN test.Customer c2 on pu2.cID = c2.cID AND YEAR(pu2.purchaseDay) = 2014
	WHERE pu2.pid = pu1.pID AND c2.gender = 'zena'
)
UNION
SELECT DISTINCT pu1.pID, pr1.serialNr, pr1.trademark, 'pouze zeny'
FROM test.Purchase pu1
	JOIN test.Customer c1 ON c1.cID = pu1.cID
	JOIN test.Product pr1 ON pu1.pid = pr1.pID
WHERE c1.gender = 'zena' AND YEAR(pu1.purchaseDay) = 2014 AND NOT EXISTS (
	SELECT *
	FROM test.Purchase pu2
		JOIN test.Customer c2 on pu2.cID = c2.cID AND YEAR(pu2.purchaseDay) = 2014
	WHERE pu2.pid = pu1.pID AND c2.gender = 'muz'
)
--nebo
SELECT p1.pID, p1.serialNr, p1.trademark
FROM test.Product p1
	JOIN test.Purchase pu1 ON pu1.pID = p1.pID
	JOIN test.Customer c1 ON pu1.cID = c1.cID
WHERE YEAR(pu1.purchaseDay) = 2014
GROUP BY p1.pID, p1.serialNr, p1.trademark
HAVING COUNT(DISTINCT c1.gender) = 1

-- 1.B 
-- Vypište produkty, které za cenu nizší než 1000,- kupovali výhradně muži, nebo výhradně ženy

SELECT DISTINCT p1.pID, p.serialNr, p.trademark, 'pouze muzi'
FROM test.Purchase p1
	JOIN test.Customer c1 on c1.cID = p1.cID
	JOIN test.Product p on p1.pid = p.pID
WHERE c1.gender = 'muz' AND p1.price < 1000 AND NOT EXISTS (
	SELECT *
	FROM test.Purchase n
		JOIN test.Customer z on n.cID = z.cID AND n.price < 1000
	WHERE n.pid = p1.pID AND z.gender = 'zena'
)
UNION
SELECT DISTINCT p1.pID, p.serialNr, p.trademark, 'pouze zeny'
FROM test.Purchase p1
	JOIN test.Customer c1 on c1.cID = p1.cID
	JOIN test.Product p on p1.pid = p.pID
WHERE c1.gender = 'zena' AND p1.price < 1000 AND NOT EXISTS (
	SELECT *
	FROM test.Purchase n
		JOIN test.Customer z on n.cID = z.cID AND n.price < 1000
	WHERE n.pid = p1.pID AND z.gender = 'muz'
)


SELECT p1.pID, p1.serialNr, p1.trademark
FROM
	test.Product p1
		JOIN test.Purchase pu1 ON p1.pID = pu1.pID
		JOIN test.Customer c ON pu1.cID = c.cID
WHERE pu1.price < 1000
GROUP BY p1.pID, p1.serialNr, p1.trademark
HAVING COUNT(DISTINCT c.gender) = 1

-- 2.A
-- Vypište produkty, které pokud byly reklamovány, tak pouze zákazníky registrovanými v roce 2006
-- Z výsledku odstraňte produkty, které nikdy nebyly koupeny.

SELECT DISTINCT p.pID, p.serialNr
FROM test.Product p
	JOIN test.Purchase pu1 ON p.pID = pu1.pID
WHERE NOT EXISTS (
	SELECT *
	FROM test.Purchase pu1
		JOIN test.Complaint co1 ON pu1.nID = co1.nID
		JOIN test.Customer c ON pu1.cID = c.cID
	WHERE
		pu1.pID = p.pID AND
		(c.registrationYear != 2006 OR c.registrationYear IS NULL)
)

SELECT DISTINCT p.pID, p.serialNr
FROM test.Product p
	JOIN test.Purchase pu1 ON p.pID = pu1.pID
WHERE NOT EXISTS (
	SELECT *
	FROM test.Purchase pu1
		JOIN test.Complaint co1 ON pu1.nID = co1.nID
		JOIN test.Customer c ON pu1.cID = c.cID AND 
			(c.registrationYear != 2006 OR c.registrationYear IS NULL)
	WHERE pu1.pID = p.pID
)

-- 2.B
-- Vypište produkty, které pokud byly reklamovány, tak pouze zákazníky, kteří si přejí zasílat reklamu

SELECT DISTINCT p.pID, p.serialNr
FROM test.Product p
	JOIN test.Purchase pu1 ON p.pID = pu1.pID
WHERE NOT EXISTS (
	SELECT *
	FROM test.Purchase pu1
		JOIN test.Complaint co1 ON pu1.nID = co1.nID
		JOIN test.Customer c ON pu1.cID = c.cID AND
			(c.sendNews = 0 OR c.sendNews IS NULL)
	WHERE pu1.pID = p.pID 
)

--SELECT DISTINCT p.pID, p.serialNr
--FROM test.Product p
--	JOIN test.Purchase pu1 ON p.pID = pu1.pID
--WHERE NOT EXISTS (
--	SELECT *
--	FROM test.Purchase pu1
--		JOIN test.Complaint co1 ON pu1.nID = co1.nID
--		JOIN test.Customer c ON pu1.cID = c.cID
--	WHERE
--		pu1.pID = p.pID AND
--		(c.sendNews = 0 OR c.sendNews IS NULL)
--)

-- 3.A
-- Pro každý produkt, který nemá uveden rok výroby 2012 vypište:
-- (1) kolikrát byl reklamován za cenu vyšší než 1000 Kč,
-- (2) kolik různých zákazníků jej kupovalo v roce 2012.

SELECT p1.pID, p1.serialNr, (
	SELECT COUNT(*)
	FROM test.Purchase pu1
		JOIN test.Complaint co1 ON pu1.nID = co1.nID
	WHERE
		pu1.pID = p1.pID AND
		co1.price > 1000
) AS pocet_reklamaci, (
	SELECT COUNT(DISTINCT pu1.cID)
	FROM test.Purchase pu1
	WHERE
		p1.pID = pu1.pID AND
		YEAR(pu1.purchaseDay) = 2012
) AS pocet_zakazniku
FROM test.Product p1
WHERE p1.lastProductionYear != 2012 OR p1.lastProductionYear IS NULL

-- 3.B
-- Pro každý produkt, který nemá uveden rok výroby 2010 vypište:
-- (1) kolikrát byl reklamován za cenu nižší než 1000 Kč,
-- (2) kolik různých zákazníků jej kupovalo v roce 2012.

SELECT p1.pID, p1.serialNr, (
	SELECT COUNT(*)
	FROM test.Purchase pu1
		JOIN test.Complaint co1 ON pu1.nID = co1.nID
	WHERE
		pu1.pID = p1.pID AND
		co1.price < 1000
) AS pocet_reklamaci, (
	SELECT COUNT(DISTINCT pu1.cID)
	FROM test.Purchase pu1
	WHERE
		p1.pID = pu1.pID AND
		YEAR(pu1.purchaseDay) = 2012
) AS pocet_zakazniku
FROM test.Product p1
WHERE p1.lastProductionYear != 2010 OR p1.lastProductionYear IS NULL

--------------------------------------------------------------------------------------------
-- 1.A Slozitejsi
-- A. Vypište zákazníky, kteří vždy reklamovali výrobek značky 'Whirpool', který koupili.
-- Nevypisujte zakazniky, kteri nikdy vyrobek znacky whirpool nekoupili
-- NEFUNGUJE
SELECT DISTINCT c.cID, c.name
FROM test.Customer c
join test.Purchase pu1 on c.cID = pu1.cID
JOIN test.Product p ON pu1.pID = p.pID
WHERE p.trademark = 'Whirpool' AND NOT EXISTS (
	SELECT *
	FROM test.Purchase pu2
	JOIN test.Product p ON pu2.pID = p.pID	
	WHERE
		p.trademark = 'Whirpool' AND
		pu2.cID = c.cID AND NOT EXISTS (
			select *
			from test.Complaint co
			where pu2.nID = co.nID
		)
)

-- 1.B Vypište zákazníky, kteří vždy reklamovali výrobek, který koupili v roce 2013.
-- Nevypisujte zakazniky, kteri v roce 2013 nic nekoupili.
-- NEFUNGUJE

SELECT distinct z.zID, jmeno
FROM test.Zakaznik z
join test.Nakup n1 on z.zID = n1.zID and year(n1.den) = 2013
WHERE NOT EXISTS
(
	SELECT *
	FROM test.Nakup n 
	WHERE Year(n.den) = 2013 AND n.zID = z.zID and not exists
	(
		select *
		from test.Reklamace r 
		where n.nID = r.nID
	)
)

-- 2.A Jednodussi
-- Vypište zákazníky, kteří vícekrát reklamovali výrobek značky 'Whirpool' než 'Green line'.

SELECT c.cID, c.name
FROM test.Customer c
WHERE (
	SELECT COUNT(*)
	FROM test.Purchase pu1
		JOIN test.Complaint co ON pu1.nID = co.nID
		JOIN test.Product p1 ON pu1.pID = p1.pID
	WHERE
		pu1.cID = c.cID AND
		p1.trademark = 'Whirpool'
) > (
	SELECT COUNT(*)
	FROM test.Purchase pu1
		JOIN test.Complaint co ON pu1.nID = co.nID
		JOIN test.Product p1 ON pu1.pID = p1.pID
	WHERE
		pu1.cID = c.cID AND
		p1.trademark = 'Green line'
)

-- 2.B Vypiste zakazniky, kteri v roce 2013 vzdy kupovali vyrobek, ktery ma rok ukonceni vyroby 2012.
-- Nevypisujte zakazniky, kteri v roce 2013 nic nekoupili. Pouzijte funkci YEAR pro ziskani roku z atributu Nakup.den.
--NEFUNGUJE

SELECT DISTINCT c.cID, c.name
FROM test.Customer c
	JOIN test.Purchase pu ON c.cID = pu.cID AND YEAR(pu.purchaseDay) = 2013
WHERE NOT EXISTS (
	SELECT *
	FROM test.Purchase pu
		JOIN test.Product pr ON pu.pID = pr.pID
	WHERE 
		(pr.lastProductionYear != 2012 OR pr.lastProductionYear IS NULL) AND
		YEAR(pu.purchaseDay) = 2013 AND
		pu.cID = c.cID
)

--SELECT distinct z.zID, z.jmeno
--FROM test.Zakaznik z
--join test.Nakup n on z.zID = n.zID and year(n.den) = 2013
--WHERE NOT EXISTS
--(
--	SELECT *
--	FROM test.Nakup n1
--	JOIN test.Produkt p ON n1.pID = p.pID
--	WHERE (p.rok_ukonceni_vyroby != 2012 or p.rok_ukonceni_vyroby is null) AND 
--		year(n1.den) = 2013  and n1.zID = z.zID
--)

-- 3.A Jednodussi
-- Vypište zákazníky (jejich ID a jméno), kteří provedli nákup do deseti let od své registrace. Nevypisujte zákazníky, kde rok registrace není uveden.
-- Pro zjištění roku nákupu můžete použít funkci DATEPART.

SELECT c.cID, c.name
FROM test.Customer c
WHERE c.registrationYear IS NOT NULL AND EXISTS (
	SELECT *
	FROM test.Purchase pu
	WHERE
		pu.cID = c.cID AND
		DATEPART(YEAR, pu.purchaseDay) <= c.registrationYear + 10
)

-- 3.B Vypište zákazníky (jejich ID a jméno), kteří do deseti let od své registrace neprovedli ani jeden nákup. Nevypisujte zákazníky, kde rok registrace není uveden.
-- Pro zjištění roku nákupu můžete použít funkci DATEPART.

SELECT c.cID, c.name
FROM test.Customer c
WHERE c.registrationYear IS NOT NULL AND NOT EXISTS (
	SELECT *
	FROM test.Purchase pu
	WHERE
		pu.cID = c.cID AND
		DATEPART(YEAR, pu.purchaseDay) <= c.registrationYear + 10
)
