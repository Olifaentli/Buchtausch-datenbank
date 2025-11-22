-- Erstellt die Datenbank
CREATE DATABASE buchtausch_app;
USE buchtausch_app;

-- Kreiiert Entität Land mit allen Attributen und einem eineindeutigen Schlüssel 
CREATE TABLE Land (
  LandID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Nationalitaet VARCHAR(100)
);

-- Kreiiert Entität Genre mit allen Attributen und einem eineindeutigen Schlüssel 
CREATE TABLE Genre (
  GenreID INT PRIMARY KEY AUTO_INCREMENT,
  Bezeichnung VARCHAR(50)
);

-- Kreiiert Entität Verlag mit allen Attributen und einem eineindeutigen Schlüssel 
CREATE TABLE Verlag (
  VerlagID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100)
);

-- Kreiiert Entität Sprache mit allen Attributen und einem eineindeutigen Schlüssel 
CREATE TABLE Sprache (
  SpracheID INT PRIMARY KEY AUTO_INCREMENT,
  Bezeichnung VARCHAR(50)
);

-- Kreiiert Entität Adresse mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Adresse (
  AdresseID INT PRIMARY KEY AUTO_INCREMENT,
  Strasse VARCHAR(100),
  PLZ VARCHAR(20),
  Ort VARCHAR(100),
  LandID INT,
  Breitengrad DECIMAL(9,6),
  Laengengrad DECIMAL(9,6),
  FOREIGN KEY (LandID) REFERENCES Land (LandID)
);

-- Kreiiert Entität Benutzer mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Benutzer (
  BenutzerID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Email VARCHAR(100) UNIQUE,
  Passwort VARCHAR(255),
  AdresseID INT,
  Registrierungsdatum DATE,
  Aktiv BOOLEAN,
  FOREIGN KEY (AdresseID) REFERENCES Adresse (AdresseID)
);

-- Kreiiert Entität Autor mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Autor (
  AutorID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(100),
  Geburtsjahr INT,
  LandID INT,
  FOREIGN KEY (LandID) REFERENCES Land (LandID)
);

-- Kreiiert Entität Buch mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Buch (
  BuchID INT PRIMARY KEY AUTO_INCREMENT,
  Titel VARCHAR(255),
  VerlagID INT,
  GenreID INT,
  Erscheinungsjahr INT,
  FOREIGN KEY (GenreID) REFERENCES Genre (GenreID),
  FOREIGN KEY (VerlagID) REFERENCES Verlag (VerlagID)
);

-- Kreiiert Entität Buchautor mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE BuchAutor (
  BuchAutorID INT PRIMARY KEY AUTO_INCREMENT,
  BuchID INT,
  AutorID INT,
  FOREIGN KEY (AutorID) REFERENCES Autor (AutorID),
  FOREIGN KEY (BuchID) REFERENCES Buch (BuchID)
);

-- Kreiiert Entität Exemplar mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Exemplar (
  ExemplarID INT PRIMARY KEY AUTO_INCREMENT,
  BuchID INT,
  BenutzerID INT,
  SpracheID INT,
  Medium VARCHAR(50),
  Ausgabe VARCHAR(50),
  Zustand VARCHAR(50),
  MaxLeihdauer INT,
  Versandoption BOOLEAN,
  Abholort VARCHAR(255),
  Aktiv BOOLEAN,
  FOREIGN KEY (SpracheID) REFERENCES Sprache (SpracheID),
  FOREIGN KEY (BuchID) REFERENCES Buch (BuchID),
  FOREIGN KEY (BenutzerID) REFERENCES Benutzer (BenutzerID)
);

-- Kreiiert Entität Ausleihe mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Ausleihe (
  AusleiheID INT PRIMARY KEY AUTO_INCREMENT,
  ExemplarID INT,
  EntleiherID INT,
  Startdatum DATE,
  Enddatum DATE,
  Rueckgabedatum DATE,
  Status VARCHAR(20),
  FOREIGN KEY (EntleiherID) REFERENCES Benutzer (BenutzerID),
  FOREIGN KEY (ExemplarID) REFERENCES Exemplar (ExemplarID)
);

-- Kreiiert Entität Bewertung mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Bewertung (
  BewertungID INT PRIMARY KEY AUTO_INCREMENT,
  BenutzerID INT,
  BuchID INT,
  Sterne INT,
  Kommentar TEXT,
  Datum DATE,
  FOREIGN KEY (BuchID) REFERENCES Buch (BuchID),
  FOREIGN KEY (BenutzerID) REFERENCES Benutzer (BenutzerID)
);

-- Kreiiert Entität Merkliste mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Merkliste (
  MerklisteID INT PRIMARY KEY AUTO_INCREMENT,
  BenutzerID INT,
  BuchID INT,
  Datum DATE,
  FOREIGN KEY (BuchID) REFERENCES Buch (BuchID),
  FOREIGN KEY (BenutzerID) REFERENCES Benutzer (BenutzerID)
);

-- Kreiiert Entität Abzeichen mit allen Attributen und einem eineindeutigen Schlüssel 
CREATE TABLE Abzeichen (
  AbzeichenID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50),
  Beschreibung VARCHAR(255)
);

-- Kreiiert Entität Benutzerabzeichen mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE BenutzerAbzeichen (
  BenutzerAbzeichenID INT PRIMARY KEY AUTO_INCREMENT,
  BenutzerID INT,
  AbzeichenID INT,
  Datum DATE,
  FOREIGN KEY (BenutzerID) REFERENCES Benutzer (BenutzerID),
  FOREIGN KEY (AbzeichenID) REFERENCES Abzeichen (AbzeichenID)
);

