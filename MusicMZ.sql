CREATE TABLE MusicPerfomer
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
) AS NODE;

CREATE TABLE Ganre
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
) AS NODE;

CREATE TABLE MusicPlace
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
) AS NODE;

CREATE TABLE MusicLabel
(
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL
) AS NODE;

INSERT INTO MusicPerfomer (id, name)
VALUES (1, N'Travis Scott'),
       (2, N'Tyler, The Creator'),
	   (3, N'Enigma'),
	   (4, N'AC/DC'),
	   (5, N'The Rolling Stones'),
	   (6, N'The Beatles'),
	   (7, N'Daft Punk'),
	   (8, N'Kendrick Lamar'),
	   (9, N'The Weeknd'),
	   (10, N'Pharell Williams');

INSERT INTO Ganre (id, name)
VALUES (1, N'Rap'),
	   (2, N'Rock'),
	   (3, N'Hip-Hop'),
	   (4, N'Electronics'),
	   (5, N'Pop');

INSERT INTO MusicPlace (id, name)
VALUES (1, N'SoundCloud'),
	   (2, N'Spotify'),
	   (3, N'YouTube Music'),
	   (4, N'Apple Music'),
	   (5, N'Amazon Music'),
	   (6, N'Deezer'),
	   (7, N'Napster');

INSERT INTO MusicLabel (id, name)
VALUES (1, N'Rhymes Music'),
	   (2, N'Gazgolder'),
	   (3, N'CPLUS'),
	   (4, N'Hyperboloid Records'),
	   (5, N'Sony Music Entertainment'),
	   (6, N'Universal Music Group'),
	   (7, N'Warner Music Group');

CREATE TABLE CooperatesWith AS EDGE;
CREATE TABLE Writes AS EDGE;
CREATE TABLE Owns AS EDGE;
CREATE TABLE Publishes AS EDGE;


INSERT INTO CooperatesWith ($from_id, $to_id)
VALUES ((SELECT $node_id FROM MusicPerfomer Where id = 1), (SELECT $node_id FROM MusicLabel WHERE id = 6)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 2), (SELECT $node_id FROM MusicLabel WHERE id = 3)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 3), (SELECT $node_id FROM MusicLabel WHERE id = 3)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 4), (SELECT $node_id FROM MusicLabel WHERE id = 1)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 5), (SELECT $node_id FROM MusicLabel WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 6), (SELECT $node_id FROM MusicLabel WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 7), (SELECT $node_id FROM MusicLabel WHERE id = 7)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 8), (SELECT $node_id FROM MusicLabel WHERE id = 4)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 9), (SELECT $node_id FROM MusicLabel WHERE id = 5)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 10), (SELECT $node_id FROM MusicLabel WHERE id = 1));


INSERT INTO Writes ($from_id, $to_id)
VALUES ((SELECT $node_id FROM MusicPerfomer Where id = 1), (SELECT $node_id FROM Ganre WHERE id = 3)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 2), (SELECT $node_id FROM Ganre WHERE id = 1)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 3), (SELECT $node_id FROM Ganre WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 4), (SELECT $node_id FROM Ganre WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 5), (SELECT $node_id FROM Ganre WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 6), (SELECT $node_id FROM Ganre WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 7), (SELECT $node_id FROM Ganre WHERE id = 4)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 8), (SELECT $node_id FROM Ganre WHERE id = 1)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 9), (SELECT $node_id FROM Ganre WHERE id = 5)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 10), (SELECT $node_id FROM Ganre WHERE id = 3));


INSERT INTO Owns ($from_id, $to_id)
VALUES ((SELECT $node_id FROM MusicLabel Where id = 1), (SELECT $node_id FROM MusicPlace WHERE id = 2)),
	   ((SELECT $node_id FROM MusicLabel Where id = 2), (SELECT $node_id FROM MusicPlace WHERE id = 3)),
	   ((SELECT $node_id FROM MusicLabel Where id = 3), (SELECT $node_id FROM MusicPlace WHERE id = 1)),
	   ((SELECT $node_id FROM MusicLabel Where id = 4), (SELECT $node_id FROM MusicPlace WHERE id = 6)),
	   ((SELECT $node_id FROM MusicLabel Where id = 5), (SELECT $node_id FROM MusicPlace WHERE id = 5)),
	   ((SELECT $node_id FROM MusicLabel Where id = 6), (SELECT $node_id FROM MusicPlace WHERE id = 4)),
	   ((SELECT $node_id FROM MusicLabel Where id = 7), (SELECT $node_id FROM MusicPlace WHERE id = 7));

