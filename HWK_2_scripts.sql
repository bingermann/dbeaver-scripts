create table musician (artist_name text, birthday date, 
					   birth_town text, country_of_origin text, 
					   albums_sold Integer, studio_albums Integer, 
					   live_albums Integer, gender text);
alter table musician add primary key (artist_name);
alter table musician alter column birthday set not null;

select * from musician;




insert into musician values ('David Gilmore', '3/6/1946', 'Cambridge', 'England', 230, 19, 5, 'Male');
insert into musician values ('Jimmy Page', '1/9/1944', 'Middlesex', 'England', 201, 14, 6, 'Male');
insert into musician values ('Beyonce', '9/4/1981', 'Houston, TX', 'USA', 121, 10, 4, 'Female');
insert into musician values ('Freddy Mercury', '9/5/1946', 'Stone Town', 'Zanzibar', 238, 15, 10, 'Male');
insert into musician values ('Neil Young', '11/12/1945', 'Toronto, Ontario', 'Canada', 101, 45, 9, 'Male');

select * from musician;




alter table musician add full_name varchar;

select * from musician;




update musician set full_name = 'David S. Gilmore' where artist_name like 'David Gilmore';
update musician set full_name = 'James Patrick Page' where artist_name like 'Jimmy Page';
update musician set full_name = 'Beyonce Giselle Knowles' where artist_name like 'Beyonce';
update musician set full_name = 'Farrokh Bulsara' where artist_name like 'Freddy Mercury';
update musician set full_name = 'Neil Percival Young' where artist_name like 'Neil Young';

select * from musician;




insert into musician values ('Jimmy Page', '1/9/1944', 'Middlesex', 'England', 201, 14, 6, 'Male');

select * from musician;




create table genre (genre text unique);

select * from genre;




insert into genre values ('Psychedelic Rock');
insert into genre values ('Blues');
insert into genre values ('Rock');
insert into genre values ('Folk');
insert into genre values ('Hard Rock');
insert into genre values ('R&B');
insert into genre values ('Pop');
insert into genre values ('Hip-Hop');
insert into genre values ('Country Rock');
insert into genre values ('Reggae');

select * from genre;




create table genrerel (musician_name text references musician(artist_name),
                       musician_genre text references genre(genre));

select * from genrerel;




insert into genrerel values ('David Gilmore', 'Psychedelic Rock'), ('David Gilmore', 'Blues'), ('David Gilmore', 'Rock');
insert into genrerel values ('Jimmy Page', 'Rock'), ('Jimmy Page', 'Blues'), ('Jimmy Page', 'Folk'), ('Jimmy Page', 'Hard Rock');
insert into genrerel values ('Beyonce', 'R&B'), ('Beyonce', 'Pop'), ('Beyonce', 'Hip-Hop');
insert into genrerel values ('Freddy Mercury', 'Rock');
insert into genrerel values ('Neil Young', 'Rock'), ('Neil Young', 'Folk'), ('Neil Young', 'Hard Rock'), ('Neil Young', 'Country Rock');

select * from genrerel;





insert into genrerel values ('Beyonce', 'Dance');




delete from musician where artist_name like 'David Gilmore';




select sum(musician.albums_sold)
from musician
join genrerel on musician.artist_name = genrerel.musician_name
join genre on genrerel.musician_genre = genre.genre
where genre.genre = 'Folk'
and (musician.country_of_origin = 'England'
	or musician.country_of_origin = 'Canada');


