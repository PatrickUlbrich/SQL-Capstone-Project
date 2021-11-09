Es handelt sich hierbei um das Abschlussprojekt (Capstone Project) für das Google Data Analytics Zertifikat. 

# Szenario
In diesem Szenario sind wir ein Data Analyst bei einem fiktiven Bike-Sharing Unternehmen in Chicago. Die Marketingdirektorin glaubt, dass der zukünftige Unternehmenserfolg davon abhängt möglichst viele Jahresmitgliedschaften mit den Kunden abzuschließen. Aus diesem Grund sollen die Unterschiede im Verhalten zwischen „Members“ (Kunden mit Jahresmitgliedschaften) und „Casuals“ (gelegentliche Nutzer, Einzelfahrten oder Tagespässe) herausgefunden werden. Aus diesen Erkenntnissen sollen dann Empfehlungen für die Marketing-Abteilung abgeleitet werden. 

# Das Unternehmen
Das Unternehmen hat 5824 Fahrräder in einem Netzwerk aus 692 Stationen. Die Fahrräder können an jeder Station geliehen und an jeder beliebigen Station zu jeder Zeit wieder abgestellt werden. Das Marketing bezog sich bisher hauptsächlich auf allgemeine Bekanntheit. 

# Hauptfragen
1. Wie unterscheiden sich die Kunden mit Jahresmitgliedschaft von den gelegentlichen Nutzern?
2. Was sind die Top-Empfehlungen für das Marketing auf Basis dieser Erkenntnisse? 

# Daten
Die Daten stammen von Motivate International Inc., einem tatsächlichen Betreiber eines bike-sharing Unternehmens. https://divvy-tripdata.s3.amazonaws.com/index.html 

Die Daten sind unter folgender Lizenz allgemein verfügbar. https://www.divvybikes.com/data-license-agreement 

# Vorbereitung der Daten
Es werden die Daten der letzten 12 Monate genutzt (10.2020 – 09.2021). Diese sind in einzelnen Monaten organisiert. Die Daten wurden vom Unternehmen selbst erhoben. 
Wir nutzen SQL für diese Untersuchung. Dazu wurden die Daten in eine Datenbank übertragen. 

# Bereinigung und Analyse der Daten
Die weiteren Schritte in der Bereinigung und der Analyse der Daten mit Kommentaren zu den Gedanken hinter dem Vorgehen sind in der .sql Datei zu finden. 

# Visualisierung 
Eine einfache Visualisierung der Ergebnisse ist auf Tableau Public verfügbar. 
https://public.tableau.com/app/profile/patrick5127/viz/NutzerverhaltenUnterschiede/Dashboard1 

# Hauptunterschiede zwischen den beiden Kundentypen
Die Aufgabe bestand darin die Unterschiede im Nutzungsverhalten zwischen den beiden Kundentypen aufzudecken. Aus der oberen Analyse und den Visualisierungen lassen sich zwei Dinge klar erkennen: 
1. Das Marketing sollte die Vorteile des Systems für bereits kürzere Strecken und Zeiten in den Vordergrund stellen.
2. Das Marketing sollte für Casuals insbesondere eine Nutzung auch an Arbeitstagen in den Vordergrund stellen. 

# Weitere Schritte 
Der hohe Anteil der Member an Arbeitstagen lässt darauf schließen, dass diese das System möglicherweise zum Pendeln nutzen, was ein guter Punkt für das Marketing sein könnte. Es könnten Aussagen zur niedrigeren CO2-Belastung und einem stressfreierem Pendeln genutzt werden. Es müsste vorher noch in genaueren Nachforschungen bestätigt werden, dass Member das System zum Pendeln nutzen.
Ebenfalls könnten Member befragt werden, für welche Kurzstrecken sie das System nutzen, um die Erkenntnisse mit in eine Marketingkampagne an Casuals einzubauen. 
