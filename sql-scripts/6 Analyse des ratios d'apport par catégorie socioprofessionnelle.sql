--Analyse des ratios d'apport par cat�gorie socioprofessionnelle
--Objectif : Comparer les ratios d'apport par rapport au montant total de l'op�ration pour chaque cat�gorie socioprofessionnelle

SELECT 
    sp.[Cat�gorie socioprofessionnelle],
    AVG(CAST(a.[Apport] AS FLOAT) / d.[Montant op�ration]) * 100 AS RatioApportMoyen,
    COUNT(d.[Num�ro demande de pr�t]) AS NombreDemandes
FROM [CreditBreton].[dbo].[Demandes de pr�t] d
JOIN [CreditBreton].[dbo].[Situations pro] sp ON d.[Num�ro client] = sp.[Num�ro client]
JOIN [CreditBreton].[dbo].[Apports] a ON d.[Num�ro demande de pr�t] = a.[Num�ro demande de pr�t]
WHERE d.[Accord] = 'N'
GROUP BY sp.[Cat�gorie socioprofessionnelle]
ORDER BY RatioApportMoyen DESC;
