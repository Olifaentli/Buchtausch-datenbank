-- Zeigt alle offenen und in Bearbeitung befindlichen Meldungen mit beteiligten Personen, Buch, Exemplarzustand und Kurzbeschreibung, nach Datum sortiert
SELECT 
  m.MeldungID,
  melder.Name AS Meldende_Person,
  betroffener.Name AS Betroffene_Person,
  b.Titel AS Buch,
  e.Zustand AS Exemplar_Zustand,
  m.Status,
  m.Datum,
  LEFT(m.Beschreibung, 80) AS Kurzbeschreibung
FROM Meldung m
JOIN Benutzer melder ON m.BenutzerID = melder.BenutzerID
LEFT JOIN Benutzer betroffener ON m.BetroffenerBenutzerID = betroffener.BenutzerID
JOIN Exemplar e ON m.ExemplarID = e.ExemplarID
JOIN Buch b ON e.BuchID = b.BuchID
WHERE m.Status IN ('offen','in Bearbeitung')
ORDER BY m.Datum DESC, m.Status;

-- Zeigt alle Benutzer mit ihren Abzeichen, Anzahl, sowie Datum des ersten und letzten Abzeichens, sortiert nach Anzahl absteigend
SELECT 
  ben.Name AS Benutzer,
  GROUP_CONCAT(a.Name ORDER BY a.Name SEPARATOR ', ') AS Abzeichen,
  COUNT(a.AbzeichenID) AS Anzahl_Abzeichen,
  MIN(ba.Datum) AS Erstes_Abzeichen,
  MAX(ba.Datum) AS Letztes_Abzeichen
FROM BenutzerAbzeichen ba
JOIN Benutzer ben ON ba.BenutzerID = ben.BenutzerID
JOIN Abzeichen a ON ba.AbzeichenID = a.AbzeichenID
GROUP BY ben.BenutzerID, ben.Name
HAVING COUNT(a.AbzeichenID) > 0
ORDER BY Anzahl_Abzeichen DESC, ben.Name;

-- Zeigt alle Abzeichen mit Beschreibung länger als 50 Zeichen, inklusive Zeichenanzahl, alphabetisch sortiert
SELECT 
  a.AbzeichenID,
  a.Name AS Abzeichen,
  a.Beschreibung,
  LENGTH(a.Beschreibung) AS Zeichenanzahl
FROM Abzeichen a
WHERE LENGTH(a.Beschreibung) > 50
ORDER BY a.Name;

-- Zeigt alle vorgemerkten Bücher im Oktober mit Benutzer, Genre, Verlag und Datum der Vormerkung, sortiert nach Benutzer und Datum
SELECT 
  ben.Name AS Benutzer,
  b.Titel AS Vorgemerktes_Buch,
  g.Bezeichnung AS Genre,
  v.Name AS Verlag,
  m.Datum AS Vormerkdatum
FROM Merkliste m
JOIN Benutzer ben ON m.BenutzerID = ben.BenutzerID
JOIN Buch b ON m.BuchID = b.BuchID
JOIN Genre g ON b.GenreID = g.GenreID
JOIN Verlag v ON b.VerlagID = v.VerlagID
WHERE m.Datum >= '2024-10-01' AND m.Datum <= '2024-10-31'
ORDER BY ben.Name, m.Datum DESC;

-- Zeigt Bücher mit Bewertungen ab 3 Sternen, inklusive bewertender Person, Durchschnittsbewertung, Anzahl und Datum der letzten Bewertung
SELECT 
  b.Titel AS Buch,
  ben.Name AS Bewertende_Person,
  ROUND(AVG(bew.Sterne),1) AS Durchschnittsbewertung,
  COUNT(bew.BewertungID) AS Anzahl_Bewertungen,
  MAX(bew.Datum) AS Letzte_Bewertung
FROM Bewertung bew
JOIN Buch b ON bew.BuchID = b.BuchID
JOIN Benutzer ben ON bew.BenutzerID = ben.BenutzerID
WHERE bew.Sterne >= 3
GROUP BY b.Titel, ben.Name
HAVING COUNT(bew.BewertungID) > 0
ORDER BY Durchschnittsbewertung DESC, Letzte_Bewertung DESC;

