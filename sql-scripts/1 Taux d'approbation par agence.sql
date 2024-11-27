-- Taux d'approbation par agence
--Objectif :  Identifier les agences et les profils de clients avec les taux les plus élevés ou faibles d’approbation

SELECT 
	a.[Ville] AS Agence,
	COUNT(d.[Numéro demande de prêt]) As NombreDemades,
	SUM(CASE WHEN d.[Accord] = 'o' THEN 1 ELSE 0 END) AS NombresAccords,
	CAST( SUM(CASE WHEN d.[Accord] = 'o' THEN 1 ELSE 0 END) AS FLOAT)  / COUNT(d.[Numéro demande de prêt])*100 As TauxAcceptation
FROM [CreditBreton].[dbo].[Demandes de prêt] d
JOIN [CreditBreton].[dbo].[Agences] a ON d.[Numéro d'agence] = a.[Numéro d'agence]
GROUP BY a.[Ville];
