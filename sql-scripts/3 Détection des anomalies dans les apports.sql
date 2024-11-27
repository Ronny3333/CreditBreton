-- Détection des anomalies dans les apports
--Objectif : Identifier les prêts où le montant de l’apport est disproportionné par rapport au montant total

SELECT d.[Numéro demande de prêt], ap.[Apport], d.[Montant opération],
	   CONVERT(DECIMAL(7,2), ap.[Apport])/ d.[Montant opération] *100 AS PourcentageApport
FROM [CreditBreton].[dbo].[Demandes de prêt] d
JOIN [CreditBreton].[dbo].[Apports] ap ON ap.[Numéro demande de prêt] = d.[Numéro demande de prêt]
WHERE (CONVERT(FLOAT, ap.[Apport])/ d.[Montant opération]) < 0.15
     OR (CONVERT(FLOAT, ap.[Apport])/ d.[Montant opération]) > 0.85
ORDER BY PourcentageApport DESC;
