create schema football;

create table football.nationality
(
	id bigint not null auto_increment,
	name varchar(255) not null,
	primary key (id)
);

create table football.country
(
	id bigint not null auto_increment,
	name varchar(255) not null,
	primary key (id)
);

create table football.city
(
	id bigint not null auto_increment,
	name varchar(255) not null,
	country_id bigint,
	primary key (id),
	foreign key (country_id) references football.country(id)
);

create table football.position
(
	id bigint not null auto_increment,
	name varchar(255) not null,
	primary key (id)
);

create table football.league
(
	id bigint not null auto_increment,
	name varchar(255) not null,
	primary key (id)
);


create table football.team
(
	id bigint not null auto_increment,
	name varchar(255) not null,
	short_name varchar(255) not null,
	arena_name varchar(255) not null,
	coach_name varchar(255) not null,
	city_id bigint,
	league_id bigint,
	primary key (id),
	foreign key (city_id) references football.city(id)
);

create table football.player
(
	id bigint not null auto_increment,
	firstname varchar(255) not null,
	lastname varchar(255) not null,
	date_of_birth date,
	place_of_birth_id bigint,
	nationality_id bigint,
	team_id bigint,
	position_id bigint,
	primary key (id),
	foreign key (place_of_birth_id) references football.city(id),
	foreign key (nationality_id) references football.nationality(id),
	foreign key (team_id) references football.team(id),
	foreign key (position_id) references football.position(id)
);

create table football.season
(
	id bigint not null auto_increment,
	name varchar(255) not null,
	primary key (id)
);

create table football.game
(
	id bigint not null auto_increment,
	home_team_id bigint not null references football.team(id),
	away_team_id bigint not null references football.team(id),
	season_id bigint not null references football.season(id),
	league_id bigint not null references football.league(id),
	game_date date,
	game_day tinyint,
	primary key (id)
);

create table football.scores
(
	id bigint not null auto_increment,
	game_id bigint not null references football.game(id),
	player_id bigint not null references football.player(id),
	team_id bigint not null references football.team(id),
	own_goal tinyint default 0,
	minute tinyint,
	primary key (id)
);

create table football.team_league_season
(
	id bigint not null auto_increment,
	team_id bigint not null references football.team(id),
	league_id bigint not null references football.league(id),
	season_id bigint not null references football.season(id),
	primary key (id)
);


-- ######################## VIEWS ########################

create view football.scorerrank as
select 	s.player_id, 
		sum(case when s.own_goal=0 then 1 else 0 end) as scored_goals,
		g.season_id,
		g.league_id
from football.scores as s
inner join football.game as g
on s.game_id = g.id
group by s.player_id, g.season_id
order by scored_goals desc;

create view football.scores_for_game as
select 	
        g.id as game_id,
        g.season_id,
        g.league_id,
        g.home_team_id,
        g.away_team_id,
        sum(case when g.home_team_id=s.team_id then 1 else 0 end) as home_team_score,
        sum(case when g.away_team_id = s.team_id then 1 else 0 end) as away_team_score
from football.game as g
inner join football.scores s
on s.game_id = g.id
group by g.id;