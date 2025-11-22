-- Zeigt alle aktiven und neuen Exemplare, die aktuell nicht ausgeliehen sind
SELECT 
  e.ExemplarID,
  b.Titel,
  s.Bezeichnung AS Sprache,
  ben.Name AS Besitzer,
  e.Zustand,
  e.Versandoption
FROM Exemplar e
JOIN Buch b ON e.BuchID = b.BuchID
JOIN Sprache s ON e.SpracheID = s.SpracheID
JOIN Benutzer ben ON e.BenutzerID = ben.BenutzerID
WHERE e.Aktiv = TRUE
  AND Zustand = 'Neu'
  AND e.ExemplarID NOT IN (
    SELECT ExemplarID FROM Ausleihe WHERE Status = 'aktiv'
  );

-- Erstellt neue Ausleihe mit aktuellem Datum und Rückgabefrist von 5 Tagen
INSERT INTO Ausleihe (ExemplarID, EntleiherID, Startdatum, Enddatum, Status)
VALUES (3, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'aktiv');

-- Markiert eine bestehende Ausleihe als abgeschlossen und setzt Rückgabedatum auf heute
UPDATE Ausleihe
SET Rueckgabedatum = CURDATE(),
    Status = 'abgeschlossen'
WHERE AusleiheID = 1;

-- Fügt Bewertung zu einem Buch hinzu, wo 5 Sterne, positiver Kommentar
INSERT INTO Bewertung (BenutzerID, BuchID, Sterne, Kommentar, Datum)
VALUES (2, 1, 5, 'Super Zustand, schnelle Übergabe!', CURDATE());

-- Erstellt neue Meldung über beschädigtes Exemplar bei Rückgabe
INSERT INTO Meldung (BenutzerID, BetroffenerBenutzerID, ExemplarID, Beschreibung, Datum, Status)
VALUES (2, 1, 3, 'Buchrücken leicht beschädigt bei Rückgabe.', CURDATE(), 'offen');

-- Setzt den Status einer Meldung auf abgeschlossen
UPDATE Meldung
SET Status = 'abgeschlossen'
WHERE MeldungID = 1;

-- Verleiht einem Benutzer ein neues Abzeichen
INSERT INTO BenutzerAbzeichen (BenutzerID, AbzeichenID, Datum)
VALUES (2, 1, CURDATE());

-- Zeigt alle abgeschlossenen Ausleihen mit Buch, Besitzer, Entleiher, Rückgabedatum, Bewertungen und Meldestatus, sortiert nach Rückgabedatum
-- Dient zur Überprüfung, ob der End to End Test funktioniert hat
SELECT 
  a.AusleiheID,
  b.Titel AS Buch,
  besitzer.Name AS Besitzer,
  entleiher.Name AS Entleiher,
  a.Startdatum,
  a.Enddatum,
  a.Rueckgabedatum,
  ROUND(AVG(bew.Sterne),1) AS Durchschnittsbewertung,
  COUNT(bew.BewertungID) AS Anzahl_Bewertungen,
  CASE 
    WHEN m.MeldungID IS NOT NULL THEN 'Meldung vorhanden'
    ELSE 'Keine Meldung'
  END AS Meldestatus
FROM Ausleihe a
JOIN Exemplar e ON a.ExemplarID = e.ExemplarID
JOIN Buch b ON e.BuchID = b.BuchID
JOIN Benutzer besitzer ON e.BenutzerID = besitzer.BenutzerID
JOIN Benutzer entleiher ON a.EntleiherID = entleiher.BenutzerID
LEFT JOIN Bewertung bew ON bew.BuchID = b.BuchID
LEFT JOIN Meldung m ON m.ExemplarID = e.ExemplarID
WHERE a.Status = 'abgeschlossen'
GROUP BY a.AusleiheID, b.Titel, besitzer.Name, entleiher.Name, 
         a.Startdatum, a.Enddatum, a.Rueckgabedatum, m.MeldungID
ORDER BY a.Rueckgabedatum DESC;