-- Zeigt alle aktiven und abgeschlossenen Ausleihen mit Buch, Besitzer, Entleiher, Leihdauer und Statusbeschreibung. Das neueste zuerst.
SELECT 
  a.AusleiheID,
  b.Titel AS Buch,
  besitzer.Name AS Besitzer,
  entleiher.Name AS Entleiher,
  a.Startdatum,
  a.Enddatum,
  DATEDIFF(a.Enddatum, a.Startdatum) AS Leihdauer_Tage,
  CASE 
    WHEN a.Status = 'aktiv' THEN 'Läuft aktuell'
    WHEN a.Status = 'abgeschlossen' THEN 'Beendet'
    ELSE 'Angefragt'
  END AS Statusbeschreibung
FROM Ausleihe a
JOIN Exemplar e ON a.ExemplarID = e.ExemplarID
JOIN Buch b ON e.BuchID = b.BuchID
JOIN Benutzer besitzer ON e.BenutzerID = besitzer.BenutzerID
JOIN Benutzer entleiher ON a.EntleiherID = entleiher.BenutzerID
WHERE a.Status IN ('aktiv','abgeschlossen')
ORDER BY a.Startdatum DESC;

-- Zeigt alle Exemplare mit Versandoption und gutem Zustand, inkl. Buch, Sprache, Besitzer und Verfügbarkeitsstatus, sortiert nach Titel
SELECT 
  e.ExemplarID,
  b.Titel AS Buch,
  s.Bezeichnung AS Sprache,
  ben.Name AS Besitzer,
  e.Zustand,
  e.Medium,
  e.Ausgabe,
  e.MaxLeihdauer,
  CASE 
    WHEN e.Aktiv = TRUE THEN 'Verfügbar' 
    ELSE 'Inaktiv' 
  END AS Status
FROM Exemplar e
JOIN Buch b ON e.BuchID = b.BuchID
JOIN Sprache s ON e.SpracheID = s.SpracheID
JOIN Benutzer ben ON e.BenutzerID = ben.BenutzerID
WHERE e.Versandoption = TRUE
  AND e.Zustand IN ('Neu', 'Sehr gut')
ORDER BY b.Titel, e.Zustand DESC;

-- Zeigt alle Sprachen mit Anzahl vorhandener Exemplare und zugehöriger Bücher, aber nur Sprachen mit mindestens einem Exemplar
SELECT 
  s.Bezeichnung AS Sprache,
  COUNT(DISTINCT e.ExemplarID) AS Anzahl_Exemplare,
  COUNT(DISTINCT b.BuchID) AS Anzahl_Buecher
FROM Sprache s
LEFT JOIN Exemplar e ON s.SpracheID = e.SpracheID
LEFT JOIN Buch b ON e.BuchID = b.BuchID
GROUP BY s.SpracheID, s.Bezeichnung
HAVING COUNT(e.ExemplarID) > 0
ORDER BY Anzahl_Exemplare DESC, s.Bezeichnung;

-- Zeigt alle AutorInnen mit Anzahl ihrer Bücher und Titelliste aller Werke. Sortiert nach Anzahl Bücher absteigend.
SELECT 
  a.Name AS Autor,
  COUNT(DISTINCT b.BuchID) AS Anzahl_Buecher,
  GROUP_CONCAT(b.Titel SEPARATOR ', ') AS Werke
FROM BuchAutor ba
JOIN Autor a ON ba.AutorID = a.AutorID
JOIN Buch b ON ba.BuchID = b.BuchID
GROUP BY a.AutorID, a.Name
HAVING COUNT(DISTINCT b.BuchID) >= 1
ORDER BY Anzahl_Buecher DESC, a.Name;

-- Zeigt alle Bücher ab Erscheinungsjahr 1990 mit Genre, Verlag und zugehörigen AutorInnen, aufsteigend nach Erscheinungsjahr
SELECT 
  b.Titel AS Buch,
  g.Bezeichnung AS Genre,
  v.Name AS Verlag,
  GROUP_CONCAT(a.Name SEPARATOR ', ') AS AutorInnen,
  b.Erscheinungsjahr
FROM Buch b
JOIN Genre g ON b.GenreID = g.GenreID
JOIN Verlag v ON b.VerlagID = v.VerlagID
JOIN BuchAutor ba ON b.BuchID = ba.BuchID
JOIN Autor a ON ba.AutorID = a.AutorID
WHERE b.Erscheinungsjahr > 1990
GROUP BY b.BuchID, b.Titel, g.Bezeichnung, v.Name, b.Erscheinungsjahr
ORDER BY b.Erscheinungsjahr ASC;

