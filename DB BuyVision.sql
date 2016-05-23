DROP SCHEMA IF EXISTS BuyVision;
CREATE SCHEMA BuyVision;
USE BuyVision;

CREATE TABLE `Preis` (
`Zeit` TIMESTAMP PRIMARY KEY CHECK(VALUE < CURRENT_TIMESTAMP),
`Höhe` DOUBLE
);

CREATE TABLE `Produkt` (
`Produktnummer` INT PRIMARY KEY,
`Hersteller` VARCHAR(20) NOT NULL,
`Bio` BOOLEAN DEFAULT FALSE,
`Verpackungseinheit` VARCHAR(20),
`Preis_Zeit` TIMESTAMP,
FOREIGN KEY (Preis_Zeit) REFERENCES Preis(Zeit)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Substitut` (
`Produktnummer` INT PRIMARY KEY,
`Hersteller` VARCHAR(20) NOT NULL,
`Bio` BOOLEAN DEFAULT FALSE,
`Verpackungseinheit` VARCHAR(20),
`Preis_Zeit` TIMESTAMP,
FOREIGN KEY (Preis_Zeit) REFERENCES Preis(Zeit)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Kette` (
`Name` VARCHAR(20) PRIMARY KEY
);

CREATE TABLE `Supermarkt` (
`Supermarkt_ID` INT PRIMARY KEY,
`Name` VARCHAR(20) NOT NULL,
`Adresse_Straße` VARCHAR(20) NOT NULL,
`Adresse_PLZ` INT NOT NULL,
`Adresse_Ort` VARCHAR(20) NOT NULL,
`Adresse_Land` VARCHAR(20) DEFAULT 'Deutschland',
`Kette_Name` VARCHAR(20) NOT NULL,
FOREIGN KEY (Kette_Name) REFERENCES Kette(Name)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `Einkaufszettel` (
`User_ID` INT PRIMARY KEY,
`Anzahl_Maerkte` INT NOT NULL,
`Gesamtpreis` DOUBLE NOT NULL,
`Kilometer` DOUBLE
);

CREATE TABLE `User` (
`User_ID` INT PRIMARY KEY,
`Name_Anrede` VARCHAR(20),
`Name_Vorname` VARCHAR(20) NOT NULL,
`Name_Nachname` VARCHAR(20) NOT NULL,
`Adresse_Straße` VARCHAR(20) NOT NULL,
`Adresse_PLZ` INT NOT NULL,
`Adresse_Ort` VARCHAR(20) NOT NULL,
`Adresse_Land` VARCHAR(20) NOT NULL DEFAULT 'Deutschland',
`Bankdaten_BIC` BIGINT,
`Bankdaten_IBAN` BIGINT,
`Authentisierung_User_ID` INT,
`Anmeldedaten_Benutzername` VARCHAR(20) NOT NULL DEFAULT 'root',
`Anmeldedaten_Passwort` VARCHAR(20) NOT NULL DEFAULT 'root' 
);

CREATE TABLE `Statistics` (
`Browser` ENUM('Firefox','IE','Opera','Chrome','Safari','Others') NOT NULL DEFAULT 'Others',
`Version` FLOAT NOT NULL,
`IP` varchar(40) NOT NULL,
`DateandTime` DATETIME NOT NULL CHECK(VALUE < CURRENT_TIMESTAMP),
`Referer` VARCHAR(2000),
`User_User_ID` INT,
FOREIGN KEY (User_User_ID) REFERENCES User(User_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `User_has_Einkaufszettel` (
`User_User_ID` INT,
`Einkaufszettel_User_ID` INT,
PRIMARY KEY(User_User_ID, Einkaufszettel_User_ID),
FOREIGN KEY (User_User_ID) REFERENCES User(User_ID)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Einkaufszettel_User_ID) REFERENCES Einkaufszettel(User_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Supermarkt_has_Produkt` (
`Produkt_Produktnummer` INT,
`Supermarkt_Supermarkt_ID` INT,
PRIMARY KEY(Produkt_Produktnummer, Supermarkt_Supermarkt_ID),
FOREIGN KEY (Produkt_Produktnummer) REFERENCES Produkt(Produktnummer)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Supermarkt_Supermarkt_ID) REFERENCES Supermarkt(Supermarkt_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Einkaufszettel_has_Produkt` (
`Produkt_Produktnummer` INT,
`Einkaufszettel_User_ID` INT,
`Eingekauft` BOOLEAN DEFAULT FALSE NOT NULL,
`Menge` INT NOT NULL,
`Supermarkt_ID` INT NOT NULL,
`Einheit` VARCHAR(10),
PRIMARY KEY(Produkt_Produktnummer, Einkaufszettel_User_ID),
FOREIGN KEY (Produkt_Produktnummer) REFERENCES Produkt(Produktnummer)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Einkaufszettel_User_ID) REFERENCES Einkaufszettel(User_ID)
ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Produkt_has_Substitut` (
`Produkt_Produktnummer` INT,
`Substitut_Produktnummer` INT,
PRIMARY KEY (Produkt_Produktnummer, Substitut_Produktnummer),
FOREIGN KEY (Produkt_Produktnummer) REFERENCES Produkt(Produktnummer)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Substitut_Produktnummer) REFERENCES Substitut(Produktnummer)
ON DELETE CASCADE ON UPDATE CASCADE
);

