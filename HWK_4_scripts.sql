create table musicians (stage_name text primary key,
						full_name text,
						birth_date date,
						nationality text);

create table bands (band_name text primary key,
					origin_city text,
					form_date date,
					disband_date date NULL);

create table songs (title text,
					release_date date,
					band_name text,
					length interval,
					primary key (title, release_date, band_name),
					foreign key (band_name) references bands(band_name));

create table albums (title text,
					 band_name text,
					 release_date date,
					 primary key (title, band_name),
					 foreign key (band_name) references bands(band_name));

create table genres (genre text primary key);

create table bandrel (stage_name text,
					  band_name text,
					  join_date date,
					  role text,
					  primary key (stage_name, band_name, join_date, role),
					  foreign key (stage_name) references musicians(stage_name),
					  foreign key (band_name) references bands(band_name));

create table songrel (stage_name text,
					  title text,
					  release_date date,
					  band_name text,
					  role text,
					  primary key (stage_name, title, release_date, band_name, role),
					  foreign key (stage_name) references musicians(stage_name),
					  foreign key (title, release_date, band_name) references songs(title, release_date, band_name));

create table albumrel (album_title text,
					   album_band_name text,
					   song_title text,
					   song_release_date date,
					   song_band_name text,
					   primary key (album_title, album_band_name, song_title, song_release_date, song_band_name),
					   foreign key (album_title, album_band_name) references albums(title, band_name),
					   foreign key (song_title, song_release_date, song_band_name) references songs(title, release_date, band_name));

create table bandgenrerel (band_name text,
						   genre_name text,
						   primary key (band_name, genre_name),
						   foreign key (band_name) references bands(band_name),
						   foreign key (genre_name) references Genres(genre));

create table musiciangenrerel (stage_name text,
							   genre_name text,
							   primary key (stage_name, genre_name),
							   foreign key (stage_name) references musicians(stage_name),
							   foreign key (genre_name) references Genres(genre));

create table songgenrerel (title text,
						   release_date date,
						   band_name text,
						   genre_name text,
						   primary key (title, release_date, band_name, genre_name),
						   foreign key (title, release_date, band_name) references songs(title, release_date, band_name),
						   foreign key (genre_name) references Genres(genre));

create table albumgenrerel (title text,
							band_name text,
							genre_name text,
							primary key (title, band_name, genre_name),
							foreign key (title, band_name) references albums(title, band_name),
							foreign key (genre_name) references Genres(genre));