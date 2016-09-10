--release 1


--Nomor 1. cara cek jumlah politician_id 524 dari tabel voters
select count (*) from votes where politician_id ='524';
--isinya 22

--Nomor 2 join tabel votes dan congress_members tanpa id 524
SELECT * FROM votes a INNER JOIN congress_members b
on a.politician_id = b.id;
--isi 530

--nomor 3 representative Erik Paulsen
SELECT * FROM votes a INNER JOIN congress_members b
on a.politician_id = b.id;
where b.name like '%Erik Paulsen%';


--nomor 4
SELECT a.id, a.voter_id, a.politician_id, b.id, b.name, b.party, b.location, b.grade_1996, b.grade_current, b.years_in_congress, b.years_in_congress, b.dw1_score
from congress_members b
INNER JOIN votes a on b.id=a.id
order by b.dw1_score desc;
--
select * from votes
where id =''

-- Nomor 5 votes jumlah sedikit ke besar
SELECT a.id, a.voter_id, a.politician_id, b.id, b.name, b.party, b.location, b.grade_1996, b.grade_current, b.years_in_congress, b.years_in_congress, b.dw1_score
from congress_members b
INNER JOIN votes a on b.id=a.id
order by b.dw1_score ASC;


----===RELEASE 2
SELECT c.first_name, c.last_name, c.gender
from 
