#3. Conceptual Model

##3.1. ER Model Diagram

[ER Model Diagram of the Football database]
![alt text](https://raw.githubusercontent.com/milkysunshine91/sport_db.Football/master/ER.png "ER Diagram")

##3.2. Arguments for the specifications

We've chosen to create a table for each entity, which makes the database better scalable for future changes.
We’ve specified the _scores_ table to have a reference on _player_ and _team_, because if we would have only the player reference in the _scores_, we could still follow up which team scores, but since we support the use case, that a player can change the team, the player would take his scores to the new team. Therefore the _scores_ table has a reference to the _team_ and the _player_.
We have the mapping table _teams_league_season_, so we can follow up which team was at which time in which season. So we support the storing of multiple football seasons.

##3.3. Mapping to RDBMS (MySQL database)

The following files are included and can be used to create the schema and then insert some sample records into the database:
+ [Create schema SQL File](https://raw.githubusercontent.com/milkysunshine91/sport_db.Football/master/create_football.sql)
+ [Insert sample records SQL File](https://raw.githubusercontent.com/milkysunshine91/sport_db.Football/master/inserts.sql)

##3.3. Proof

The following SQL file demonstrate the DML command used to query the database:
[Proof of DML command](https://raw.githubusercontent.com/milkysunshine91/sport_db.Football/master/select_queries.sql)

##3.5. Discussion

Our first solution stored some redundant data, which where twice in the datbase. We could optimize this, by setting the refernces better and creating the _views_ which accumulate e.g. the scores for a team on a matchday.
