# Buchtausch-datenbank
Relationale MySQL-Datenbank zur Buchtausch-App (Uniprojekt)

Projektbeschreibung
Dieses Projekt umfasst die Konzeption, Implementierung und Testung einer relationalen Daten-bank, die als Grundlage für eine fiktive Buchtausch-App dient. Die Datenbank bildet den kompletten Buchverleihprozess ab, von der Registrierung der BenutzerInnen über die Verwaltung von Büchern und Exemplaren bis hin zu Ausleihe, Bewertung, Meldung und Abzeichenvergabe.

Technische Umsetzung
•	Datenbankmanagementsystem: MySQL (Version 8.x)
•	Entwicklungsumgebung: MySQL Workbench
•	Tabellenanzahl: 15
•	Datensätze: über 200
•	Struktur: vollständig normalisiert (3. Normalform)

Wichtige Merkmale
•	ENUMs für Statusfelder (z. B. Ausleihe, Meldung)
•	CHECK-Constraint für Sternebewertungen (1–5)
•	Soft-Delete-Logik über das Feld Aktiv
•	Lookup-Tabellen für Genre, Sprache, Verlag, Land
•	Indizes auf häufig genutzte Spalten (z. B. BuchID, BenutzerID, Status)
•	Fremdschlüssel mit referenzieller Integrität

Funktionsbereiche
•	Benutzerverwaltung: Benutzer, Adresse, Land, BenutzerAbzeichen
•	Bibliothekslogik: Buch, Autor, Verlag, Genre, Sprache, Exemplar, BuchAutor
•	Prozesslogik: Ausleihe, Bewertung, Merkliste, Meldung

Testfälle
Zu jeder Entität wurde ein Testfall mit SQL-SELECT-Abfrage und Ergebnis entwickelt.
Ein End-to-End-Test simuliert den kompletten Buchverleihprozess (Suche → Ausleihe → Rückga-be → Bewertung → Meldung → Abzeichenvergabe).

Installation
1.	Repository herunterladen oder klonen:
2.	git clone https://github.com/Olifaentli/Buchtausch-datenbank
3.	Öffnen in MySQL Workbench
4.	SQL-Dateien in folgender Reihenfolge ausführen:
  o	schema.sql (Tabellenerstellung)
  o	inserts.sql (Beispieldaten einfügen)
  o	tests.sql (Entitätentests)
  o	endtoend.sql (Prozesstest)
