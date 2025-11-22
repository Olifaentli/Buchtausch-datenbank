-- Beispieldaten für Entität Land
INSERT INTO Land (Name, Nationalitaet) VALUES
('Schweiz', 'Schweizerisch'),
('Deutschland', 'Deutsch'),
('Österreich', 'Österreichisch'),
('Frankreich', 'Französisch'),
('Italien', 'Italienisch'),
('Vereinigtes Königreich', 'Britisch'),
('USA', 'Amerikanisch'),
('Spanien', 'Spanisch'),
('Norwegen', 'Norwegisch'),
('Niederlande', 'Niederländisch');

-- Beispieldaten für Entität Genre
INSERT INTO Genre (Bezeichnung) VALUES
('Fantasy'),
('Liebesroman'),
('Krimi'),
('Historischer Roman'),
('Sachbuch'),
('Gegenwartsliteratur'),
('Science-Fiction'),
('Thriller'),
('Biografie'),
('Kinderbuch');

-- Beispieldaten für Entität Verlag
INSERT INTO Verlag (Name) VALUES
('Carlsen Verlag'),
('Klett-Cotta Verlag'),
('Rowohlt Verlag'),
('Heyne Verlag'),
('Blanvalet Verlag'),
('Bastei Lübbe Verlag'),
('Diogenes Verlag'),
('Luchterhand Literaturverlag'),
('Goldmann Verlag'),
('Fischer Verlag');

-- Beispieldaten für Entität Sprache
INSERT INTO Sprache (Bezeichnung) VALUES
('Deutsch'),
('Englisch'),
('Französisch'),
('Italienisch'),
('Spanisch'),
('Niederländisch'),
('Portugiesisch'),
('Norwegisch'),
('Schwedisch'),
('Japanisch');

-- Beispieldaten für Entität Abzeichen
INSERT INTO Abzeichen (Name, Beschreibung) VALUES
('Leseratte', 'Hat mindestens 5 Bücher ausgeliehen oder gelesen – eine echte Leseratte!'),
('ErstleserIn', 'Erste Ausleihe erfolgreich abgeschlossen – willkommen in der Buchwelt!'),
('Top-VerleiherIn', 'Hat 5 oder mehr Bücher an andere verliehen – teilt gern und oft!'),
('DauerleserIn', 'Seit über einem Jahr aktiv auf der Plattform – treue Seele!'),
('KritikerIn', 'Mindestens 5 Bewertungen abgegeben – liebt es, Feedback zu geben!'),
('HelferIn', 'Hat anderen NutzerInnen geholfen oder eine Meldung geklärt – echtes Community-Mitglied!'),
('BücherheldIn', 'Mehr als 10 Ausleihen oder Bewertungen – unsere SuperheldIn des Lesens!'),
('PhilosophIn', 'Verfasst besonders nachdenkliche oder ausführliche Bewertungen – tiefgründig!'),
('SammlerIn', 'Hat Bücher in mehreren Formaten (Hardcover, E-Book, Taschenbuch) – liebt Vielfalt!'),
('BuchtrödlerIn', 'Gibt Bücher immer mit Stil, aber etwas verspätet zurück – unsere gemütliche Schildkröte!');

-- Erstellt für die Entität Autor Beispieldaten inkl. Fremdschlüssel zu Land (diese mussten vorher erstellt werden)
INSERT INTO Autor (Name, Geburtsjahr, LandID) VALUES
('J. K. Rowling', 1965, 6),        
('J. R. R. Tolkien', 1892, 6),     
('Patrick Rothfuss', 1973, 7),     
('Kyra Groh', 1990, 2),            
('Nicholas Sparks', 1965, 7),      
('Christine Brand', 1973, 1),      
('Pedro Lenz', 1965, 1),           
('Ken Follett', 1949, 6),          
('Juli Zeh', 1974, 2),             
('Noemi Harnickell', 1992, 1);     

-- Erstellt für die Entität Adresse Beispieldaten inkl. Fremdschlüssel zu Land (diese mussten vorher erstellt werden)
INSERT INTO Adresse (Strasse, PLZ, Ort, LandID, Breitengrad, Laengengrad) VALUES
('Bahnhofstrasse 12', '8001', 'Zürich', 1, 47.3769, 8.5417),
('Bundesplatz 5', '3005', 'Bern', 1, 46.9480, 7.4474),
('Rheingasse 20', '4058', 'Basel', 1, 47.5596, 7.5886),
('Pilatusweg 8', '6003', 'Luzern', 1, 47.0502, 8.3093),
('Mönckebergstrasse 15', '20095', 'Hamburg', 2, 53.5511, 9.9937),
('Leopoldstrasse 50', '80802', 'München', 2, 48.1351, 11.5820),
('Kaiserstrasse 10', '60329', 'Frankfurt', 2, 50.1109, 8.6821),
('Königstrasse 45', '70173', 'Stuttgart', 2, 48.7758, 9.1829),
('Rue de Lyon 4', '1201', 'Genf', 1, 46.2044, 6.1432),
('Via Roma 9', '10121', 'Turin', 5, 45.0703, 7.6869);

