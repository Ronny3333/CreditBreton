-- Analyse des revenus moyens des clients
--Objectif : Identifier les revenus moyens des clients par cat�gorie professionnelle et ville

SELECT sp.[Cat�gorie socioprofessionnelle], a.[Ville],
		AVG( sp.[Revenu mensuel moyen]) AS RevenuMoyen
FROM [CreditBreton].[dbo].[Demandes de pr�t] d
JOIN [CreditBreton].[dbo].[Situations pro] sp ON sp.[Num�ro client] = d.[Num�ro client]
JOIN [CreditBreton].[dbo].[Agences] a ON a.[Num�ro d'agence] = d.[Num�ro d'agence]
GROUP BY sp.[Cat�gorie socioprofessionnelle], a.[Ville]
ORDER BY RevenuMoyen DESC;