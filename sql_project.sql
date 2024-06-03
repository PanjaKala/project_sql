create database Spotify;

SELECT * 
FROM music 
LIMIT 100;

SELECT COUNT(*) 
FROM music 
WHERE 
track_name IS NULL OR `artist(s)_name` IS NULL OR streams IS NULL;

SELECT track_name,
LOWER(`artist(s)_name`) AS artists_name,
artist_count,
released_year,
released_month,
released_day,
in_spotify_playlists,
in_spotify_charts,
streams,
`key`,
`mode`,
`danceability_%` AS danceability
FROM music;

SELECT artists_name,COUNT(*) AS song_count
FROM music 
GROUP BY artists_name 
ORDER BY song_count DESC
LIMIT 1;

SELECT released_month,ROUND(AVG(streams),0) AS streams_avg
FROM music
WHERE released_year=2023
GROUP BY released_month
ORDER BY released_month;



SELECT 
CASE
WHEN danceability<=25 then '0-25%'
WHEN danceability<=50 then '26-50%'
WHEN danceability<=75 then '51-75%'
ELSE '75-100%'
END
AS danceability_group,
AVG(streams) AS streams_avg
FROM music
GROUP BY danceability_group
ORDER BY streams_avg;

WITH songcount AS
(SELECT COUNT(*) AS total,SUM( CASE WHEN released_year=2023 THEN 1 ELSE 0 END) AS 2023_released
FROM music)
SELECT (2023_released*100/total) AS RELEASED_IN_2023 FROM songcount;

SELECT `mode`,COUNT(*)
FROM music
WHERE released_year!=2023
GROUP BY `mode`;

SELECT `key`,COUNT(`key`) AS count_key
FROM music
GROUP BY `key`
ORDER BY count_key desc;