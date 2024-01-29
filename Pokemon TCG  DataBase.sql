CREATE DATABASE Pokemon_Tournament

CREATE TABLE Tournament (
TournamentID int PRIMARY KEY IDENTITY (1,1),
Tournament_Name varchar (40) NOT NULL,
Location_Of_Tournament varchar (20) NOT NULL,
Player_Skill_Level varchar (20) NOT NULL,
Prize varchar (30) NOT NULL,
Date_Of_Tournament date NOT NULL,
Start_Hour time NOT NULL
)

SELECT *
FROM Tournament

INSERT INTO Tournament (Tournament_Name, Location_Of_Tournament, Player_Skill_Level, Prize,  Date_Of_Tournament, Start_Hour)
VALUES('WeeklyTournamentStandart', 'Sofia', 'Advanced', 'Paradox rift booster', '2023-11-19', '12:00'),
('MyFristBattle', 'Sofia' ,'Advanced', 'My first battle mini deck', '2023-11-12', '12:00'),
('TournamentCentar', 'France', 'Competitive', '1000$', '2023-10-21', '16:00'),
('2022 Tournaments', 'Poland', 'Beginner', 'Keychain', '2023-11-25', '18:00'),
('ReawakeningChampionship', 'Sofia', 'Competitive', '1000$', '2024-9-10', '10:00'),
('2022 Tournaments', 'Germany', 'Competitive', '2000$', '2023-12-9', '10:00'),
('TournamentCenter', 'Liverpool', 'Competitive', '3000$', '2024-01-27', '10:00' ),
('ParadoxRift', 'Sofia', 'Advanced', 'Booster box', '2023-11-05', '12:00'),
('ESL Australia', 'Perth', 'Beginner', 'Pokemon T-shirt', '2024-4-14', '15:00'),
('Trading Card Games Weekend', 'Plovdiv', 'Advanced', 'Booster pack', '2024-05-28', '10:00'),
('WeeklyTournamentStandart', 'Sofia', 'Beginner', 'booster pack', '2024-06-11', '12:00');


CREATE TABLE Players (
PlayerID int PRIMARY KEY IDENTITY (1,1),
Player_Name nvarchar (50) NOT NULL,
Player_Age int NOT NULL,
Player_Skill_Level varchar (20) NOT NULL,
Email varchar (30) UNIQUE NOT NULL
)

SELECT *
FROM Players

INSERT INTO Players (Player_Name, Player_Age, Player_Skill_Level, Email)
VALUES ('Stefan Petrov', '17', 'Beginner', 'stef4o.proto@abv.bg'),
('Daniel Danev', '14', 'Begginer', 'Dani123@gmail.com'),
('Travis Scott', '21', 'Competitive', 'CactusJack@yahoo.com'),
('Chao Min', '11', 'Competitive', 'lilchinaboy@gmail.com'),
('Bob Miller', '20', 'Advanced', 'bobym@gmail.com'),
('Petar Todjarov', '23', 'Competitive', 'ne.sum.djaro@abv.bg'),
('Charlie Sheen', '15', 'Advances', '4arlei@yahoo.com'),
('Eric Whitney', '16', 'Advanced', 'ghostemane@gmail.com'),
('Aristos Norman Petrou', '16','Competitive', 'ruby.the.cherry@gmail.com'),
('Ivan Ivanov', '20', 'Advanced', 'Ivanov@gmail.com'),
('Marius Lucas Antonio Listhrop', '25', 'Beginner', 'mlal@gmail.com'),
('Junius Donald Rogers', '17', 'Advanced', 'jdr@yahoo.com'),
('Kristian Panov', '18', 'Competitive', 'krisi.pisi@abv.bg'),
('Rosen Gacov', '19', 'Beginner', 'rosko.g@abv.bg'),
('Ivailo Andonev', '16', 'Advanced', 'ivaka@gmail.com')


CREATE TABLE Battle_Resault (
BattleID int PRIMARY KEY IDENTITY (1,1),
TournamentID int NOT NULL,
WinnerID int NOT NULL,
Battle_Date date
)

SELECT *
FROM Battle_Resault


INSERT INTO Battle_Resault (TournamentID, WinnerID, Battle_Date)
VALUES (4, 14, '2023-11-25')


INSERT INTO Battle_Resault (TournamentID, WinnerID, Battle_Date)
VALUES (4, 2, '2023-11-25'),
(1, 5, '2023-11-19'),
(3, 4, '2023-10-21'),
(2, 8, '2023-11-12'),
(6, 6, '2023-12-09'),
(8, 15, '2023-11-05')
INSERT INTO Battle_Resault (TournamentID, WinnerID, Battle_Date)
VALUES (3, 15, '2023-11-05')


UPDATE Players
SET Player_Skill_Level = 'Advanced'
WHERE PlayerID = 3;
DELETE FROM Players
WHERE PlayerID = 7;


--да се изведе средната възраст на игрчите:

SELECT AVG(Player_Age) AS AvgAge
FROM Players;

--да се изведе броя на турнирите:

SELECT COUNT(*) AS TotalTournaments
FROM Tournament;

--да се изведът годините на най-възрастния играч и на най-младия играч:

SELECT MAX(Player_Age) AS MaxAge, MIN(Player_Age) AS MinAge
FROM Players;

--да се изведе информация за броя на победите на всеки играч:

SELECT Player_Name, COUNT(WinnerID) AS Wins
FROM Players
LEFT JOIN Battle_Resault ON Players.PlayerID = Battle_Resault.WinnerID
GROUP BY Player_Name

--да се изведът имената на турнирите и победителите в тях:

