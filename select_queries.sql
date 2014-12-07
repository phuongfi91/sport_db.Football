select 
sfg.season_id,
sfg.league_id,
t.id,
t.name,
sum(case when sfg.home_team_id=t.id then sfg.home_team_score else (case when sfg.away_team_id = t.id then sfg.away_team_score end) end) as goals_for, 
sum(case when sfg.home_team_id=t.id then sfg.away_team_score else (case when sfg.away_team_id = t.id then sfg.home_team_score end) end) as goals_against
from football.scores_for_game as sfg
inner join football.team as t
on t.id=sfg.home_team_id or sfg.away_team_id
inner join football.team_league_season as tls
on t.id=tls.team_id and tls.league_id=sfg.league_id and tls.season_id=sfg.season_id
group by t.id, sfg.league_id, sfg.season_id;


select 
sr.season_id,
sr.scored_goals,
sr.league_id,
p.firstname,
p.lastname,
t.name as team

from football.scorerrank as sr
inner join football.player as p
on p.id = sr.player_id
inner join football.team as t
on t.id = p.team_id;