-- Erstellt für die Entität Benutzer Beispieldaten inkl. Fremdschlüssel zu Adresse (diese musste vorher erstellt werden)
INSERT INTO Benutzer (Name, Email, Passwort, AdresseID, Registrierungsdatum, Aktiv) VALUES
('Harry Potter', 'harry.potter@hogwarts.com', 'pw1', 1, '2023-01-15', TRUE),
('Hermione Granger', 'hermione.granger@hogwarts.com', 'pw2', 2, '2023-03-20', TRUE),
('Ron Weasley', 'ron.weasley@hogwarts.com', 'pw3', 3, '2022-12-05', TRUE),
('Ginny Weasley', 'ginny.weasley@hogwarts.com', 'pw4', 4, '2023-05-01', TRUE),
('Luna Lovegood', 'luna.lovegood@hogwarts.com', 'pw5', 5, '2022-08-11', FALSE),
('Neville Longbottom', 'neville.longbottom@hogwarts.com', 'pw6', 6, '2023-06-22', TRUE),
('Draco Malfoy', 'draco.malfoy@hogwarts.com', 'pw7', 7, '2022-11-18', FALSE),
('Cho Chang', 'cho.chang@hogwarts.com', 'pw8', 8, '2023-02-28', TRUE),
('Minerva McGonagall', 'minerva.mcgonagall@hogwarts.com', 'pw9', 9, '2023-07-10', TRUE),
('Rubeus Hagrid', 'rubeus.hagrid@hogwarts.com', 'pw0', 10, '2023-04-04', TRUE); 

-- Erstellt die Zwischentabelle für Abzeichen und Benitzer (n-m Beziehung, mit dieser Tabelle als Zwischentabelle), auch diese mussten beide vorher erstellt werden
INSERT INTO BenutzerAbzeichen (BenutzerID, AbzeichenID, Datum) VALUES
(1, 7, '2024-10-28'),  
(2, 5, '2024-10-28'), 
(3, 2, '2024-10-28'),  
(4, 1, '2024-10-28'),
(5, 8, '2024-10-28'), 
(6, 4, '2024-10-28'), 
(7, 10, '2024-10-28'), 
(8, 9, '2024-10-28'), 
(9, 6, '2024-10-28'),  
(10, 3, '2024-10-28'); 

-- Erstellt für die Entität Buch Beispieldaten inkl. Fremdschlüssel zu Verlag und Genre (diese mussten vorher erstellt werden)
INSERT INTO Buch (Titel, VerlagID, GenreID, Erscheinungsjahr) VALUES
('Harry Potter und der Stein der Weisen', 1, 1, 1997),
('Harry Potter und die Kammer des Schreckens', 1, 1, 1998),
('Der Herr der Ringe: Die Gefährten', 2, 1, 1954),
('Der Name des Windes', 2, 1, 2007),
('Tage zum Sternepflücken', 3, 2, 2019),
('Wie ein einziger Tag', 4, 2, 1996),
('Blind', 5, 3, 2019),
('Die Säulen der Erde', 6, 4, 1989),
('Der Goalie bin ig', 7, 6, 2010),
('Über Menschen', 8, 6, 2021),
('Selbstbestimmt leben', 9, 5, 2020);

-- Erstellt für die Entität Merkliste Beispieldaten inkl. Fremdschlüssel zu Benutzer und Buch (diese mussten vorher erstellt werden)
INSERT INTO Merkliste (BenutzerID, BuchID, Datum) VALUES
(2, 3, '2024-10-10'), 
(3, 1, '2024-09-05'), 
(4, 2, '2024-10-01'), 
(6, 4, '2024-10-02'),  
(5, 5, '2024-09-20'),  
(8, 6, '2024-10-05'),  
(10, 5, '2024-10-08'), 
(7, 7, '2024-09-25'),  
(1, 7, '2024-10-10'),  
(9, 8, '2024-10-12'),  
(2, 10, '2024-10-18'), 
(5, 11, '2024-10-20'); 

-- Erstellt die Zwischentabelle für Buch und Autor (n-m Beziehung, mit dieser Tabelle als Zwischentabelle), auch diese mussten beide vorher erstellt werden
INSERT INTO BuchAutor (BuchID, AutorID) VALUES
(1, 1), 
(2, 1),
(3, 2),
(4, 3), 
(5, 4),  
(6, 5), 
(7, 6), 
(8, 8), 
(9, 7),  
(10, 9), 
(11, 10);

