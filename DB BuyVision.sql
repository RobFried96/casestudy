DROP SCHEMA IF EXISTS BuyVision;
CREATE SCHEMA BuyVision;
USE BuyVision;

CREATE TABLE `Produkt` (
`Produktnummer` VARCHAR(20) PRIMARY KEY,
`Hersteller` VARCHAR(20) NOT NULL,
`Bio` BOOLEAN DEFAULT FALSE,
`Preis` DOUBLE NOT NULL,
`Verpackungseinheit` VARCHAR(20),
`Substitut` VARCHAR(20)
);

CREATE TABLE `Supermarkt` (
`Supermarkt_ID` INT PRIMARY KEY,
`Name` VARCHAR(20) NOT NULL,
`Kette` VARCHAR(20) NOT NULL,
`Adresse_Straße` VARCHAR(20) NOT NULL,
`Adresse_PLZ` INT NOT NULL,
`Adresse_Ort` VARCHAR(20) NOT NULL,
`Adresse_Land` VARCHAR(20) DEFAULT 'Deutschland'
);

CREATE TABLE `Einkaufszettel` (
`User_ID` INT PRIMARY KEY,
`Supermarkt_ID` INT NOT NULL,
`Produktnummer` INT NOT NULL,
`Anzahl_Maerkte` INT NOT NULL,
`Gesamtpreis` DOUBLE NOT NULL,
`Kilometer` DOUBLE
);

CREATE TABLE `Authentisierung` (
`User_ID` INT PRIMARY KEY,
`Anmeldedaten_Benutzername` VARCHAR(20) NOT NULL DEFAULT 'root',
`Anmeldedaten_Passwort` VARCHAR(20) NOT NULL DEFAULT 'root' 
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
`Bankdaten_BIC` INT,
`Bankdaten_IBAN` INT,
`Authentisierung_User_ID` INT,
FOREIGN KEY (Authentisierung_User_ID) REFERENCES Authentisierung(User_ID)
);

CREATE TABLE `User_has_Einkaufszettel` (
`User_User_ID` INT,
`Einkaufszettel_User_ID` INT,
PRIMARY KEY(User_User_ID, Einkaufszettel_User_ID),
FOREIGN KEY (User_User_ID) REFERENCES User(User_ID),
FOREIGN KEY (Einkaufszettel_User_ID) REFERENCES Einkaufszettel(User_ID)
);

CREATE TABLE `Supermarkt_has_Produkt` (
`Produkt_Produktnummer` INT,
`Supermarkt_Supermarkt_ID` INT,
PRIMARY KEY(Produkt_Produktnummer, Supermarkt_Supermarkt_ID),
FOREIGN KEY (Produkt_Produktnummer) REFERENCES Produkt(Produktnummer),
FOREIGN KEY (Supermarkt_Supermarkt_ID) REFERENCES Supermarkt(Supermarkt_ID)
);

CREATE TABLE `Einkaufszettel_has_Produkt` (
`Produkt_Produktnummer` INT,
`Einkaufszettel_User_ID` INT,
PRIMARY KEY(Produkt_Produktnummer, Einkaufszettel_User_ID),
FOREIGN KEY (Produkt_Produktnummer) REFERENCES Produkt(Produktnummer),
FOREIGN KEY (Einkaufszettel_User_ID) REFERENCES Einkaufszettel(User_ID)
);




