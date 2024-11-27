# Visualiser la répartition des demandes et accords de prêts 
# par mois pour identifier les tendances saisonnières


import pyodbc as odbc
import pandas as pd
import matplotlib.pyplot as plt

# Connexion à la base de données
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

# Creation du dataframe
query = """
        SELECT
            d.[Date de demande] as Date,
            YEAR(d.[Date de demande]) AS Annee,
            MONTH(d.[Date de demande]) AS Mois,
            COUNT(d.[Numéro demande de prêt]) AS NombreDemandes,
			SUM(CASE WHEN d.[Accord] = 'O' THEN 1 ELSE 0 END) AS NombreAccords
        FROM [CreditBreton].[dbo].[Demandes de prêt] d
        GROUP BY d.[Date de demande] , YEAR(d.[Date de demande]) , MONTH(d.[Date de demande])
        ORDER BY Annee,Mois 
"""
df = pd.read_sql(query,conn)

# Ajouter une colonne pour le mois sous forme de nom
df['NomMois'] = df['Date'].dt.strftime('%Y')

#Grouper par mois 
donnee_par_mois = df.groupby('NomMois')[['NombreDemandes', 'NombreAccords']].sum()

# Tracer un graphique en barres
donnee_par_mois.plot(kind='bar', figsize = (10,6), rot=45)
plt.title('Repartition des demandes et accords par mois')
plt.ylabel('Nombre')
plt.grid(axis='y')
plt.show()