INSERT INTO Publishes ($from_id, $to_id)
VALUES ((SELECT $node_id FROM MusicPerfomer Where id = 1), (SELECT $node_id FROM MusicPlace WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 2), (SELECT $node_id FROM MusicPlace WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 3), (SELECT $node_id FROM MusicPlace WHERE id = 1)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 4), (SELECT $node_id FROM MusicPlace WHERE id = 6)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 5), (SELECT $node_id FROM MusicPlace WHERE id = 3)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 6), (SELECT $node_id FROM MusicPlace WHERE id = 4)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 7), (SELECT $node_id FROM MusicPlace WHERE id = 5)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 8), (SELECT $node_id FROM MusicPlace WHERE id = 7)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 9), (SELECT $node_id FROM MusicPlace WHERE id = 2)),
	   ((SELECT $node_id FROM MusicPerfomer Where id = 10), (SELECT $node_id FROM MusicPlace WHERE id = 2));


-- 1. Ќайти все музыкальные лейблы и места, которыми они владеют:
SELECT l.name AS LabelName, p.name AS PlaceName
FROM MusicLabel l, MusicPlace p, Owns o
WHERE MATCH(l-(o)->p);

--2. Ќайти всех музыкальных исполнителей и места, в которых они публикуют музыку:
SELECT pe.name AS PerformerName, p.name AS PlaceName
FROM MusicPerfomer pe, MusicPlace p, Publishes pb
WHERE MATCH(pe-(pb)->p);

--3. Ќайти музыкальные места, которыми владеет определенный лейбл (например, лейбл с id 1):
SELECT l.name AS LabelName, p.name AS PlaceName
FROM MusicLabel l, MusicPlace p, Owns o
WHERE l.id = 1 AND MATCH(l-(o)->p);

--4. Ќайти всех музыкальных исполнителей, публикующих музыку в определенном месте (например, место с id 2):
SELECT DISTINCT pe.name AS PerformerName, p.name AS PlaceName
FROM MusicPerfomer pe, MusicPlace p, Publishes pb
WHERE p.id = 2 AND MATCH(pe-(pb)->p);

--5. Ќайти музыкальные лейблы, которые владеют теми же местами, где публикуют музыку определенные
--исполнители (например, исполнитель с id 1):
SELECT DISTINCT pe.name AS PerformerName, p.name AS PlaceName, l.name AS LabelName
FROM MusicPerfomer pe, MusicPlace p, Publishes pb, Owns o, MusicLabel l
WHERE pe.id = 1 AND MATCH(pe-(pb)->p) AND MATCH(l-(o)->p);

--1.
WITH ArtistLabel AS (
    SELECT mp.name AS artist, ml.name AS label
    FROM MusicPerfomer mp
    JOIN CooperatesWith cw ON mp.id = cw.$from_id
    JOIN MusicLabel ml ON cw.$to_id = ml.id
),
LabelPlatform AS (
    SELECT ml.name AS label, mp.name AS platform
    FROM MusicLabel ml
    JOIN Owns o ON ml.id = o.$from_id
    JOIN MusicPlace mp ON o.$to_id = mp.id
)
SELECT a.artist, l.label, p.platform
FROM ArtistLabel a
JOIN LabelPlatform l ON a.label = l.label
JOIN MusicPerfomer mp ON a.artist = mp.name
JOIN Publishes pb ON mp.id = pb.$from_id
JOIN MusicPlace p ON pb.$to_id = p.id
WHERE mp.name = 'Travis Scott';

--2.
WITH ArtistGenre AS (
    SELECT mp.name AS artist, g.name AS genre
    FROM MusicPerfomer mp
    JOIN Writes w ON mp.id = w.$from_id
    JOIN Ganre g ON w.$to_id = g.id
)
SELECT a.artist, a.genre
FROM ArtistGenre a
JOIN MusicPerfomer mp ON a.artist = mp.name
JOIN Writes w ON mp.id = w.$from_id
JOIN Ganre g ON w.$to_id = g.id
WHERE mp.name = 'Kendrick Lamar';