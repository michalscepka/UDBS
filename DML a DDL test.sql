CREATE TABLE test.Town (
    town_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(30) NOT NULL
)

INSERT INTO test.Town(name)
SELECT town
FROM test.Employee
GROUP BY town

ALTER TABLE test.Employee ADD town_id INTEGER NULL;
ALTER TABLE test.Employee ADD FOREIGN KEY(town_id) REFERENCES test.Town(town_id)

UPDATE test.Employee SET town_id = (SELECT town_id FROM test.Town WHERE name = town)

ALTER TABLE test.Employee ALTER COLUMN town_id INTEGER NOT NULL;

--4.
ALTER TABLE test.Employee ADD CHECK (status IN (1, 2, 3));

DELETE FROM test.Complaint WHERE test.Complaint.nID IN (
    SELECT pu.nID
    FROM test.Purchase pu JOIN test.Product p ON pu.pID = p.PREDICATE
    WHERE p.trademark = 'Whirpool'
)

ALTER TABLE test.Purchase ADD cMax INT NULL;

UPDATE test.Purchase SET cMax = (
    SELECT MAX(price)
    FROM test.Complaint
    WHERE test.Purchase.nID = test.Complaint.nID
)
