/*
Zunächst sehen wir uns die ersten 1000 Einträge zur Sichtung der Daten an. */
SELECT *
FROM 202109_divvy_tripdata
LIMIT 1000;


/*
Wir überprüfen als Erstes, ob sich in einer Tabelle Duplikate befinden.
Es werden die ride_ids einzeln gezählt. Sollte eine ride_id doppelt vorhanden sein (Zähler größer 1), wird diese ride_id ausgegeben. */
SELECT
	ride_id,
	COUNT(ride_id)
FROM 202109_divvy_tripdata
GROUP BY ride_id
HAVING COUNT(ride_id)>1;
-- Es sind keine Duplikate vorhanden.


/*
Bei der Sichtung der Daten ist aufgefallen, dass mehrere Einträge "test" oder "testing" in Stationsnamen haben. 
Wir schauen uns zunächst an, wie viele Einträge tatsächlich "test" in einem der Stationsnamen haben. */
SELECT *
FROM 202109_divvy_tripdata
WHERE
	start_station_name LIKE "%test%"
OR end_station_name LIKE "%test%";


/*
Für diese Analyse nehmen wir an, dass wir diese Testdaten aus den Datensätzen entfernen dürfen. */
DELETE
FROM 202109_divvy_tripdata
WHERE
	start_station_name LIKE "%test%"
OR end_station_name LIKE "%test%";


/*
Weiter ist bei der Sichtung der Daten aufgefallen, dass einige Null-Werte in den Stationsnamen vorhanden sind. 
Da diese für die weitere Betrachtung nicht von Bedeutung sind, werden an dieser Stelle keine Änderungen vorgenommen.
Wir überprüfen, ob sich in relevanten Spalten NULL-Werte befinden. */
SELECT *
FROM 202109_divvy_tripdata
WHERE
	ride_id = ""
	OR rideable_type = ""
	OR started_at IS NULL
	OR ended_at IS NULL
	OR member_casual = "";
-- Es befinden sich keine NULL-Werte in den relevanten Spalten. 


/*
zusätzlich überprüfen wir, dass in einer Tabelle keine anderen Einträge als "casual" und "member" für Kundentypen eingetragen sind. */
SELECT DISTINCT rideable_type
FROM 202109_divvy_tripdata;
-- Es sind keine anderen Einträge als "casual" und "member" vorhanden. 


/*
Als nächstes überprüfen wir die Logik der Daten. Wir überprüfen, ob alle Endzeiten nach den Startzeiten liegen.
Dazu berechnen wir die Fahrzeit und überprüfen, ob negative Einträge in der Fahrzeit vorhanden sind.  */
SELECT *
FROM 
( 
	SELECT
		started_at AS starttime,
	 	ended_at AS endtime,
		TIMESTAMPDIFF(SECOND, started_at, ended_at) AS ride_duration
	FROM 202109_divvy_tripdata
) AS logic_check_table 
WHERE ride_duration < 0
-- Es gibt mehrere Zeilen mit rechnerisch negativen Fahrzeiten. 


/*
Zum Zwecke dieser Analyse nehmen wir an, dass sich nach Rücksprache herausgestellt hat, dass für die oberen Zeilen die Startzeit und Endzeit vertauscht wurden.
Wir sollen für die betroffenen Zeilen die Daten entsprechend bearbeiten, dass die Zeiten wieder in der richtigen Reihenfolge eingetragen sind.
Dazu nutzen wir zunächst eine temporäre Tabelle, um sicherzustellen, dass die Abfrage funktioniert. */

CREATE TEMPORARY TABLE time_change_check 
SELECT * 
FROM 202109_divvy_tripdata;

-- wir fügen eine Spalte als Platzhalter hinzu
ALTER TABLE time_change_check
ADD COLUMN starttime DATETIME;

-- für Zeilen, die eine negative Fahrzeit haben, machen wir die Startzeit zur Endzeit und umgekehrt. 
UPDATE time_change_check
SET 
	starttime = started_at,
	started_at = ended_at,
	ended_at = starttime
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) < 0;

-- Anschließend entfernen wir die Platzhalter-Spalte wieder. 
ALTER TABLE time_change_check
DROP COLUMN starttime;


/*
Es existiert nun eine temporäre Tabelle.
Wir vergleichen die Werte der temporären Tabelle mit denen der alten Tabelle für die Stellen, bei denen die Fahrzeit in der Original-Tabelle negativ ist.
Es werden die Startzeiten und Endzeiten und die berechnete Fahrzeit beider Tabellen abgefragt und die ride_id wird als Vergleichspunkt genutzt. */
SELECT 
	202109_divvy_tripdata.ride_id,
	202109_divvy_tripdata.started_at AS original_start,
	202109_divvy_tripdata.ended_at AS original_end,
	time_change_check.started_at AS changed_start,
	time_change_check.ended_at AS changed_end,
	TIMESTAMPDIFF(SECOND, 202109_divvy_tripdata.started_at, 202109_divvy_tripdata.ended_at) AS original_ride_duration,
	TIMESTAMPDIFF(SECOND, time_change_check.started_at, time_change_check.ended_at) AS changed_ride_duration
