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
	home_team_score tinyint,
	away_team_score tinyint,
	home_team_points tinyint default 0,
	away_team_points tinyint default 0,
	game_date date,
	game_day tinyint,
	primary key (id)
);

create table football.scores
(
	id bigint not null auto_increment,
	game_id bigint not null references football.game(id),
	player_id bigint not null references football.player(id),
	season_id bigint not null references football.season(id),
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
		s.season_id,
		g.league_id
from football.scores as s
inner join football.game as g
on s.game_id = g.id
inner join football.player as p
on p.id = s.player_id
inner join football.team as t
on t.id = p.team_id
inner join football.team_league_season as tls
on t.id = tls.team_id and tls.season_id = s.season_id
group by g.season_id, tls.league_id, s.player_id;

create view football.rank_by_season as
select 	g.game_day, 
		t.id as team_id,
		sum(case when g.home_team_id=t.id then g.home_team_points else g.away_team_points end) as points,
		sum(case when g.home_team_id=t.id then g.home_team_score else g.away_team_score end) as goals_for,
		sum(case when g.away_team_id=t.id then (g.home_team_score) else (g.away_team_score) end) as goals_against,
		sum(case when g.home_team_id=t.id and g.home_team_points=3 then 1 else 0 end) as won,
		sum(case when g.home_team_id=t.id and g.home_team_points=1 then 1 else 0 end) as drawn,
		sum(case when (g.home_team_id=t.id and g.away_team_points=3) or (g.away_team_id=t.id and g.home_team_points=3) then 1 else 0 end) as lost,
		g.season_id, tls.league_id
from football.game as g
inner join football.team t
on t.id = g.away_team_id or t.id = g.home_team_id
inner join football.team_league_season as tls
on t.id = tls.team_id and tls.season_id = g.season_id
group by t.id, g.season_id, tls.league_id
order by points desc, goals_for desc;
