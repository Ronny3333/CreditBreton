-- Taux d'approbation par agence
--Objectif :  Identifier les agences et les profils de clients avec les taux les plus �lev�s ou faibles d�approbation

SELECT 
	a.[Ville] AS Agence,
	COUNT(d.[Num�ro demande de pr�t]) As NombreDemades,
	SUM(CASE WHEN d.[Accord] = 'o' THEN 1 ELSE 0 END) AS NombresAccords,
	CAST( SUM(CASE WHEN d.[Accord] = 'o' THEN 1 ELSE 0 END) AS FLOAT)  / COUNT(d.[Num�ro demande de pr�t])*100 As TauxAcceptation
FROM [CreditBreton].[dbo].[Demandes de pr�t] d
JOIN [CreditBreton].[dbo].[Agences] a ON d.[Num�ro d'agence] = a.[Num�ro d'agence]
GROUP BY a.[Ville];
