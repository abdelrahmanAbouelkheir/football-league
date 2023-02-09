-- Create database statement (temporary)
    CREATE DATABASE dbproj2;
    GO

/*    BASIC DATABASE STRUCTURE    */

-- NEED TO CHECK: cascading
CREATE PROCEDURE createAllTables
AS
    CREATE TABLE SystemUser (
        username VARCHAR(20) PRIMARY KEY,
        password VARCHAR(20)
    )

    CREATE TABLE SystemAdmin (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE SportsAssociationManager (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Fan (
        national_id VARCHAR(20) PRIMARY KEY,
        birth_date DATETIME,
        status BIT,
        phone_number INT,
        address VARCHAR(20),
        name VARCHAR(20),
        username VARCHAR(20),
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Club (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        location VARCHAR(20)
    )   

    CREATE TABLE Stadium (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        capacity INT,
        location VARCHAR(20),
        status BIT
    )

    CREATE TABLE ClubRepresentative (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        club_id INT,
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(club_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE StadiumManager (
        id INT PRIMARY KEY IDENTITY(1,1),
        name VARCHAR(20),
        username VARCHAR(20),
        stadium_id INT,
        FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY(stadium_id) REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
    )

    CREATE TABLE Match (
        id INT PRIMARY KEY IDENTITY(1,1),
        start_time DATETIME,
        end_time DATETIME,
        stadium_id INT,
        host_club_id INT,
        guest_club_id INT,
        FOREIGN KEY(stadium_id) REFERENCES Stadium(id),
        FOREIGN KEY(host_club_id) REFERENCES Club(id),
        FOREIGN KEY(guest_club_id) REFERENCES Club(id)
    )

    CREATE TABLE HostRequest (
        id INT PRIMARY KEY IDENTITY(1,1),
        status VARCHAR(20),
        match_id INT,
        asked_by_id INT,
        handled_by_id INT,
        FOREIGN KEY(match_id) REFERENCES Match(id),
        FOREIGN KEY(asked_by_id) REFERENCES ClubRepresentative(id),
        FOREIGN KEY(handled_by_id) REFERENCES StadiumManager(id),
        CHECK ( status IN ('UNHANDLED', 'REJECTED', 'ACCEPTED') )
    )

    CREATE TABLE Ticket (
        id INT PRIMARY KEY IDENTITY(1,1),
        status BIT,
        match_id INT,
        FOREIGN KEY(match_id) REFERENCES Match(id)
    )

    CREATE TABLE TicketBuyingTransaction (
        fan_national_id VARCHAR(20),
        ticket_id INT PRIMARY KEY,
        FOREIGN KEY(fan_national_id) REFERENCES Fan(national_id),
        FOREIGN KEY(ticket_id) REFERENCES Ticket(id)
    )
GO

CREATE PROCEDURE dropAllTables
AS
    DROP TABLE SystemAdmin
    DROP TABLE HostRequest
    DROP TABLE SportsAssociationManager
    DROP TABLE TicketBuyingTransaction
    DROP TABLE Fan
    DROP TABLE ClubRepresentative
    DROP TABLE StadiumManager
    DROP TABLE Ticket
    DROP TABLE Match
    DROP TABLE Stadium
    DROP TABLE Club
    DROP TABLE SystemUser
GO

CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
    DROP PROCEDURE createAllTables
    DROP PROCEDURE dropAllTables
    DROP PROCEDURE clearAllTables
    DROP VIEW allAssocManagers
    DROP VIEW allClubRepresentatives
    DROP VIEW allStadiumManagers
    DROP VIEW allFans
    DROP VIEW allMatches
    DROP VIEW allTickets
    DROP VIEW allClubs
    DROP VIEW allStadiums
    DROP VIEW allRequests
    DROP PROCEDURE addAssociationManager
    DROP PROCEDURE addNewMatch
    DROP VIEW clubsWithNoMatches
    DROP PROCEDURE deleteMatch
    DROP PROCEDURE deleteMatchesOnStadium
    DROP PROCEDURE addClub
    DROP PROCEDURE addTicket
    DROP PROCEDURE deleteClub
    DROP PROCEDURE addStadium
    DROP PROCEDURE deleteStadium
    DROP PROCEDURE blockFan
    DROP PROCEDURE unblockFan
    DROP PROCEDURE addRepresentative
    DROP FUNCTION viewAvailableStadiumsOn
    DROP PROCEDURE addHostRequest
    DROP FUNCTION allUnassignedMatches
    DROP PROCEDURE addStadiumManager
    DROP FUNCTION allPendingRequests
    DROP PROCEDURE acceptRequest
    DROP PROCEDURE rejectRequest
    DROP PROCEDURE addFan
    DROP FUNCTION upcomingMatchesOfClub
    DROP FUNCTION availableMatchesToAttend
    DROP PROCEDURE purchaseTicket
    DROP PROCEDURE updateMatchHost
    DROP VIEW matchesPerTeam
    DROP VIEW clubsNeverMatched
    DROP FUNCTION clubsNeverPlayed
    DROP FUNCTION matchWithHighestAttendance
    DROP FUNCTION matchesRankedByAttendance
    DROP FUNCTION requestsFromClub
GO

CREATE PROCEDURE clearAllTables
AS
    DELETE FROM SystemUser
    DELETE FROM SystemAdmin
    DELETE FROM SportsAssociationManager
    DELETE FROM Fan
    DELETE FROM ClubRepresentative
    DELETE FROM HostRequest
    DELETE FROM StadiumManager
    DELETE FROM Stadium
    DELETE FROM Match
    DELETE FROM TicketBuyingTransaction
    DELETE FROM Club
    DELETE FROM Ticket
GO

-- For testing (temporary)

    -- General testing
    EXEC createAllTables
    DROP PROCEDURE createAllTables
    EXEC dropAllTables
    DROP PROCEDURE dropAllTables
    EXEC dropAllProceduresFunctionsViews
    SELECT * FROM Stadium
     
    INSERT INTO SystemUser VALUES ('aa','123'), ('bb','456'), ('cc','123'), 
                                  ('dd','123'), ('ee','123'), ('ff','123'), 
                                  ('gg','123'), ('hh','123'), ('ii','123'), 
                                  ('jj','123'), ('kk','123'), ('ll','123');
    SELECT * FROM SystemUser

    INSERT INTO SystemAdmin VALUES ('ahmed','aa');
    SELECT * FROM SystemAdmin

    INSERT INTO SportsAssociationManager VALUES ('bahmed','bb');
    SELECT * FROM SportsAssociationManager

    INSERT INTO Fan VALUES ('A123BEC','1990/2/2',1,'01155541606','Rehab','cahmed','cc');
    SELECT * FROM Fan

    INSERT INTO Club VALUES ('RM','Spain'),('PSG','France');
    SELECT * FROM Club

    INSERT INTO Stadium VALUES ('StadOne',40000,'Madrid',1),('StadTwo',70000,'Rio De Janeiro',1);
    SELECT * FROM Stadium

    INSERT INTO ClubRepresentative VALUES ('dahmed','dd',2),('eahmed','ee',1);
    SELECT * FROM ClubRepresentative

    INSERT INTO StadiumManager VALUES ('fahmed','ff',1),('gahmed','gg',2);
    SELECT * FROM StadiumManager

    SELECT * FROM Match
    SELECT * FROM HostRequest
    SELECT * FROM Ticket
    SELECT * FROM TicketBuyingTransaction

    /* ------------------------------------------ */

    -- Testing 2.2 and 2.3 (in order)
    SELECT * FROM allAssocManagers
    SELECT * FROM allClubRepresentatives
    SELECT * FROM allStadiumManagers
    SELECT * FROM allFans
    SELECT * FROM allMatches
    SELECT * FROM allTickets
    SELECT * FROM allClubs
    SELECT * FROM allStadiums
    SELECT * FROM allRequests
    -- EXEC addAssociationManager
    EXEC addNewMatch 'PSG','Barcelona','2011/12/17 13:00:00','2010/12/17 15:00:00'
    EXEC addNewMatch 'PSG','RM','2011/12/17 13:00:00','2011/12/17 15:00:00'
    EXEC addNewMatch 'PSG','RM','2022/12/17 13:00:00','2022/12/17 15:00:00'
    EXEC addNewMatch 'PSG','RM','2023/1/1 13:00:00','2023/1/1 15:00:00'
    SELECT * FROM clubsWithNoMatches
    EXEC deleteMatch 'PSG','RM'
        UPDATE Match SET stadium_id = 1
    EXEC deleteMatchesOnStadium 'StadOne'
    EXEC addClub 'Barcelona','Spain'
    EXEC addTicket 'PSG','Barcelona','2011/12/17 13:00:00'
    EXEC deleteClub 'Barcelona'
    EXEC addStadium 'StadThree','Egypt',30000
    EXEC deleteStadium 'StadThree'
    EXEC blockFan 'A123BEC'
    EXEC unblockFan 'A123BEC'
    -- EXEC addRepresentative 'hahmed','Barcelona','hh','123'
    SELECT * FROM dbo.viewAvailableStadiumsOn('2022/12/17 14:00:00') --> ???????????????????????
    EXEC addHostRequest 'PSG','StadTwo','2022/12/17 13:00:00'
    EXEC addHostRequest 'PSG','StadThree','2023/1/1 13:00:00'
    SELECT * FROM dbo.allUnassignedMatches('PSG')
    -- EXEC addStadiumManager 'iahmed','StadThree','ii','123
    SELECT * FROM dbo.allPendingRequests('ii') --> ??????????????????????
    -- EXEC acceptRequest
    -- EXEC rejectRequest
    EXEC addFan 'Omar','omarrr12','123','B341ASKE','1992/1/1','Cairo, Egypt',01555551050
        UPDATE Match SET stadium_id = 1 WHERE id = 6
    SELECT * FROM dbo.upcomingMatchesOfClub('PSG')
    SELECT * FROM dbo.availableMatchesToAttend('2020/1/1')
    EXEC purchaseTicket 'B341ASKE','PSG','RM','2023/1/1 13:00:00'
    EXEC updateMatchHost 'PSG','RM','2023/1/1 13:00:00'
    SELECT * FROM matchesPerTeam
    SELECT * FROM clubsNeverMatched
    SELECT * FROM dbo.clubsNeverPlayed('Barcelona')
    SELECT * FROM dbo.matchWithHighestAttendance()
    SELECT * FROM dbo.matchesRankedByAttendance()
    SELECT * FROM dbo.requestsFromClub('StadTwo','PSG')
    GO

/*      BASIC DATA RETRIEVAL     */
CREATE VIEW allAssocManagers AS
SELECT S.username, U.password, S.name
FROM SportsAssociationManager S, SystemUser U
WHERE U.username = S.username
GO

CREATE VIEW allClubRepresentatives AS
SELECT R.username, U.password, R.name, C.name AS club_name
FROM ClubRepresentative R INNER JOIN SystemUser U ON R.username = U.username 
     LEFT OUTER JOIN Club C ON R.club_id = C.id
GO

CREATE VIEW allStadiumManagers AS
SELECT M.username, U.password, M.name, S.name AS stadium_name 
FROM StadiumManager M INNER JOIN SystemUser U ON M.username = U.username 
     LEFT OUTER JOIN Stadium S ON M.stadium_id = S.id
GO

CREATE VIEW allFans AS
SELECT F.username, U.password, F.name, F.national_id, F.birth_date, F.status
FROM Fan F, SystemUser U
WHERE F.username = U.username
GO

CREATE VIEW allMatches AS
SELECT C1.name AS host_club, C2.name AS guest_club, M.start_time
FROM Club C1, Club C2, Match M
WHERE M.host_club_id = C1.id AND M.guest_club_id = C2.id
GO

CREATE VIEW allTickets AS
SELECT C1.name AS host_club, C2.name AS guest_club, S.name AS stadium_name, M.start_time
FROM Ticket T INNER JOIN Match M ON T.match_id = M.id INNER JOIN Club C1 ON 
     M.host_club_id = C1.id INNER JOIN Club C2 
     ON M.guest_club_id = C2.id LEFT OUTER JOIN Stadium S ON M.stadium_id = S.id
GO

CREATE VIEW allClubs AS
SELECT name, location
FROM Club
GO

CREATE VIEW allStadiums AS
SELECT name, location, capacity, status
FROM Stadium;
GO

CREATE VIEW allRequests AS
SELECT C.username AS club_rep_username, M.username AS stad_manager_username, R.status
FROM ClubRepresentative C, StadiumManager M, HostRequest R
WHERE C.id = R.asked_by_id AND M.id = R.handled_by_id;
GO

/*      ALL OTHER DATA RETRIEVAL     */

-- NEED TO CHECK
CREATE PROCEDURE addAssociationManager
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS
    INSERT INTO SystemUser VALUES(@username, @password)
    INSERT INTO SportsAssociationManager(name, username) VALUES(@name, @username)
GO

CREATE PROCEDURE addNewMatch
@chname VARCHAR(20),
@cgname VARCHAR(20),
@start_time DATETIME,
@end_time DATETIME
AS
    DECLARE @x INT
    DECLARE @y INT

    SELECT @x = C1.id FROM Club C1 WHERE C1.name = @chname
    SELECT @y = C2.id FROM Club C2 WHERE C2.name = @cgname

    INSERT INTO Match VALUES(@start_time, @end_time, NULL, @x, @y)
GO

CREATE VIEW clubsWithNoMatches AS
(SELECT C.name FROM Club C)
EXCEPT 
(SELECT C1.name FROM Club C1, Match M WHERE M.host_club_id = C1.id OR M.guest_club_id = C1.id)
GO

CREATE PROCEDURE deleteMatch
@chname VARCHAR(20),
@cgname VARCHAR(20)
AS
    DECLARE @x INT
    DECLARE @y INT

    SELECT @x = C1.id FROM Club C1 WHERE C1.name = @chname
    SELECT @y = C2.id FROM Club C2 WHERE C2.name = @cgname

    DELETE FROM Match WHERE host_club_id = @x AND guest_club_id = @y
GO

CREATE PROCEDURE deleteMatchesOnStadium
@stadium VARCHAR(20)
AS
  DECLARE @stad_id INT
  SELECT @stad_id = S.id from Stadium S WHERE S.name = @stadium
  DELETE FROM Match WHERE stadium_id = @stad_id AND CURRENT_TIMESTAMP < start_time
GO

CREATE PROCEDURE addClub
@cname VARCHAR(20),
@cl VARCHAR(20)
AS
    INSERT INTO Club VALUES (@cname, @cl)
GO

CREATE PROCEDURE addTicket
@chname VARCHAR(20),
@cgname VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @match_id INT

    DECLARE @x INT
    DECLARE @y INT
    SELECT @x = C1.id FROM Club C1 WHERE C1.name = @chname
    SELECT @y = C2.id FROM Club C2 WHERE C2.name = @cgname

    SELECT @match_id = M.id FROM Match M 
    WHERE M.host_club_id = @x AND M.guest_club_id = @y
    AND M.start_time = @datetime

    INSERT INTO Ticket(status, match_id) VALUES(1, @match_id)
GO

CREATE PROCEDURE deleteClub
@cname VARCHAR(20)
AS
    DELETE FROM Club WHERE Club.name = @cname
GO

CREATE PROCEDURE addStadium
@sname VARCHAR(20),
@sl VARCHAR(20),
@sc INT
AS
    /* 1 means that the stadium is available */
    INSERT INTO Stadium VALUES (@sname, @sc, @sl, 1)
GO

CREATE PROCEDURE deleteStadium
@sname VARCHAR(20)
AS
    DELETE FROM Stadium WHERE Stadium.name = @sname
GO

CREATE PROCEDURE blockFan
@f_n VARCHAR(20) 
AS
    UPDATE Fan SET Fan.status = 0 WHERE Fan.national_id = @f_n
GO

CREATE PROCEDURE unblockFan
@f_n VARCHAR(20)
AS
    UPDATE Fan SET Fan.status = 1 WHERE Fan.national_id = @f_n
GO

-- NEED TO CHECK
CREATE PROCEDURE addRepresentative
@rname VARCHAR(20),
@cname VARCHAR(20),
@ruser VARCHAR(20),
@rp VARCHAR(20)
AS
    DECLARE @f BIT
    SET @f = 0
    SELECT @f = 1 FROM SystemUser
    WHERE EXISTS (SELECT S1.username
                  FROM SystemUser S1 
                  WHERE S1.password = @rp AND S1.username = @ruser) 
    IF(@f=1)
    BEGIN
        DECLARE @x int
        SELECT @x = C.id FROM Club C WHERE C.name = @cname
        INSERT INTO ClubRepresentative values (@rname, @ruser, @x)
    END
GO

-- NEED TO CHECK
CREATE FUNCTION viewAvailableStadiumsOn
(@datetime DATETIME)
RETURNS TABLE
AS
RETURN
(
    SELECT S.name, S.location, S.capacity FROM Stadium S
    WHERE S.status = 1 AND 
    NOT EXISTS 
    (
    SELECT M.id FROM Match M 
    WHERE M.stadium_id = S.id AND M.start_time <= @datetime AND M.end_time >= @datetime
    )
)
GO

CREATE PROCEDURE addHostRequest
@cname VARCHAR(20),
@sname VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @rep_id INT
    DECLARE @man_id INT
    DECLARE @stad_id INT
    DECLARE @match_id INT

    SELECT @rep_id = R.id FROM ClubRepresentative R, Club C WHERE R.club_id = C.id
    SELECT @man_id = M.id FROM StadiumManager M, Stadium S WHERE M.stadium_id = S.id
    SELECT @stad_id = S.id FROM Stadium S WHERE S.name = @sname
    SELECT @match_id = M.id FROM Match M WHERE M.stadium_id = @stad_id AND M.start_time = @datetime

    INSERT INTO HostRequest VALUES('UNHANDLED', @match_id, @rep_id, @man_id)
GO

CREATE FUNCTION allUnassignedMatches
(@chname VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT CG.name, M.start_time FROM Match M, Club CH, Club CG
    WHERE CH.name = @chname AND M.host_club_id = CH.id AND M.guest_club_id = CG.id
    AND M.stadium_id IS NULL
)
GO

-- NEED TO CHECK
CREATE PROCEDURE addStadiumManager
@name VARCHAR(20),
@stname VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS
    INSERT INTO SystemUser VALUES(@username, @password)

    DECLARE @sid INT
    SELECT @sid = S.id FROM Stadium S WHERE S.name = @stname
    INSERT INTO StadiumManager VALUES(@name, @username, @sid)
GO

-- NEED TO CHECK
CREATE FUNCTION allPendingRequests
(@username VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT R.name AS rep_name, C.name AS guest_club, M.start_time 
    FROM HostRequest H INNER JOIN StadiumManager SM ON H.handled_by_id = SM.id 
         INNER JOIN ClubRepresentative R ON H.asked_by_id = R.id 
         LEFT OUTER JOIN Match M ON H.match_id = M.id LEFT OUTER JOIN Club C ON M.guest_club_id = C.id
    WHERE SM.username = @username AND H.status = 'UNHANDLED'
)
GO

CREATE PROCEDURE acceptRequest
@username VARCHAR(20),
@chname VARCHAR(20),
@c2name VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @x INT

    SELECT @x = H.id
    FROM HostRequest H, StadiumManager SM, Club CH, Club C2, Match M 
    WHERE SM.username = @username AND CH.name = @chname AND C2.name = @c2name 
    AND M.host_club_id = CH.id AND M.guest_club_id = C2.id
    AND M.stadium_id = SM.stadium_id AND M.start_time = @datetime
    AND H.match_id = M.id

    UPDATE HostRequest SET status = 'ACCEPTED' WHERE HostRequest.id = @x
GO

CREATE PROCEDURE rejectRequest
@username VARCHAR(20),
@chname VARCHAR(20),
@c2name VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @x INT

    SELECT @x = H.id
    FROM HostRequest H, StadiumManager SM, Club CH, Club C2, Match M 
    WHERE SM.username = @username AND CH.name = @chname AND C2.name = @c2name 
    AND M.host_club_id = CH.id AND M.guest_club_id = C2.id
    AND M.stadium_id = SM.stadium_id AND M.start_time = @datetime
    AND H.match_id = M.id

    UPDATE HostRequest SET status = 'REJECTED' WHERE HostRequest.id = @x
GO

-- NEED TO CHECK
CREATE PROCEDURE addFan
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20),
@national_id VARCHAR(20),
@birth_date DATETIME,
@address VARCHAR(20),
@phone_no INT
AS
    INSERT INTO SystemUser VALUES (@username, @password)
    INSERT INTO Fan VALUES (@national_id, @birth_date, 1, @phone_no, @address, @name, @username)
GO

CREATE FUNCTION upcomingMatchesOfClub
(@cname VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT C1.name AS club, C2.name AS competing_club, M.start_time, S.name AS stadium_name
    FROM Club C1, Club C2, Match M, Stadium S
    WHERE C1.name = @cname 
    AND ( (C1.id = M.host_club_id AND C2.id = M.guest_club_id) OR (C1.id = M.guest_club_id AND C2.id = M.host_club_id) )
    AND M.stadium_id = S.id
    AND CURRENT_TIMESTAMP < M.start_time
)
GO

CREATE FUNCTION availableMatchesToAttend
(@datetime DATETIME)
RETURNS TABLE
AS
RETURN
(
    SELECT CH.name AS host_club, C2.name AS guest_club, M.start_time, S.name AS stadium_name
    FROM Club CH, Club C2, Match M, Stadium S
    WHERE M.host_club_id = CH.id AND M.guest_club_id = C2.id 
    AND M.stadium_id = S.id AND M.start_time >= @datetime
    AND EXISTS (SELECT T.id FROM Ticket T WHERE T.match_id = M.id AND T.status = 1)
)
GO

CREATE PROCEDURE purchaseTicket
@national_id VARCHAR(20),
@chname VARCHAR(20),
@cgname VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @t_id INT

    SELECT @t_id = T.id 
    FROM Ticket T, Match M, Club CH, Club CG
    WHERE CH.name = @chname AND CG.name = @cgname
    AND M.host_club_id = CH.id AND M.guest_club_id = CG.id
    AND M.start_time = @datetime

    INSERT INTO TicketBuyingTransaction VALUES(@national_id, @t_id)
    UPDATE Ticket SET status = 0 WHERE id = @t_id
GO

CREATE PROCEDURE updateMatchHost
@chname VARCHAR(20),
@cgname VARCHAR(20),
@datetime DATETIME
AS
    DECLARE @m_id INT
    DECLARE @h_id INT
    DECLARE @g_id INT

    SELECT @m_id = M.id, @h_id = CH.id, @g_id = CG.id 
    FROM Match M, Club CH, Club CG
    WHERE CH.name = @chname AND CG.name = @cgname AND M.host_club_id = CH.id 
    AND M.guest_club_id = CG.id AND M.start_time = @datetime

    UPDATE Match SET host_club_id = @g_id WHERE id = @m_id
    UPDATE Match SET guest_club_id = @h_id WHERE id = @m_id
GO

CREATE VIEW matchesPerTeam AS
    SELECT C.name AS club_name, Count(M.id) AS matches_played_count
    FROM Club C, Match M
    WHERE (M.host_club_id = C.id OR M.guest_club_id = C.id)
    AND CURRENT_TIMESTAMP > M.end_time
    GROUP BY C.name
GO

CREATE VIEW clubsNeverMatched AS
    SELECT C1.name AS first_club, C2.name AS second_club
    FROM Club C1, Club C2 
    WHERE C1.id > C2.id AND NOT EXISTS 
    (
        SELECT M.id FROM Match M WHERE 
        (M.host_club_id = C1.id AND M.guest_club_id = C2.id AND CURRENT_TIMESTAMP > M.start_time)
        OR
        (M.host_club_id = C2.id AND M.guest_club_id = C1.id AND CURRENT_TIMESTAMP > M.start_time)
    )
GO

CREATE FUNCTION clubsNeverPlayed
(@cname VARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT C2.name 
    FROM Club C1, Club C2 
    WHERE C1.name = @cname AND C1.id <> C2.id AND NOT EXISTS
    (
    SELECT M.id FROM Match M WHERE
    (M.host_club_id = C1.id AND M.guest_club_id = C2.id AND CURRENT_TIMESTAMP > M.start_time)
    OR
    (M.host_club_id = C2.id AND M.guest_club_id = C1.id AND CURRENT_TIMESTAMP > M.start_time)
    )
)
GO

CREATE FUNCTION matchWithHighestAttendance
()
RETURNS TABLE
AS
RETURN
(   
    SELECT TOP 1 CH.name AS host_club, CG.name AS guest_club
    FROM Match M, Ticket T, Club CH, Club CG
    WHERE T.match_id = M.id AND M.host_club_id = CH.id AND M.guest_club_id = CG.id
    GROUP BY M.id, CH.name, CG.name
    ORDER BY Count(T.id) DESC               
)
GO

CREATE FUNCTION matchesRankedByAttendance
()
RETURNS TABLE
AS
RETURN
(
    SELECT CH.name AS host_club, CG.name AS guest_club
    FROM Match M, Ticket T, Club CH, Club CG
    WHERE T.match_id = M.id AND M.host_club_id = CH.id AND
          M.guest_club_id = CG.id AND CURRENT_TIMESTAMP > M.end_time
    GROUP BY M.id, CH.name, CG.name
    ORDER BY Count(T.id) DESC OFFSET 0 rows
)
GO

CREATE FUNCTION requestsFromClub
(
@st_name VARCHAR(20),
@cname VARCHAR(20)
)
RETURNS TABLE
AS
RETURN
(
    SELECT CH.name AS host_club, CG.name AS guest_club 
    FROM Club C, Club CH, Club CG, Match M, HostRequest H, 
         Stadium S, ClubRepresentative R
    WHERE C.name = @cname AND R.club_id = C.id AND H.asked_by_id = R.id AND
          S.name = @st_name AND M.stadium_id = S.id AND H.match_id = M.id AND
          M.host_club_id = CH.id AND M.guest_club_id = CG.id
)
GO

/* 

    Thank you for viewing our code :)

*/