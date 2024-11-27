--Analyse des ratios d'apport par catégorie socioprofessionnelle
--Objectif : Comparer les ratios d'apport par rapport au montant total de l'opération pour chaque catégorie socioprofessionnelle

SELECT 
    sp.[Catégorie socioprofessionnelle],
    AVG(CAST(a.[Apport] AS FLOAT) / d.[Montant opération]) * 100 AS RatioApportMoyen,
    COUNT(d.[Numéro demande de prêt]) AS NombreDemandes
FROM [CreditBreton].[dbo].[Demandes de prêt] d
JOIN [CreditBreton].[dbo].[Situations pro] sp ON d.[Numéro client] = sp.[Numéro client]
JOIN [CreditBreton].[dbo].[Apports] a ON d.[Numéro demande de prêt] = a.[Numéro demande de prêt]
WHERE d.[Accord] = 'N'
GROUP BY sp.[Catégorie socioprofessionnelle]
ORDER BY RatioApportMoyen DESC;
