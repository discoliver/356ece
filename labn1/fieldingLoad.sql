DROP TABLE IF EXISTS Fielding;

CREATE TABLE Fielding (
    playerID VARCHAR(9),
    yearID INTEGER,
    stint INTEGER,
    teamID VARCHAR(3),
    lgID VARCHAR(2),
    POS VARCHAR(2),
    G INTEGER,
    GS INTEGER,
    InnOuts INTEGER,
    PO INTEGER,
    A INTEGER,
    E INTEGER,
    DP INTEGER,
    PB INTEGER,
    WP INTEGER,
    SB INTEGER,
    CS INTEGER,
    ZR DOUBLE,
    PRIMARY KEY ( playerID, yearID, stint, POS )
) CHARACTER SET 'UTF8';

LOAD DATA LOCAL INFILE '/home/pasward/Organized/University/Teaching/ECE356/2017-Winter/Labs/Data/lahman-csv_2015-01-24/Fielding.csv' INTO TABLE Fielding FIELDS TERMINATED BY ','; 
