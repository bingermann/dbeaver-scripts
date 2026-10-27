create table Musicians (stage_name text primary key,
						full_name text,
						birth_date date,
						nationality text);

create table Bands (band_name text primary key,
					origin_city text,
					form_date date,
					disband_date date NULL);

create table Songs (title text,
					release_date date,
					band_name text,
					length interval,
					primary key (title, release_date, band_name),
					foreign key (band_name) references Bands(band_name));

create table Albums (title text,
					 band_name text,
					 release_date date,
					 primary key (title, band_name),
					 foreign key (band_name) references Bands(band_name));