SELECT Tournament_Name, WinnerID
FROM Tournament
LEFT JOIN Battle_Resault ON Tournament.TournamentID = Battle_Resault.TournamentID;

--да се изведът имената на играчите и тяхното ниво на умения в един символен низ:

SELECT Player_Name + ' - ' + Player_Skill_Level AS Player_Info
FROM Players;

--да се изведе името и датата на турнирите които са завършили преди текущата дата:

SELECT Tournament_Name, Date_Of_Tournament
FROM Tournament
WHERE Date_Of_Tournament < GETDATE();

--да се изведът имената на турнирите и имента победителите със техните емейли и години 

SELECT
 T.Tournament_Name,
 P.Player_Name AS Winner_Name,
 P.Player_Age AS Winner_Age,
 P.Email AS Winner_Email
FROM
 Tournament T
JOIN
 Battle_Resault B ON T.TournamentID = B.TournamentID
JOIN
 Players P ON B.WinnerID = P.PlayerID;

/*да се изведе информация за името на турнира, локацията му, нивото на играчит и 
датата, и да се категоризират нивата на умения и датите на турнирите*/

SELECT
 Tournament_Name,
 Location_Of_Tournament,
 Player_Skill_Level,
 Date_Of_Tournament,
 CASE
 WHEN Player_Skill_Level = 'Beginner' THEN 'Amateur Tournament'
 WHEN Player_Skill_Level = 'Advanced' THEN 'Experienced Tournament'
 WHEN Player_Skill_Level = 'Competitive' THEN 'Professional Tournament'
 ELSE 'Unknown Skill Level'
 END AS Skill_Level_Category,
 CASE
 WHEN Date_Of_Tournament < '2023-01-01' THEN 'Tournament Before 2023'
 WHEN Date_Of_Tournament >= '2023-01-01' AND Date_Of_Tournament < '2024-01-01'
THEN 'Tournament in 2023'
 WHEN Date_Of_Tournament >= '2024-01-01' AND Date_Of_Tournament < '2025-01-01'
THEN 'Tournament in 2024'
 ELSE 'Unknown Date'
 END AS Tournament_Date_Category
FROM
 Tournament;

--Проверка дали емейла е валиден
ALTER TABLE Players
 ADD CONSTRAINT CHK_Valid_Email
 CHECK (Email LIKE '%@%');
 
 --показва информация за всички турнири които имат поне един победител под определена възраст

SELECT *
FROM Tournament
WHERE TournamentID IN (
    SELECT TournamentID
    FROM Battle_Resault
    JOIN Players ON Battle_Resault.WinnerID = Players.PlayerID
    WHERE Players.Player_Age < 15
);

/*създаване на съхранена процедура, която връща информация за всички турнири, които се 
провеждат в текущия месец:*/

CREATE PROCEDURE GetTournamentsForCurrentMonth
AS
BEGIN
 SELECT Tournament_Name, Date_Of_Tournament
 FROM Tournament
 WHERE MONTH(Date_Of_Tournament) = MONTH(GETDATE()) AND YEAR(Date_Of_Tournament) =
YEAR(GETDATE());
END;

EXEC GetTournamentsForCurrentMonth

--създаване на функция, която връща средната възраст на играчите в определен турнир:

CREATE FUNCTION GetAverageAgeFromTournament(@TournamentID INT)
RETURNS INT
AS
BEGIN
 DECLARE @AvgAge INT;
 SELECT @AvgAge = AVG(Player_Age)
 FROM Players
 WHERE PlayerID IN (SELECT WinnerID FROM Battle_Resault WHERE TournamentID =
@TournamentID);
 RETURN @AvgAge;
END;

SELECT TournamentID, dbo.GetAverageAgeFromTournament(TournamentID) AS AverageAge
FROM Battle_Resault;



/*Създаване на тригер който автоматично актуализира нивото на
умение на играч, след 5 турнира*/

CREATE TRIGGER UpdateSkillLevelAfter5Wins
ON Battle_Resault
AFTER INSERT
AS
BEGIN
 DECLARE @PlayerID INT;
 SELECT @PlayerID = WinnerID
 FROM inserted;
 IF (SELECT COUNT(*) FROM Battle_Resault WHERE WinnerID = @PlayerID) >= 5
 BEGIN
 UPDATE Players
 SET Player_Skill_Level = 'Expert'
 WHERE PlayerID = @PlayerID;
 END
END;

INSERT INTO Battle_Resault (TournamentID, WinnerID, Battle_Date)
VALUES (4, 14, '2023-11-25')
INSERT INTO Battle_Resault (TournamentID, WinnerID, Battle_Date)
VALUES (4, 14, '2023-11-25')
INSERT INTO Battle_Resault (TournamentID, WinnerID, Battle_Date)
VALUES (4, 14, '2023-11-25')
INSERT INTO Battle_Resault (TournamentID, WinnerID, Battle_Date)
VALUES (4, 14, '2023-11-25')

SELECT *
FROM Players
--Създаване на изглед с обобщена информация

CREATE VIEW TournamentWinnersView AS
SELECT
 t.TournamentID,
 t.Tournament_Name,
 t.Location_Of_Tournament,
 t.Date_Of_Tournament,
 p.PlayerID AS WinnerID,
 p.Player_Name AS WinnerName,
 p.Player_Age AS WinnerAge
FROM
 Tournament t
JOIN
 Battle_Resault b ON t.TournamentID = b.TournamentID
JOIN
 Players p ON b.WinnerID = p.PlayerID;

SELECT *
FROM TournamentWinnersView;

