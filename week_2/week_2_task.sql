DROP TABLE iF EXISTS PlayerRegistration ;
drop table if exists TeamEntry;
drop table if exists Player;
drop table if exists Club;
drop table if exists Season;





create table Season(
    Year int,
    SeasonName VARCHAR(6),
    PRIMARY KEY(Year, SeasonName)
    );

CREATE TABLE Club(
    ClubName VARCHAR(100), 
    ContactName VARCHAR(100),
    PRIMARY KEY(ClubName)
    );

CREATE TABLE Player(
    PlayerID int,
    Fname VARCHAR (100),
    Lname VARCHAR (100),
    Phone NVARCHAR(50),
    PRIMARY KEY(PlayerID)
);

CREATE TABLE TeamEntry(
    ClubName VARCHAR(100),
    Year int,
    SeasonName VARCHAR(6),
    AgeGroup  NVARCHAR(3),
    TeamNumber int,
    PRIMARY KEY(ClubName, Year, SeasonName, AgeGroup, TeamNumber),
    FOREIGN KEY (ClubName) REFERENCES Club,
    FOREIGN key(Year, SeasonName) REFERENCES Season
);

CREATE TABLE PlayerRegistration(
    PlayerID int,
    ClubName VARCHAR(100),
    Year int,
    SeasonName VARCHAR(6),
    AgeGroup  NVARCHAR(3),
    TeamNumber int,
    DateRegistered DATE NOT NULL,
    PRIMARY KEY(PlayerID, ClubName, Year, SeasonName, AgeGroup, TeamNumber),
    FOREIGN KEY(PlayerID) REFERENCES Player,
    FOREIGN KEY (ClubName, Year, SeasonName, AgeGroup, TeamNumber) REFERENCES TeamEntry

);


DELETE PlayerRegistration;
DELETE TeamEntry;
DELETE Player;
DELETE Club;
DELETE Season;

INSERT INTO Season(Year, SeasonName)
VALUES (2018, 'Winter'),
       (2018, 'Summer'),
       (2018,'Spring'),
       (2018, 'Autumn'),
       (2019,'Winter'),
       (2019,'Summer');


INSERT into Club(ClubName, ContactName )
VALUES ('Mt Martha Basketball Club','Bob Jane'),
       ('Box Hill Golf Club','Joe Naden'),
       ('Balwyn Tennis Club','Jim Jimbo'),
       ('Doncaster Fitness Club','Jone Smith');


INSERT into Player(PlayerID, Fname, Lname, Phone)
VALUES (10002,'John','Howard', 5552345),
       (10003, 'Julia','Gillard', 5553456),
       (10004,'Jim','Jafari',5553467),
       (10005,'Mike','Benjamin',5553356),
       (10006,'Hooman','Tayefeh Jafari',5555444);

INSERT into TeamEntry(ClubName, Year, SeasonName, AgeGroup, TeamNumber)
VALUES  ('Mt Martha Basketball Club', 2018, 'Summer','U14',1),
        ('Mt Martha Basketball Club',2018, 'Summer', 'U16',2),
        ('Mt Martha Basketball Club',2018,'Winter','U14',1),
        ('Mt Martha Basketball Club',2018,'Winter','U14',2),
        ('Mt Martha Basketball Club',2019,'Summer','U16',1);

INSERT into PlayerRegistration(PlayerID, ClubName, Year, SeasonName, AgeGroup, TeamNumber, DateRegistered)
VALUES                        (10003, 'Mt Martha Basketball Club', 2018, 'Summer','U14',1,'2018/06/27'),
                              (10002,'Mt Martha Basketball Club',2018,'Summer','U16',2,'2018/06/27'),
                              (10004,'Mt Martha Basketball Club',2018,'Summer','U14',1,'2018/06/27'),
                              (10005,'Mt Martha Basketball Club',2018,'Summer','U14',1,'2018/06/27'),
                              (10006,'Mt Martha Basketball Club',2019,'Summer','U16',1,'2018/06/27');

 

SELECT p.PlayerID, p.Fname, p.Lname, p.Phone, c.ClubName, c.ContactName, s.Year, s.SeasonName, t.AgeGroup, t.TeamNumber
FROM PlayerRegistration pr
INNER JOIN Player p
ON p.PlayerID=pr.PlayerID  
INNER JOIN  TeamEntry t
ON t.ClubName=pr.ClubName  and t.Year=pr.Year and t.SeasonName=pr.SeasonName and t.AgeGroup=pr.AgeGroup and t.TeamNumber=pr.TeamNumber 
INNER JOIN Club c
ON c.ClubName=t.ClubName
INNER JOIN Season s
ON s.Year=t.Year and s.SeasonName=t.SeasonName
ORDER BY p.PlayerID ASC

SELECT s.Year, t.AgeGroup, COUNT(p.PlayerID) as NumberOfplayer
FROM PlayerRegistration pr
INNER JOIN Player p
ON p.PlayerID=pr.PlayerID  
INNER JOIN  TeamEntry t
ON t.ClubName=pr.ClubName  and t.Year=pr.Year and t.SeasonName=pr.SeasonName and t.AgeGroup=pr.AgeGroup and t.TeamNumber=pr.TeamNumber 
INNER JOIN Club c
ON c.ClubName=t.ClubName
INNER JOIN Season s
ON s.Year=t.Year and s.SeasonName=t.SeasonName
GROUP BY s.Year, t.AgeGroup
ORDER BY s.Year, t.AgeGroup ASC

SELECT s.Year 
FROM PlayerRegistration pr
INNER JOIN Player p
ON p.PlayerID=pr.PlayerID  
INNER JOIN  TeamEntry t
ON t.ClubName=pr.ClubName  and t.Year=pr.Year and t.SeasonName=pr.SeasonName and t.AgeGroup=pr.AgeGroup and t.TeamNumber=pr.TeamNumber 
INNER JOIN Club c
ON c.ClubName=t.ClubName
INNER JOIN Season s
ON s.Year=t.Year and s.SeasonName=t.SeasonName
WHERE p.PlayerID IN (SELECT p.PlayerID from Player WHERE p.Lname='Tayefeh Jafari');