-- Zeigt alle Genres mit Anzahl zugehöriger Bücher und dem durchschnittlichen Erscheinungsjahr, aber nur Genres mit mindestens einem Buch
SELECT 
  g.Bezeichnung AS Genre,
  COUNT(b.BuchID) AS Anzahl_Buecher,
  ROUND(AVG(b.Erscheinungsjahr), 0) AS Durchschnitts_Jahr
FROM Genre g
LEFT JOIN Buch b ON g.GenreID = b.GenreID
GROUP BY g.GenreID, g.Bezeichnung
HAVING COUNT(b.BuchID) > 0
ORDER BY Anzahl_Buecher DESC, g.Bezeichnung;

-- Zeigt alle Verlage mit Anzahl veröffentlichter Bücher sowie Jahr des ersten und letzten Werks, aber nur Verlage mit mindestens einem Buch
SELECT 
  v.Name AS Verlag,
  COUNT(b.BuchID) AS Anzahl_Buecher,
  MIN(b.Erscheinungsjahr) AS Erstes_Werk,
  MAX(b.Erscheinungsjahr) AS Letztes_Werk
FROM Verlag v
LEFT JOIN Buch b ON v.VerlagID = b.VerlagID
GROUP BY v.VerlagID, v.Name
HAVING COUNT(b.BuchID) > 0
ORDER BY Anzahl_Buecher DESC, v.Name;

-- Zeigt alle AutorInnen mit Geburtsjahr vor 1980, ihrem Herkunftsland und der Anzahl veröffentlichter Bücher, sortiert nach Anzahl Werke
SELECT 
  au.Name AS Autor,
  au.Geburtsjahr,
  l.Name AS Herkunftsland,
  COUNT(DISTINCT ba.BuchID) AS Anzahl_Werke
FROM Autor au
JOIN Land l ON au.LandID = l.LandID
LEFT JOIN BuchAutor ba ON au.AutorID = ba.AutorID
LEFT JOIN Buch b ON ba.BuchID = b.BuchID
WHERE au.Geburtsjahr < 1980
GROUP BY au.AutorID, au.Name, au.Geburtsjahr, l.Name
ORDER BY Anzahl_Werke DESC, au.Name;

-- Listet alle Benutzer mit Wohnort und Land auf, zeigt Anzahl ihrer aktiven Ausleihen und ob sie aktiv oder inaktiv sind. Sortiert nach aktiven Ausleihen.
SELECT 
  b.Name AS Benutzername,
  a.Ort AS Wohnort,
  l.Name AS Land,
  COUNT(DISTINCT au.AusleiheID) AS Aktive_Ausleihen,
  CASE 
    WHEN b.Aktiv = TRUE THEN 'Aktiv' 
    ELSE 'Inaktiv' 
  END AS Status
FROM Benutzer b
JOIN Adresse a ON b.AdresseID = a.AdresseID
JOIN Land l ON a.LandID = l.LandID
LEFT JOIN Exemplar e ON b.BenutzerID = e.BenutzerID
LEFT JOIN Ausleihe au ON e.ExemplarID = au.ExemplarID AND au.Status = 'aktiv'
GROUP BY b.BenutzerID, b.Name, a.Ort, l.Name, b.Aktiv
ORDER BY Aktive_Ausleihen DESC, b.Name;

-- Zeigt pro Ort in Schweiz und Deutschland die Anzahl Benutzer, sortiert nach Anzahl absteigend, wobei nur Orte mit mindestens 1 Benutzer
SELECT 
  a.Ort,
  l.Name AS Land,
  COUNT(b.BenutzerID) AS Anzahl_Benutzer
FROM Adresse a
JOIN Land l ON a.LandID = l.LandID
LEFT JOIN Benutzer b ON a.AdresseID = b.AdresseID
WHERE l.Name IN ('Schweiz', 'Deutschland')
GROUP BY a.Ort, l.Name
HAVING COUNT(b.BenutzerID) > 0
ORDER BY Anzahl_Benutzer DESC;

-- Zählt, wie viele Adressen pro Land vorhanden sind und sortiert nach Anzahl absteigend
SELECT 
  l.LandID,
  l.Name AS Land,
  COUNT(a.AdresseID) AS Anzahl_Adressen
FROM Land l
LEFT JOIN Adresse a ON l.LandID = a.LandID
WHERE l.Name IN ('Schweiz', 'Deutschland', 'Italien')
GROUP BY l.LandID, l.Name
ORDER BY Anzahl_Adressen DESC;
