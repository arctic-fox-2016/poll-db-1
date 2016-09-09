-- RELEASE 0 --
CREATE TABLE congress_members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(64) NOT NULL,
  party VARCHAR(64) NOT NULL,
  location VARCHAR(64) NOT NULL,
  grade_1996 REAL,
  grade_current REAL,
  years_in_congress INTEGER,
  dw1_score REAL
, created_at DATETIME, updated_at DATETIME);
CREATE TABLE voters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    gender VARCHAR(64) NOT NULL,
    party VARCHAR(64) NOT NULL,
    party_duration INTEGER,
    age INTEGER,
    married INTEGER,
    children_count INTEGER,
    homeowner INTEGER,
    employed INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );
CREATE TABLE votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    voter_id INTEGER,
    politician_id INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY(voter_id) REFERENCES voters(id),
    FOREIGN KEY(politician_id) REFERENCES congress_members(id)
  );

-- RELEASE 1 --
-- QUESTION #1
SELECT COUNT(*)
FROM congress_members a
INNER JOIN votes b
ON a.id = b.politician_id AND a.id = '524';

-- QUESTION #2
SELECT COUNT(*)
FROM congress_members a
INNER JOIN votes b
ON a.id = b.politician_id;

-- QUESTION #3
SELECT COUNT(*)
FROM congress_members a
INNER JOIN votes b
ON a.id = b.politician_id AND a.name = 'Erik Paulsen';

-- QUESTION #4
SELECT a.id, a.name, a.party, a.location, a.grade_1996, a.grade_current, a.years_in_congress, a.dw1_score, COUNT(*) as votes_count
FROM congress_members a
INNER JOIN votes b
ON a.id = b.politician_id
GROUP BY a.id
ORDER BY votes_count DESC
LIMIT 1;

-- QUESTION #5
SELECT a.id, a.name, a.party, a.location, a.grade_1996, a.grade_current, a.years_in_congress, a.dw1_score, COUNT(b.id) as votes_count
FROM congress_members a
INNER JOIN votes b
ON a.id = b.politician_id
GROUP BY a.id
HAVING votes_count >= 2
ORDER BY votes_count ASC;

-- RELEASE 2 --
-- QUESTION #1
SELECT a.name, COUNT(b.id) as votes_count
FROM congress_members a
INNER JOIN votes b
ON a.id = b.politician_id
GROUP BY a.id
ORDER BY votes_count DESC;

-- QUESTION #2
SELECT a.name, a.location, a.grade_current, count(b.id)
FROM congress_members a
INNER JOIN votes b
ON a.id = b.politician_id
WHERE a.grade_current < 9
GROUP BY a.id;

-- QUESTION #3
SELECT a.location, count(b.id) as votes_count
FROM congress_members a, votes b, voters c
WHERE a.id = b.politician_id AND b.voter_id = c.id
GROUP BY a.location
ORDER BY votes_count DESC
LIMIT 10;

-- QUESTION #4
SELECT c.first_name || ' ' || c.last_name, count(b.id) as votes_count
FROM congress_members a, votes b, voters c
WHERE a.id = b.politician_id AND b.voter_id = c.id
GROUP BY b.voter_id
HAVING votes_count > 2;

-- QUESTION #5
SELECT c.first_name || ' ' || c.last_name, a.name
FROM congress_members a, votes b, voters c
WHERE a.id = b.politician_id AND b.voter_id = c.id
GROUP BY b.voter_id
HAVING count(b.id) > 2 and count(b.politician_id) > 2
ORDER BY b.politician_id ASC;
