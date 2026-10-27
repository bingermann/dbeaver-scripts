-- 1. What are the number of different skills that are 
-- held by members of each team?
-- (teams, number of skills held by members of each team)
-- number of skills held in each team

select t.name, count(distinct s.skill)
from team t
join teamrel tr on tr.team_id = t.team_id 
join agent a on a.agent_id = tr.agent_id 
join skillrel sr on sr.agent_id = a.agent_id 
join skill s on s.skill_id = sr.skill_id 
group by t.name
order by t.name;


-- 2. For each language, list the number of different
-- teams whose members know that language.

select l.language, count(distinct t.team_id)
from language l
join languagerel lr on l.lang_id = lr.lang_id 
join agent a on lr.agent_id = a.agent_id 
join teamrel tr on a.agent_id = tr.agent_id 
join team t on tr.team_id = t.team_id 
group by l.language
order by l.language;


------ SUBQUERIES ------

-- 3. list the name of the mission with the lowest mission_id

select m.mission_id, m.name
from mission m
where m.mission_id = 
				(select min(mission_id)
				from mission);


-- 4. List the agents (agent_id, first, last) who have been on 
-- a 'Presidential' mission that succeeded.

select agent_id, first, last
from agent
where agent_id in (
				select tr.agent_id
				from teamrel tr
				join mission m on tr.team_id = m.team_id
				join securityclearance sc on m.access_id = sc.sc_id
				where sc.sc_level = 'Presidential'
				and m.mission_status = 'success');


-- 5. List the number of agents and min and max salary 
-- for agents in each country with 5 or more cities.

select country, count(agent_id), min(salary), max(salary)
from agent
where country in (
				select country 
				from agent
				group by country 
				having count(distinct city) >= 5)
group by country;


-- 6. List the agents (id, first, last) who are on an ongoing
-- 'Majestic' mission. Write this query two ways, once using 
-- EXISTS and once using IN

select a.agent_id, a.first, a.last
from agent a
where exists (
			select 1
			from teamrel tr
			join mission m ON tr.team_id = m.team_id
			join securityclearance sc on m.access_id = sc.sc_id 
			where sc.sc_level = 'Majestic'
			and a.agent_id = tr.agent_id);

select a.agent_id, a.first, a.last
from agent a
where a.agent_id in (
					select tr.agent_id
					from teamrel tr
					join mission m ON tr.team_id = m.team_id
					join securityclearance sc on m.access_id = sc.sc_id 
					where sc.sc_level = 'Majestic');


-- 7. Locate the skill(s) held by the most agents and for those
-- skills, output the number of agents with that skill. (The
-- result table should include skills, which are held by most
-- agents, and the number of agents with those skills.)

select s.skill, count(sr.agent_id) as count
from skill s
join skillrel sr on s.skill_id = sr.skill_id
group by s.skill_id, s.skill
order by count desc;

select s.skill, count(s)
from skill s join skillrel sr
on sr.skill_id = s.skill_id
group by s.skill
having count(s) =  (
	select count(*) as c
	from skill s1 join skillrel sr1
	on sr1.skill_id = s1.skill_id
	group by s1.skill
	order by c desc
	limit 1
);


-- Views --

-- Write an SQL view definition that displays agent 
-- names(first, last), the affiliation they belong 
-- to  and the description of the affiliation(s). 
-- Show your view definition and the first 5 rows 
-- returned when you SELECT * from the view with a 
-- screenshot of the result. 

create view AgentView as
select a.first, a.last, af.title, af.description
from agent a join affiliationrel ar on a.agent_id = ar.agent_id
join affiliation af on af.aff_id = ar.aff_id;
select * from AgentView;


-- Write an SQL view definition that displays a unique 
-- mission (name), the team(name) that performed this 
-- mission and the text of the missions security 
-- clearance level (access id) and description. Show 
-- your view definition and the first 5 rows returned 
-- when you SELECT * from the view with a screenshot of 
-- the result. 

create view MissionView as
select m.name, t.name as teamName, sc.sc_level, sc.description
from team t join mission m on t.team_id = m.team_id
join securityclearance sc on m.access_id = sc.sc_id;
select * from MissionView;
