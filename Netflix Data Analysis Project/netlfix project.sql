--Netflix_Data

--1 Count how many titles are available for each type
select type, count (title)
from titles
group by type

--q2 Find the average IMDb score of all 'MOVIE' titles
select avg(imdb_score)
from titles
where type='Movie'

--q3  List titles along with the total number of votes, sorted by most votes
select title, sum(IMdb_votes) as total_votes
from titles
group by title
order by total_votes desc

--4 Join titles and credits to list the first 10 title-character pairs
select t.title, c.character
from titles as t
join credits as c
on c.id=t.id

--5 How many titles does each genre appear in?
select genres, COUNT(title) as total_genres
from titles
group by genres 
order by total_genres desc

--6 Find titles released between 2000 and 2010 with an IMDb score above 7.
select title, imdb_score
from titles
where release_year between 2000 and 2010  and imdb_score >7 order by imdb_score asc


group by title, imdb_score 
having sum(imdb_score)>7

---7 Show the number of seasons for each title with more than 1 season

alter table titles
alter column seasons int

select title, sum(seasons) as no_of_seasons
from titles
group by title
having sum(seasons) >1
order by no_of_seasons desc

--8 Show top 5 most popular titles based on tmdb_popularity
select top (5) title, sum(tmdb_popularity) as popularity
from titles
group by title
order by popularity desc

--2.1 List the top 5 actors who played in the most titles
select top 5 c.name, count(t.title) as total_titles
from credits as c 
left join titles as t
on c.id=t.id
group by c.name
order by total_titles desc

select c.name, count(t.title) as total_titles
from credits as c 
left join titles as t
on c.id=t.id
group by c.name
order by total_titles desc

select c.name, count(t.title) as total_titles
from credits as c 
inner join titles as t
on c.id=t.id
group by c.name
order by total_titles desc

--2 List titles and the number of people credited in each.
select t.title, COUNT(person_id) as no_of_people
from  titles as t
left join credits as c
on c.id=t.id
group by t.title
order by no_of_people desc

--3 Find all titles with both an IMDb score above 7 and a TMDB score above 70
select title, imdb_score, tmdb_score
from titles
where imdb_score >7 and tmdb_score > 7
order by imdb_score desc , tmdb_score desc

--4 Which production countries have produced the most titles? 
select production_countries, COUNT(title) as total_titles
from titles
group by production_countries
order by total_titles desc

--5  Show the average runtime by title type
select title, type,avg(runtime) as avg_time
from titles
group by title , type


--6 List titles where the word “love” appears in the title.
select title
from titles
where title like '%love%' 

--7  Find top 5 directors by number of titles directed
select c.name, count(t.title) as total_titles
from credits as c
left join titles as t
on c.id=t.id
group by c.name
order by total_titles desc

--where c.character ='director'
select c.role,c.name, count(t.title) as total_titles
from credits as c
left join titles as t
on c.id=t.id
where c.role ='director'
group by c.role,c.name
order by total_titles desc
--inner join
select c.name, count(t.title) as total_titles
from credits as c
inner join titles as t
on c.id=t.id
group by c.name
order by total_titles desc

--8 Show the most recent title each person acted in.
select t.title, c.name, t.release_year
from titles as t
join credits as c 
on t.id = c.id
where t.release_year=2022
order by t.release_year desc

--3.1 Find titles with IMDb scores higher than the average IMDb score of all titles. 
select title, imdb_score
from titles
where imdb_score >(select avg(imdb_score) as avg_score
from titles )
order by imdb_score desc

--3.2  List the top 5 most common roles from the credits table using a CTE
with role_count as(select role,count(*) as role_count
from credits group by role)

select top 1 *
from role_count
order by role_count desc


--3.3 Find the top 3 longest movies by runtime using a subquery.
select title  , runtime 
from titles
where type ='movie' and runtime in (select (runtime)from titles)
order by runtime desc

--3.4	Show titles and their IMDb score ranks (1 = highest) using a CTE.
with ranks as (select title, ROW_NUMBER() over (order by imdb_score desc) as ranks
from titles)

select top 5 title, ranks
from ranks
where ranks=1


--3.5  List all people who acted in titles released in 2020.
select  t.title, c.name, t.release_year
from titles as t
left join credits as c
on t.id=c.id
where t.release_year =2020 and c.role ='actor'

--3.6 Get average IMDb score per type and show only types with average score > 7 using a CTE.
with type_avg as (select type, AVG(imdb_score) as avg_imdb_score
from titles
group by type
having avg(imdb_score) >6)

select type, avg_imdb_score
from type_avg

--3.7  Find titles that have more than 3 people credited.
select t.id, t.title, count(c.person_id) as person_count
from titles as t
join credits as c
on t.id=c.id
group by t.id, t.title
having count(c.person_id) >3

--using subquwey
select title , count(id) from titles
where id in (select id from credits group by id 
having count(name) >3)


--3.8 List each actor and the number of unique titles they appeared in using CTE.
with actor_titles as (select name, id from credits
where role='actor')

select name, count(distinct id) as unique_titles
from actor_titles 
group by name
order by unique_titles desc




