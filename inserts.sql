-- ############# INSERT STAEMENTS #############

insert into football.nationality (name) values ('Germany'), ('Switzerland'), ('France'), ('Finland'), ('Sweden');

insert into football.country (name) values ('Germany'), ('Switzerland'), ('France'), ('Finland'), ('Sweden');

insert into football.city (name, country_id) values ('München', 1), ('Berlin', 1), ('Basel', 2), ('Paris', 3), ('Helsinki', 4), ('Gelsenkirchen', 1), ('Backnang', 1), ('Malmö', 5);

insert into football.league (name) values ('Bundesliga'), ('Ligue 1'), ('Veikkausliiga'), ('Raiffeisen Super League');

insert into football.team (name, short_name, arena_name, coach_name, city_id) values 
('FC Bayern München', 'FCB', 'Allianz Arena', 'Josep Guardiola', 1), 
('Herta BSC Berlin', 'Herta', 'Olympiastaion Berlin', 'Jos Luhukay', 2), 
('FC Basel 1893', 'FCB', 'St. Jakob-Park', 'Paulo Sousa', 3), 
('FC Paris Saint-Germain', 'PSG', 'Parc des Princes', 'Laurent Blanc', 4), 
('HJK Helsinki', 'HJK', 'Sonera Stadium', 'Mika Lehkosuo', 5);

insert into football.position (name) values ('Goalkeeper'), ('Centre Back'), ('Centre Forward'), ('Right Wing');

insert into football.player(firstname, lastname, date_of_birth, place_of_birth_id, nationality_id, position_id, team_id) values
('Manuel', 'Neuer', '1986-3-27', 6, 1, 1, 1),
('Julian', 'Schieber', '1989-2-13', 7, 1, 3, 2),
('Zlatan', 'Ibrahimovic', '1981-10-03', 8, 5, 3, 4);

insert into football.season (name) values ('2014/15');

insert into football.game (home_team_id, away_team_id, season_id, league_id, home_team_score, away_team_score, home_team_points, away_team_points, game_date, game_day) values 
(1, 2, 1, 1, 3, 1, 3, 0, '2014-11-30', 13);

insert into football.team_league_season (team_id, season_id, league_id) values (1,1,1), (2,1,1), (3,1,4);

insert into football.scores (game_id, player_id, season_id, minute) values
(1,1,1, 12), (1,2,1, 33), (1,1,1, 85), (1,1,1, 90);
