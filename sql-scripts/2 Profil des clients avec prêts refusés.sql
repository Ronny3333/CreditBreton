-- Profil des clients avec prêts refusés
--Objectif : Identifier les caractéristiques des clients avec des prêts refusés avec un apport important

SELECT sf.[Nom], sf.[Prénom],sf.[Situation familliale], sf.[Nombre d'enfants à charge],sp.[Catégorie socioprofessionnelle],sp.[Revenu mensuel moyen],a.[Apport],d.[Montant opération],
		CAST(a.Apport AS FLOAT) / d.[Montant opération] As RatioApport
FROM [CreditBreton].[dbo].[Demandes de prêt] d
JOIN [CreditBreton].[dbo].[Situations familiales] sf ON sf.[ID_Client] = d.[Numéro client]
JOIN [CreditBreton].[dbo].[Situations pro] sp ON sp.[Numéro client] = d.[Numéro client]
JOIN [CreditBreton].[dbo].[Apports] a ON a.[Numéro demande de prêt] = d.[Numéro demande de prêt]
WHERE d.[Accord] = 'n'AND CAST(a.Apport AS FLOAT) / d.[Montant opération] > 0.4;