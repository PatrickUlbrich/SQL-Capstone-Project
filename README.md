Es handelt sich hierbei um das Abschlussprojekt (Capstone Project) für das Google Data Analytics Zertifikat. 
Hauptsächlich wurder SQL für das Projekt genutzt. 


## Szenario
In diesem Szenario sind wir ein Data Analyst bei einem fiktiven Bike-Sharing Unternehmen in Chicago. Die Marketingdirektorin glaubt, dass der zukünftige Unternehmenserfolg davon abhängt möglichst viele Jahresmitgliedschaften mit den Kunden abzuschließen. Aus diesem Grund sollen die Unterschiede im Verhalten zwischen „Members“ (Kunden mit Jahresmitgliedschaften) und „Casuals“ (gelegentliche Nutzer, Einzelfahrten oder Tagespässe) herausgefunden werden.

Aus diesen Erkenntnissen sollen Empfehlungen für die Marketing-Abteilung abgeleitet werden. 

## Das Unternehmen
Das Unternehmen hat 5824 Fahrräder in einem Netzwerk aus 692 Stationen. Die Fahrräder können an jeder Station geliehen und an jeder beliebigen Station zu jeder Zeit wieder abgestellt werden. Das Marketing bezog sich bisher hauptsächlich auf Erhöhung der allgemeinen Bekanntheit des Unternehmens. 

## Hauptfragen
1. Wie unterscheiden sich die Kunden mit Jahresmitgliedschaft von den gelegentlichen Nutzern?
2. Was sind die Empfehlungen für das Marketing auf Basis dieser Erkenntnisse? 

## Daten
Die Daten stammen von Motivate International Inc., einem tatsächlichen Betreiber eines bike-sharing Unternehmens in Chicago. https://divvy-tripdata.s3.amazonaws.com/index.html 

Die Daten sind unter folgender Lizenz allgemein verfügbar. https://www.divvybikes.com/data-license-agreement 

## Vorbereitung der Daten
Es werden die Daten der letzten 12 Monate genutzt (Oktober 2020 bis September 2021). Diese sind in einzelnen Monaten organisiert. Die Daten wurden vom Unternehmen selbst erhoben. 
Wir nutzen SQL für diese Untersuchung. Dazu wurden die Daten in eine MySQL Datenbank übertragen. 

## Bereinigung und Analyse der Daten
Die weiteren Schritte der Bereinigung und der Analyse der Daten mit Kommentaren zu den Gedanken hinter dem Vorgehen sind in der .sql Datei zu finden. Jeder Monat wurde dabei einzeln betrachtet. 

## Visualisierung 
Eine einfache Visualisierung der Ergebnisse ist auf Tableau Public verfügbar. In dieser Visualisierung sind die bereinigten Daten für den Datensatz 202109 enthalten.

https://public.tableau.com/app/profile/patrick5127/viz/NutzerverhaltenUnterschiede/Dashboard1 

## Hauptunterschiede zwischen den beiden Kundentypen
Die Aufgabe bestand darin die Unterschiede im Nutzerverhalten zwischen den beiden Kundentypen aufzudecken. Die obere Analyse wurde für alle Monatsdaten durchgeführt. 
Außer für Dezember (wahrscheinlich Weihnachtsgeschäft, Fahrzeiten bei Casuals im Schnitt 3,6x, bei Membern sogar 7x länger als in allen anderen Monaten) zeigte sich stets ein sehr ähnliches Bild bei der Betrachung des Verhaltens der beiden Kundentypen. 

Die hauptsächlichen Unterschiede zwischen den beiden Kundentypen sind:
1. Member nutzen die Fahrräder bereits für deutlich kürzere Zeiten (im Schnitt etwa 14 Minuten zu 28 Minuten bei Casuals)
2. Member nutzen die Fahrräder anteilig deutlich mehr an Arbeitstagen als am Wochenende (an Arbeitstagen etwa: 57% Member, 43% Casuals; am Wochenende: 40% Member und 60% Casuals)

## Empfehlungen für das Marketing
Aus der Analyse und der Visualisierung lassen sich zwei Dinge klar erkennen: 
1. Das Marketing sollte für Casusls die Vorteile des Systems für kürzere Strecken und kürzere Zeiten in den Vordergrund stellen.
2. Das Marketing sollte für Casuals insbesondere eine Nutzung auch an Arbeitstagen in den Vordergrund stellen. 

## Ideen und weitere Schritte 
Der hohe Anteil der Member an Arbeitstagen lässt darauf schließen, dass diese das System möglicherweise zum Pendeln nutzen, was ein guter Punkt für das Marketing ist. Es könnten im Marketing Aussagen zu einem stressfreierem Pendeln, einer niedrigeren CO2-Belastung, den gesundheitlichen Vorteilen und dem Wegfall von Ängsten in Bezug auf Fahrraddiebstahl oder Ähnliches dem Kunden vermittelt werden. Es sollte vorher noch in Nachforschungen bestätigt werden, dass der höhere Anteil der Member an Arbeitstagen tatsächlich aufs Pendeln zurückzuführen ist.

Ebenfalls könnten Member befragt werden, für welche Kurzstrecken sie das System nutzen, um die Erkenntnisse mit in eine Marketingkampagne an Casuals einzubauen. 
