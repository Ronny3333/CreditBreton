-- Profil des clients avec pr�ts refus�s
--Objectif : Identifier les caract�ristiques des clients avec des pr�ts refus�s avec un apport important

SELECT sf.[Nom], sf.[Pr�nom],sf.[Situation familliale], sf.[Nombre d'enfants � charge],sp.[Cat�gorie socioprofessionnelle],sp.[Revenu mensuel moyen],a.[Apport],d.[Montant op�ration],
		CAST(a.Apport AS FLOAT) / d.[Montant op�ration] As RatioApport
FROM [CreditBreton].[dbo].[Demandes de pr�t] d
JOIN [CreditBreton].[dbo].[Situations familiales] sf ON sf.[ID_Client] = d.[Num�ro client]
JOIN [CreditBreton].[dbo].[Situations pro] sp ON sp.[Num�ro client] = d.[Num�ro client]
JOIN [CreditBreton].[dbo].[Apports] a ON a.[Num�ro demande de pr�t] = d.[Num�ro demande de pr�t]
WHERE d.[Accord] = 'n'AND CAST(a.Apport AS FLOAT) / d.[Montant op�ration] > 0.4;