-- Erstellt für die Entität Bewertung Beispieldaten inkl. Fremdschlüssel zu Benutzer und Buch (diese mussten vorher erstellt werden)
INSERT INTO Bewertung (BenutzerID, BuchID, Sterne, Kommentar, Datum) VALUES
(2, 1, 5, 'Tolles Buch! Klassiker, der nie alt wird.', '2024-10-30'),
(3, 2, 4, 'Etwas düsterer als der erste Teil, aber sehr spannend.', '2024-09-01'),
(6, 3, 5, 'Ein Meisterwerk. Lange, aber episch erzählt.', '2024-07-26'),
(5, 4, 5, 'Wunderschön geschrieben, mit poetischer Sprache.', '2024-08-31'),
(4, 5, 4, 'Leicht und emotional – genau das Richtige für den Sommer.', '2024-10-15'),
(3, 9, 3, 'Interessante Sprache, aber etwas gewöhnungsbedürftig.', '2024-08-13'),
(6, 11, 5, 'Inspirierendes Buch – klare Empfehlungen für den Alltag.', '2024-09-19'),
(10, 5, 4, 'Wirklich süß, hat mich überrascht.', '2024-10-11'),
(9, 10, 5, 'Juli Zeh ist genial – starke Charaktere und Tiefe.', '2024-10-26'),
(7, 9, 2, 'Nicht mein Stil. Zu schweizerisch für meinen Geschmack.', '2024-10-15');

-- Erstellt für die Entität Exemplar Beispieldaten inkl. Fremdschlüssel zu Buch, Benutzer und Sprache (diese mussten vorher erstellt werden)
INSERT INTO Exemplar (BuchID, BenutzerID, SpracheID, Medium, Ausgabe, Zustand, MaxLeihdauer, Versandoption, Abholort, Aktiv) VALUES
(1, 1, 1, 'Hardcover', 'Erstausgabe', 'Sehr gut', 30, TRUE, 'Zürich', TRUE),
(1, 2, 2, 'Paperback', 'UK Edition', 'Gebraucht', 21, FALSE, 'Bern', TRUE),
(1, 3, 3, 'Hardcover', 'Französische Ausgabe', 'Neu', 30, TRUE, 'Basel', TRUE),

(2, 1, 1, 'Hardcover', 'Erstausgabe', 'Gebraucht', 30, FALSE, 'Zürich', TRUE),
(2, 4, 2, 'Paperback', 'US Edition', 'Neu', 14, TRUE, 'Luzern', TRUE),
(2, 8, 1, 'E-Book', 'Digitale Ausgabe', 'Neu', 60, TRUE, 'Online', TRUE),

(3, 5, 1, 'Hardcover', 'Sonderausgabe', 'Sehr gut', 45, TRUE, 'Hamburg', TRUE),
(3, 2, 2, 'Paperback', 'UK Edition', 'Gut', 21, FALSE, 'Bern', TRUE),
(3, 7, 1, 'Hardcover', 'Erstausgabe', 'Gebraucht', 60, TRUE, 'Frankfurt', TRUE),

(4, 6, 1, 'Taschenbuch', 'Erstausgabe', 'Sehr gut', 30, TRUE, 'München', TRUE),
(4, 9, 2, 'Hardcover', 'US Edition', 'Neu', 45, TRUE, 'Stuttgart', TRUE),
(4, 10, 1, 'E-Book', 'Digitale Ausgabe', 'Neu', 60, TRUE, 'Online', TRUE),

(5, 3, 1, 'Taschenbuch', 'Standardausgabe', 'Neu', 21, TRUE, 'Basel', TRUE),
(5, 8, 1, 'Hardcover', 'Geschenkedition', 'Sehr gut', 30, TRUE, 'Zürich', TRUE),
(5, 4, 1, 'E-Book', 'Digitale Edition', 'Neu', 60, TRUE, 'Online', TRUE),

(6, 5, 1, 'Taschenbuch', 'Neuauflage 2020', 'Neu', 30, TRUE, 'Hamburg', TRUE),
(6, 6, 2, 'Hardcover', 'Original Edition', 'Gebraucht', 21, FALSE, 'München', TRUE),
(6, 9, 1, 'E-Book', 'Digitale Ausgabe', 'Neu', 45, TRUE, 'Online', TRUE),

(7, 7, 1, 'Taschenbuch', 'Standardausgabe', 'Neu', 21, TRUE, 'Frankfurt', TRUE),
(7, 2, 1, 'Hardcover', 'Sonderausgabe', 'Sehr gut', 45, TRUE, 'Bern', TRUE),
(7, 3, 3, 'Paperback', 'Französische Übersetzung', 'Neu', 30, TRUE, 'Basel', TRUE),

