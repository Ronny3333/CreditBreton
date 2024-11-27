-- Analyse des revenus moyens des clients
--Objectif : Identifier les revenus moyens des clients par catégorie professionnelle et ville

SELECT sp.[Catégorie socioprofessionnelle], a.[Ville],
		AVG( sp.[Revenu mensuel moyen]) AS RevenuMoyen
FROM [CreditBreton].[dbo].[Demandes de prêt] d
JOIN [CreditBreton].[dbo].[Situations pro] sp ON sp.[Numéro client] = d.[Numéro client]
JOIN [CreditBreton].[dbo].[Agences] a ON a.[Numéro d'agence] = d.[Numéro d'agence]
GROUP BY sp.[Catégorie socioprofessionnelle], a.[Ville]
ORDER BY RevenuMoyen DESC;