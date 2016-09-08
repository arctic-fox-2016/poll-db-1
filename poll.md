# release 1
1.
select * from congress_members where id=524;
select count(id) from votes  where politician_id=524;

2.
select * from votes v join congress_members cm on v.politician_id = cm.id where not cm.id =524;

3.
select * from congress_members where name like '%Erik Paulsen%';
select count(id) from votes where politician_id = 339;

4.
select politician_id,count(id) as votes_count from votes group by politician_id order by votes_count desc limit 20;

select id,name,party,location,grade_1996,grade_current,years_in_congress,dw1_score from congress_members cm join (select politician_id,count(id) as votes_count from votes group by politician_id order by votes_count desc limit 20) as winner on cm.id = winner.politician_id;

5.
select politician_id,count(id) as votes_count from votes group by politician_id order by votes_count asc limit 20;

select id,name,party,location,grade_1996,grade_current,years_in_congress,dw1_score from congress_members cm join (select politician_id,count(id) as votes_count from votes group by politician_id order by votes_count asc limit 20) as winner on cm.id = winner.politician_id;

#release 2
1.
select v.id,v.first_name,v.last_name,v.gender,v.party,v.party_duration,v.age,v.married,v.children_count,v.homeowner,v.employed from voters as v, votes as vs where v.id=vs.voter_id and vs.politician_id = 224;

2.
select cm.id,cm.name,cm.location,cm.grade_current,count(vs.id) as vote_count from votes as vs, congress_members as cm where cm.id = vs.politician_id and  cm.grade_current < 9 group by cm.id;

3.
select distinct location from congress_members  cm join (select politician_id,count(id) as votes_count from votes group by politician_id order by votes_count desc limit 14) as winner on cm.id = winner.politician_id ;

select v.*  from voters v join votes vs join (select politician_id,count(id) as votes_count from votes group by politician_id order by votes_count desc limit 14) as winner on v.id = vs.voter_id and vs.politician_id = winner.politician_id;


4.
select * from voters as v join (select vs.voter_id,count(vs.id) as votes_count from votes as vs group by voter_id order by votes_count desc) as cheater on v.id = cheater.voter_id where cheater.votes_count > 2;

5.
select vs.voter_id, count(vs.politician_id) as votes_count from votes as vs group by voter_id order by votes_count desc;

select v.first_name,cm.name from voters as v join congress_members as cm join votes as vs join (select vs.voter_id, count(vs.politician_id) as votes_count from votes as vs group by voter_id order by votes_count asc) as cheater on v.id = vs.voter_id and vs.politician_id = cm.id and vs.voter_id = cheater.voter_id where cheater.votes_count > 2;