FROM 
	202109_divvy_tripdata
INNER JOIN 
	time_change_check
ON 202109_divvy_tripdata.ride_id = time_change_check.ride_id
WHERE TIMESTAMPDIFF(SECOND, 202109_divvy_tripdata.started_at, 202109_divvy_tripdata.ended_at) < 0
ORDER BY TIMESTAMPDIFF(SECOND, time_change_check.started_at, time_change_check.ended_at) DESC;
-- Die Änderungen wurden korrekt durchgeführt wurden.
-- wir wenden die obere Abfrage zum Tauschen der Spalteneinträge auf alle Tabellen an. 




/*
Die benötigten Daten sind nun bereinigt. Wir können mit der Analyse beginnen. 

Wir schauen uns zunächst die minimale, maximale und durchschnittliche Fahrzeit nach Kundentypen an. 
Alle folgenden Abfragen wollen wir nur auf relevante Spalten beziehen. 
Zu diesem Zweck erzeugen wir eine temporäre Tabelle mit ausschließlich den für uns wichtigen Spalten, um die Abfragen übersichtlicher und effizienter zu halten.
Alle Zeiten werden auf 2 Nachkommastellen gerundet. */


-- Erzeugen der Temporären Tabelle mit dem Namen RideDuration  
CREATE TEMPORARY TABLE RideDuration
SELECT ride_id,
	rideable_type,
	started_at,
	ended_at,
	member_casual,
	ROUND(TIMESTAMPDIFF(SECOND, started_at, ended_at)/60, 2) AS ride_time_minutes -- "Minute" in Timestampdiff würde nur ganze Minuten angeben, was nicht fein genug ist, weshalb wir Second / 60 nehmen.
FROM 202109_divvy_tripdata; 

-- Maximale Mietdauer nach members und casuals
SELECT 
	member_casual,
	ROUND(MAX(ride_time_minutes)/60/24, 2) AS max_ride_time_days -- die Berechnung auf Tage zeigte sich sinnvoll.  
FROM RideDuration
GROUP BY member_casual;  
  
-- minimale Mietdauer nach members und casuals
SELECT 
	member_casual,
	MIN(ride_time_minutes) AS min_ride_time_minutes
FROM RideDuration
GROUP BY member_casual;

-- durchschnittliche Mietdauer nach members und casuals
SELECT
	member_casual,
	ROUND(AVG(ride_time_minutes), 2) AS avg_ride_time_minutes
FROM RideDuration
GROUP BY member_casual;   
  
 
/*  
Wir wollen uns ebenfalls die Fahrzeiten der Kundentypen am Wochenende und an Arbeitstagen ansehen.
in der WEEKDAY() Abfrage steht 0 für Montag und 6 für Sonntag. 5 und 6 sind somit das Wochenende.  */ 

-- Mietdauer nach Nutzertyp am Wochenende 
SELECT
	member_casual,
	ROUND(AVG(ride_time_minutes), 2) AS weekend_ridetime_minutes
FROM RideDuration
WHERE WEEKDAY(started_at) = 5
	OR WEEKDAY(started_at) = 6
GROUP BY member_casual; 

-- Mietdauer nach Nutzertyp an Arbeitstagen
SELECT
	member_casual,
	ROUND(AVG(ride_time_minutes), 2) AS workday_ridetime_minutes
FROM RideDuration
WHERE WEEKDAY(started_at) = 4
	OR WEEKDAY(started_at) = 3
	OR WEEKDAY(started_at) = 2
	OR WEEKDAY(started_at) = 1
	OR WEEKDAY(started_at) = 0
GROUP BY member_casual; 
  
  
/*
Abschließend erscheint es noch interessant zu wissen, wie die Gesamtzahl der Kundentypen zwischen Wochenende und Arbeitstagen aufgeteilt ist. */
 
-- Anzahl an Fahrten durch Casuals und Members insgesamt 
SELECT
	member_casual AS member_type,
	COUNT(member_casual) AS quantity
FROM RideDuration
GROUP BY member_type;

-- Anzahl an Fahrten durch Casuals und Members am Wochenende 
SELECT
	member_casual AS member_type,
	COUNT(member_casual) AS quantity
FROM RideDuration
WHERE 
	WEEKDAY(started_at) = 5
	OR WEEKDAY(started_at) = 6
GROUP BY member_casual;

-- Anzahl an Fahrten durch Casuals und Members an Arbeitstagen
SELECT
	member_casual AS member_type,
	COUNT(member_casual) AS quantity
FROM RideDuration
WHERE WEEKDAY(started_at) = 4
	OR WEEKDAY(started_at) = 3
	OR WEEKDAY(started_at) = 2
	OR WEEKDAY(started_at) = 1
	OR WEEKDAY(started_at) = 0
GROUP BY member_casual; 
