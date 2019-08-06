DROP TABLE IF EXISTS PlayerRegistration ;
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