(8, 4, 1, 'Hardcover', 'Erstausgabe', 'Gut', 60, TRUE, 'Luzern', TRUE),
(8, 5, 2, 'Paperback', 'UK Edition', 'Neu', 45, FALSE, 'Hamburg', TRUE),
(8, 1, 1, 'E-Book', 'Digitale Edition', 'Neu', 30, TRUE, 'Online', TRUE),

(9, 6, 1, 'Taschenbuch', 'Erstausgabe', 'Neu', 21, TRUE, 'München', TRUE),
(9, 8, 1, 'Hardcover', 'Signierte Edition', 'Sehr gut', 30, FALSE, 'Zürich', TRUE),
(9, 10, 1, 'E-Book', 'Digitale Ausgabe', 'Neu', 45, TRUE, 'Online', TRUE),

(10, 9, 1, 'Hardcover', 'Erstausgabe', 'Neu', 30, TRUE, 'Stuttgart', TRUE),
(10, 2, 1, 'Taschenbuch', 'Neuauflage', 'Sehr gut', 21, TRUE, 'Bern', TRUE),
(10, 5, 2, 'Paperback', 'UK Edition', 'Neu', 60, TRUE, 'Hamburg', TRUE),

(11, 7, 1, 'Taschenbuch', 'Erstausgabe', 'Neu', 30, TRUE, 'Frankfurt', TRUE),
(11, 8, 1, 'Hardcover', 'Sonderausgabe', 'Sehr gut', 45, TRUE, 'Zürich', TRUE),
(11, 1, 2, 'E-Book', 'Digitale Ausgabe', 'Neu', 60, TRUE, 'Online', TRUE);

-- Erstellt für die Entität Ausleihe Beispieldaten inkl. Fremdschlüssel zu Exemplar und Benutzer (diese mussten vorher erstellt werden)
INSERT INTO Ausleihe (ExemplarID, EntleiherID, Startdatum, Enddatum, Rueckgabedatum, Status) VALUES
(1, 2, '2024-10-01', '2024-10-30', NULL, 'aktiv'),
(2, 3, '2024-08-10', '2024-08-31', '2024-08-29', 'abgeschlossen'),
(5, 4, '2024-09-15', '2024-10-15', NULL, 'aktiv'),
(9, 6, '2024-07-01', '2024-07-25', '2024-07-23', 'abgeschlossen'),
(19, 8, '2024-09-05', '2024-09-25', NULL, 'aktiv'),
(27, 9, '2024-10-05', '2024-10-25', NULL, 'aktiv'),
(10, 5, '2024-08-01', '2024-08-31', '2024-08-30', 'abgeschlossen'),
(13, 10, '2024-09-20', '2024-10-10', NULL, 'aktiv'),
(25, 3, '2024-07-15', '2024-08-15', '2024-08-12', 'abgeschlossen'),
(17, 1, '2024-10-01', '2024-10-20', NULL, 'angefragt'),
(30, 6, '2024-08-20', '2024-09-20', '2024-09-18', 'abgeschlossen'),
(26, 7, '2024-10-01', '2024-10-31', NULL, 'aktiv');

-- Erstellt für die Entität Meldung Beispieldaten inkl. Fremdschlüssel zu Benutzer, Betoffener Benutzer und Buch (diese mussten vorher erstellt werden)
INSERT INTO Meldung (BenutzerID, BetroffenerBenutzerID, ExemplarID, Beschreibung, Datum, Status) VALUES
(7, 1, 1, 'Das Buch wurde zwei Wochen zu spät zurückgegeben.', '2024-10-20', 'offen'),
(2, 3, 2, 'Das Buch kam mit Kaffeeflecken zurück.', '2024-10-15', 'in Bearbeitung'),
(6, 8, 7, 'Benutzerin hat versucht, dasselbe Buch zweimal zu merken.', '2024-10-18', 'abgeschlossen'),
(4, 7, 9, 'Unangebrachter Kommentar in einer Bewertung.', '2024-10-17', 'offen'),
(9, 10, 5, 'Rückgabe war drei Tage zu spät – typisch Hagrid.', '2024-10-16', 'abgeschlossen'),
(1, 2, 4, 'Falsches Exemplar geliefert – vermutlich vertauscht.', '2024-10-19', 'in Bearbeitung'),
(3, 5, 4, 'Spoiler im Bewertungstext – bitte prüfen.', '2024-10-21', 'offen'),
(2, 2, 1, 'Testmeldung – zur Systemprüfung.', '2024-10-14', 'abgeschlossen'),
(10, 7, 3, 'Keine Rückmeldung auf Ausleihanfrage seit 5 Tagen.', '2024-10-22', 'offen'),
(6, 3, 6, 'Falsches Erscheinungsjahr bei Eintrag – bitte korrigieren.', '2024-10-23', 'in Bearbeitung');


