# Identifier les anomalies dans les demandes ou accords en utilisant l’écart-type (valeurs extrêmes)

# Identifier les anomalies dans les demandes ou accords en utilisant l’écart-type (valeurs extrêmes

import pyodbc as odbc
import pandas as pd
import matplotlib.pyplot as plt

# Connexion à SQL SERVER

DRIVER_NAME = 'SQL SERVER'
SERVER_NAME = 'RONNY'
DATABASE_NAME = 'CreditBreton'

Connection_string = f"""
    DRIVER={{{DRIVER_NAME}}};
    SERVER={SERVER_NAME};
    DATABASE={DATABASE_NAME};
    Trust_Connection=yes;
    
"""
conn = odbc.connect(Connection_string)
print(conn)

# Chargement des données

query = """
        SELECT
            d.[Date de demande] as DateDemande,
            YEAR(d.[Date de demande]) AS Annee,
            MONTH(d.[Date de demande]) AS Mois,
            COUNT(d.[Numéro demande de prêt]) AS nombre_demandes,
			SUM(CASE WHEN d.[Accord] = 'O' THEN 1 ELSE 0 END) AS nombre_accords
        FROM [CreditBreton].[dbo].[Demandes de prêt] d
        GROUP BY d.[Date de demande],YEAR(d.[Date de demande]) , MONTH(d.[Date de demande])
        ORDER BY Annee,Mois
"""
df = pd.read_sql(query, conn)

# Conversion des dates de demande
df['Year'] = df['DateDemande'].dt.year
df['Month'] = df['DateDemande'].dt.month
df['Date'] = pd.to_datetime(df[['Year', 'Month']].assign(day=1))

# Calcul des bornes d'anomalies
demande_mean = df['nombre_demandes'].mean()
demande_std = df['nombre_demandes'].std()
borne_inférieur = demande_mean - demande_std /2
borne_supérieur = demande_mean +  demande_std /2

# Filtrer les anomalies
anomalies = df[(df['nombre_demandes'] < borne_inférieur) & (df['nombre_demandes'] > borne_supérieur)]

# Tracer les demandes avec anomalies
plt.figure(figsize=(10, 6))
plt.plot(df['Date'],df['nombre_demandes'], color = 'green',label='Demandes')
plt.scatter(anomalies['Date'], anomalies['nombre_demandes'], color = 'red', label='Anomalies')
plt.axhline(borne_inférieur, color = 'orange', linestyle='--', label='Limite inférieure')
plt.axhline(borne_supérieur, color = 'orange', linestyle='--', label='Limite supérieure')
plt.axhline(demande_mean, color = 'red')
plt.axhline(demande_std, color = 'yellow')
plt.xlabel('Date de demandes')
plt.ylabel('Anomalies')
plt.title('Analyse des anomalies dans les demandes')
plt.grid()
plt.show()
