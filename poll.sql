#Jawaban 1
select count (*) from votes where id = '524';

#jawaban 2
SELECT * FROM votes INNER JOIN congress_members
ON votes.politician_id = congress_members.id;

#jawaban 3
select count(*) from votes inner join congress_members on votes.politician_id = congress_members.id WHERE congress_members.name like '%Erik Paulsen%';

#jawaban 4

select congress_members.name ,votes.politician_id,count (votes.politician_id) as rank from congress_members inner join votes on votes.politician_id = congress_members.id group by votes.politician_id, congress_members.name order by rank desc;

#jawaban 5
select congress_members.name ,votes.politician_id,count (votes.politician_id) as rank from congress_members inner join votes on votes.politician_id = congress_members.id group by votes.politician_id, congress_members.name order by rank asc;

Release 2

#jawaban 1
select cm.name, count(v.id) as VOTESCOUNT from congress_members cm INNER JOIN votes v ON cm.id = v.politician_id group by cm.id order by VOTESCOUNT desc;

#jawaban 2

select cm.name, cm.location,cm.grade_current, count(v.id)
from congress_members cm inner join votes v on cm.id = v.politician_id
where cm.grade_current < 9 group by cm.name;

#jawaban 3
select cm.location, count(v.id) as ranks from congress_members cm, votes v, voters vs
where cm.id = v.politician_id and v.voter_id = vs.id
group by cm.location
order by ranks desc limit 10;NT

#jawaban 4
