--1
SELECT COUNT(*) FROM votes WHERE politician_id = '524';

--2
SELECT * FROM votes v INNER JOIN congress_members c ON v.politician_id = c.id;

--3
SELECT COUNT (*) FROM votes v INNER JOIN congress_members c ON v.politician_id = c.id WHERE c.name like '%Erik Paulsen%';
SELECT COUNT(*) FROM votes WHERE politician_id = '339';

--4
SELECT A1.POLITICIAN_ID
     , A2.NAME
     , COUNT(A1.POLITICIAN_ID) AS RANK
FROM VOTES A1 INNER JOIN CONGRESS_MEMBERS A2
    ON A1.POLITICIAN_ID = A2.ID
GROUP BY A1.POLITICIAN_ID, A2.NAME
ORDER BY RANK DESC;

--5
SELECT A1.POLITICIAN_ID
     , A2.NAME
     , COUNT(A1.POLITICIAN_ID) AS RANK
FROM VOTES A1 INNER JOIN CONGRESS_MEMBERS A2
    ON A1.POLITICIAN_ID = A2.ID
GROUP BY A1.POLITICIAN_ID, A2.NAME
ORDER BY RANK ASC;

--RELEASE 2
--1.
