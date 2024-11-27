-- D�tection des anomalies dans les apports
--Objectif : Identifier les pr�ts o� le montant de l�apport est disproportionn� par rapport au montant total

SELECT d.[Num�ro demande de pr�t], ap.[Apport], d.[Montant op�ration],
	   CONVERT(DECIMAL(7,2), ap.[Apport])/ d.[Montant op�ration] *100 AS PourcentageApport
FROM [CreditBreton].[dbo].[Demandes de pr�t] d
JOIN [CreditBreton].[dbo].[Apports] ap ON ap.[Num�ro demande de pr�t] = d.[Num�ro demande de pr�t]
WHERE (CONVERT(FLOAT, ap.[Apport])/ d.[Montant op�ration]) < 0.15
     OR (CONVERT(FLOAT, ap.[Apport])/ d.[Montant op�ration]) > 0.85
ORDER BY PourcentageApport DESC;
