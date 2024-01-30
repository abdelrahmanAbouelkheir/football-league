# football-league
    The aim of the project is to implement a system that manages the matches played in a football league as well
    as the fan attendance to these matches.
## Description
 ### System Components
1. Sports Association Manager:   
   + First of all, the association manager (which has an ID and name) can manage (create, edit or delete) the
matches that will be played by the different clubs.
2. Matches:   
   + Matches will be played by exactly two Clubs. One of them is considered the host of the match. Each
game has an ID, starting time, ending time and allowed number of attendees. Also, each match will be
hosted on exactly one stadium.
3. Clubs:   
   + Each club (which has an ID, name and location) can play many matches through the season. The club
will also have a representative (with a name and ID). who will be responsible for asking for the permission
to host the matches played by the club he is representing when the club is the host of that match.
3. Stadiums:   
   + Stadiums (which have an ID, name, capacity, location and status) are there to host the games. The status
of the stadium can be either available or not available. Each stadium has a manager (who has a name and
ID) who is in charge for approving or disapproving the different club requests for hosting their matches
on the stadium he is managing .
4. Tickets:   
   + Once the stadium manager approves hosting a certain game, tickets will be available for the fans to buy
and attend the game. Each ticket has an ID, a stadium where the match is hosted on and a status that
can either be sold or available. The system keeps track about which users bought which tickets.
5. Fans:   
   + Fans (who have name, national ID number, birth date, address and phone number) can buy tickets to
attend the matches. For some cases, a fan can temporarily be blocked from using the system.
6. System Admin:   
   + The system admin is the one who can add or delete clubs, add or delete stadiums, add or delete and
temporarily block fans from using the system.
7. General Note:   
   + All different users who use the system will have a user name and a password that they will need to enter
to be able to use the system.

## Procedures & Views & Tables
### Basic Structure
1. type: stored procedure
name: createAllTables
input: nothing
output: nothing
description: Put the queries that creates all the tables of your database with their definition
inside this procedure.
2. type: stored procedure
name: dropAllTables
input: nothing
output: nothing
description: Drop all tables that your database have inside this procedure.
3. type: stored procedure
name: dropAllProceduresFunctionsViews
input: nothing
output: nothing
description: Drop all implemented stored procedures (except this one), functions and views

4. type: stored procedure
name: clearAllTables
input: nothing
output: nothing
description: Clear all records in all tables existing in your database.
### Data Retrieval (Views)
1. type: view
   + name: allAssocManagers
   + description: fetches the username, password, and name for all association managers.
2. type: view
   + name: allClubRepresentatives
   + description: fetches the username,password, name and represented club name for all club repre-
sentatives.
3. type: view
   + name: allStadiumManagers
   + description: fetches the username, password, name and managed stadium name for all stadium
managers.
4. type: view
   + name: allFans
   + description: Fetches the username, password, name, national id number, birth date and status
(blocked or unblocked) for all fans.
5. type: view
   + name: allMatches
   + description: Fetches the name of the host club, the name of the guest club and the start time for
all matches.
6. type: view
   + name: allTickets
   + description: Fetches the name of the host club, the name of the guest club, the name of the
stadium that will host the match and the start time of the match for all tickets.
7. type: view
   + name: allCLubs
   + description: Fetches the name and location for all clubs.
8. type: view
   + name: allStadiums
   + description: Fetches the name ,location, capacity and status (available or unavailable) for all
stadiums.
9. type: view
   + name: allRequests
   + description: Fetches the username of the club representative sending the request, username of
the stadium manager receiving the request and the status of the request for all requests.
## Procedures
1. type: stored procedure
   + name: addAssociationManager
   + input: varchar(20) representing a name , varchar(20) representing a user name ,varchar(20) repre-
senting a password
   + output: nothing
   + description: Adds a new association manager with the given information .
2. type: stored procedure
   + name: addNewMatch
   + input: varchar(20) representing the name of the host club , varchar(20) representing the name of
the guest club, datetime representing the start time of the match and datetime representing the
end time of the match
   + output: nothing
description: Adds a new match with the given information.
3. type: view
   + name: clubsWithNoMatches
   + description: Fetches the names of all clubs which were not assigned to any match.
4. type: stored procedure
   + name: deleteMatch
   + input: varchar(20) representing a the name of the host club and varchar(20) representing the name
of the guest club
   + output: nothing
   + description: Deletes the match with the given information.
5. type: stored procedure
   + name: deleteMatchesOnStadium
   + input: varchar(20) representing a name of a stadium
   + output: nothing
   description: Deletes all matches that will be played on a stadium with the given name. The
matches that have already been played on that stadium should be kept not deleted.
6. type: stored procedure
   + name: addClub
   + input: varchar(20) representing a name of a club, varchar(20) representing a location of a club
   + output: nothing
   + description: Adds a new club with the given information.
7. type: stored procedure
   + name: addTicket
   + input: varchar(20) representing the name of the host club, varchar(20) representing the name of
the guest club, datetime representing the start time of the match
   + output: nothing
   + description: Adds a new ticket belonging to a match with the given information.
8. type: stored procedure
   + name: deleteClub
   + input: varchar(20) representing a name of a club,
   + output: nothing
   + description: Deletes the club with the given name.
9. type: stored procedure
   + name: addStadium
   + input: varchar(20) representing a name of a stadium, varchar(20) representing a location of a
   stadium, int representing a capacity of a stadium
   + output: nothing
   + description: Adds a new stadium with the given information.