-- Kreiiert Entität Meldung mit allen Attributen, einem eineindeutigen Schlüssel und den Fremdschlüsseln (mussten vorher erstellt werden)
CREATE TABLE Meldung (
  MeldungID INT PRIMARY KEY AUTO_INCREMENT,
  BenutzerID INT,
  BetroffenerBenutzerID INT,
  ExemplarID INT,
  Beschreibung TEXT,
  Datum DATE,
  Status ENUM('offen','in Bearbeitung','abgeschlossen'),
  FOREIGN KEY (BenutzerID) REFERENCES Benutzer (BenutzerID),
  FOREIGN KEY (BetroffenerBenutzerID) REFERENCES Benutzer (BenutzerID),
  FOREIGN KEY (ExemplarID) REFERENCES Exemplar (ExemplarID)
);

-- Statuswerte für Ausleihe festlegen
ALTER TABLE Ausleihe 
  MODIFY Status ENUM('angefragt','aktiv','abgeschlossen') NOT NULL;

-- Statuswerte für Meldung festlegen
ALTER TABLE Meldung 
  MODIFY Status ENUM('offen','in Bearbeitung','abgeschlossen') NOT NULL;

-- Sicherstellen, dass MaxLeihdauer positiv ist
ALTER TABLE Exemplar 
  ADD CONSTRAINT chk_MaxLeihdauer CHECK (MaxLeihdauer > 0);

-- Sicherstellen, dass Sterne-Bewertung zwischen 1 und 5 liegt
ALTER TABLE Bewertung 
  ADD CONSTRAINT chk_Sterne CHECK (Sterne BETWEEN 1 AND 5);

-- Prüfen, dass Enddatum nicht vor Startdatum liegt
ALTER TABLE Ausleihe 
  ADD CONSTRAINT chk_Datum CHECK (Enddatum >= Startdatum);

-- Verhindert doppelte Einträge in Merkliste pro Benutzer und Buch
ALTER TABLE Merkliste 
  ADD CONSTRAINT unique_merkliste UNIQUE (BenutzerID, BuchID);

-- Verknüpft Bewertung mit einer Ausleihe
ALTER TABLE Bewertung 
  ADD COLUMN AusleiheID INT,
  ADD FOREIGN KEY (AusleiheID) REFERENCES Ausleihe(AusleiheID);

-- Standardwert für Benutzer auf aktiv setzen
ALTER TABLE Benutzer 
  MODIFY Aktiv BOOLEAN DEFAULT TRUE;

-- Standardwert für Exemplar auf aktiv setzen
ALTER TABLE Exemplar 
  MODIFY Aktiv BOOLEAN DEFAULT TRUE;
  
  -- Passt Status-Spalte in Ausleihe an und setzt Standardwert auf 'angefragt'
ALTER TABLE Ausleihe 
MODIFY COLUMN Status ENUM('angefragt','aktiv','abgeschlossen') 
DEFAULT 'angefragt';

-- Fügt Prüfkriterium hinzu, das sicherstellt, dass Sterne nur zwischen 1 und 5 liegen
ALTER TABLE Bewertung
ADD CONSTRAINT chk_sterne_range
CHECK (Sterne BETWEEN 1 AND 5);

-- Index auf BuchID, weil viele Tabellen danach filtern
CREATE INDEX idx_exemplar_buch ON Exemplar(BuchID);

-- Index auf BenutzerID, da häufig für Besitzer, Entleiher, Bewertungen etc. genutzt
CREATE INDEX idx_exemplar_benutzer ON Exemplar(BenutzerID);
CREATE INDEX idx_ausleihe_entleiher ON Ausleihe(EntleiherID);
CREATE INDEX idx_bewertung_benutzer ON Bewertung(BenutzerID);

-- Index auf Statusspalten für Filter und Reports
CREATE INDEX idx_ausleihe_status ON Ausleihe(Status);
CREATE INDEX idx_meldung_status ON Meldung(Status);

-- Index auf Datum für zeitliche Sortierungen
CREATE INDEX idx_ausleihe_datum ON Ausleihe(Startdatum);
CREATE INDEX idx_bewertung_datum ON Bewertung(Datum);

-- BenutzerInnen für die Anwendung erstellen
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user1';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin1';
CREATE USER 'guest'@'localhost' IDENTIFIED BY 'guest1';

-- Rechte für user: Standard-Nutzer mit eingeschränkten Schreibrechten
GRANT SELECT, INSERT, UPDATE ON buchtausch_app.Benutzer TO 'user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON buchtausch_app.Exemplar TO 'user'@'localhost';
GRANT SELECT, INSERT ON buchtausch_app.Ausleihe TO 'user'@'localhost';
GRANT SELECT, INSERT ON buchtausch_app.Bewertung TO 'user'@'localhost';
GRANT SELECT, INSERT ON buchtausch_app.Merkliste TO 'user'@'localhost';
GRANT SELECT ON buchtausch_app.Buch TO 'user'@'localhost';

-- Rechte für admin: Vollzugriff auf gesamte Datenbank
GRANT ALL PRIVILEGES ON buchtausch_app.* TO 'admin'@'localhost';

-- Rechte für guest: Nur Lesezugriff auf öffentliche Tabellen
GRANT SELECT ON buchtausch_app.Buch TO 'guest'@'localhost';
GRANT SELECT ON buchtausch_app.Autor TO 'guest'@'localhost';
GRANT SELECT ON buchtausch_app.Verlag TO 'guest'@'localhost';
GRANT SELECT ON buchtausch_app.Genre TO 'guest'@'localhost';
GRANT SELECT ON buchtausch_app.Bewertung TO 'guest'@'localhost';

-- Änderungen an Berechtigungen übernehmen
FLUSH PRIVILEGES;