10. type: stored procedure
    + name: deleteStadium
    + input: varchar(20) representing a name of a stadium
    + output: nothing
    + description: Deletes stadium with the given name.
11. type: stored procedure
    + name: blockFan
    + input: varchar(20) representing a national id number of a fan
    + output: nothing
    + description: blocks the fan with the given national id number.
12. type: stored procedure
    + name: unblockFan
    + input: varchar(20) representing a national id number of a fan
    + output: nothing
    + description: Unblocks the fan with the given national id number.
13. type: stored procedure
    + name: addRepresentative
    + input: varchar(20) representing a name ,varchar(20) representing a club name, varchar(20) repre-
senting a user name ,varchar(20) representing a password
    + output: nothing
    + description: Adds a new club representative with the given information .
14. type: function
    + name: viewAvailableStadiumsOn
    + input: datetime
    + output: table
    + description: returns a table containing the name, location and capacity of all stadiums which are
available for reservation and not already hosting a match on the given date.
15. type: stored procedure
    + name: addHostRequest
    + input: varchar(20) representing club name ,varchar(20) representing a stadium name, datetime
representing the start time of a match
    + output: nothing
    + description: Adds a new request sent from the representative of the given club to the representative
of the given stadium regarding the match starting at the given time which the given club is assigned
to host.
16. type: function
    + name: allUnassignedMatches
    + input: varchar(20) representing the name of a club
    + output: table
    + description: returns a table containing the info of the matches that are being hosted by the given
club but have not been assigned to a stadium yet. The info should be the name of the guest club
and the start time of the match.
17. type: stored procedure
    + name: addStadiumManager
    + input: varchar(20) representing a name ,varchar(20) representing a stadium name, varchar(20)
representing a user name ,varchar(20) representing a password
    + output: nothing
description: Adds a new stadium manager with the given information.
18. type: function
    + name: allPendingRequests
    + input: varchar(20) representing the username of a stadium manager
    + output: table
    + description: returns a table containing the info of the requests that the given stadium manager
has yet to respond to. The info should be name of the club Representative sending the request,
name of the guest club competing with the sender and the start time of the match requested to be
hosted.
19. type: stored procedure
    + name: acceptRequest
    + input: varchar(20) representing a username of a stadium manager ,varchar(20) representing hosting
club name ,varchar(20) representing a guest club name, datetime representing the start time of a
match
    + output: nothing
    + description: Accepts the already sent request with the given info.
20. type: stored procedure
    + name: rejectRequest
    + input: varchar(20) representing a username of a stadium manager ,varchar(20) representing hosting
club name ,varchar(20) representing a guest club name, datetime representing the start time of a
match
    + description: Rejects the already sent request with the given info.
21. type: stored procedure
    + name: addFan
    + input: varchar(20) representing a name, varchar(20) representing a username, varchar(20) repre-
senting a password, varchar(20) representing a national id number, datetime representing birth
date,varchar(20) representing an address and int representing a phone number
    + output: nothing
    + description: Adds a new fan with the given information .
22. type: function
    + name: upcomingMatchesOfClub
    + input: varchar(20) representing a club name
    + output: table
    description: returns a table containing the info of upcoming matches which the given club will
play. All already played matches should not be included. The info should be the given club name,
the competing club name , the starting time of the match and the name of the stadium hosting the
match.
23. type: function
    + name: availableMatchesToAttend
    + input: datetime
    + output: table
    + description: returns a table containing the info of all upcoming matches which will be played
starting from the given date and still have tickets available on sale. The info should be the host
club name, the guest club name , the start time of the match and the name of the stadium hosting
the match.
24. type: stored procedure
    + name: purchaseTicket
    + input: varchar(20) representing the national id number of a fan,varchar(20) representing hosting
club name ,varchar(20) representing the guest club name, datetime representing the start time of
the match
    + output: nothing
    + description: Executes the action of a fan with the given national id number buying a ticket for
the match with the given info .
25. type: stored procedure
    + name: updateMatchHost
    + input: varchar(20) representing host lub name ,varchar(20) representing guest club name, datetime
representing the start time of the match
    + output: nothing
    + description: Change the host of the given match to the guest club .
26. type: view
    + name: matchesPerTeam
    + description: Fetches all club names and the number of matches they have already played.
27. type: view
    + name: clubsNeverMatched
    + description: Fetches pair of club names (first club name and second club name) which have never
played against each other.
28. type: function
    + name: clubsNeverPlayed
    + input: varchar(20) representing club name,
    + output: table
    + description: returns a table containing all club names which the given club has never competed
against.
29. type: function
    + name: matchWithHighestAttendance
    + input: nothing
    + output: table
    + description: returns a table containing the name of the host club and the name of the guest club
of the match which sold the highest number of tickets so far.
30. type: function
    + name: matchesRankedByAttendance
    + input: nothing
    + output: table
    + description: returns a table containing the name of the host club and the name of the guest club
of all played matches sorted descendingly by the total number of tickets they have sold.
31. type: function
    + name: requestsFromClub
    + input: varchar(20) representing name of a stadium, varchar(20) representing name of a club
    + output: table
    + description: returns a table containing the name of the host club and the name of the guest club
of all matches that are requested to be hosted on the given stadium sent by the representative of
the given club.

## Authors

-   [@mahmoudaboueleneen](https://github.com/mahmoudaboueleneen)
-   [@Ahmedsherif74](https://github.com/Ahmedsherif74)
-   [@abdelrahmanAbouelkheir](https://github.com/abdelrahmanAbouelkheir)

