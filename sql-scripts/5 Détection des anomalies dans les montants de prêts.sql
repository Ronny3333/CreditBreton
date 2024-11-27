-- Détection des anomalies dans les montants de prêts
--Objectif : Trouver des demandes de prêt dont le montant est significativement plus élevé que la moyenne (potentielles anomalies)

SELECT 
	d.[Numéro demande de prêt],
	d.[Montant opération],
	a.[Ville] As Agence,
	sp.[Catégorie socioprofessionnelle],
	d.[Montant opération] - AVG(d.[Montant opération]) OVER (PARTITION BY a.[Ville]) As ecart_par_rapport_a_moyenne,
	1.5 * STDEV(d.[Montant opération]) OVER (PARTITION BY a.[Ville]) As double_ecart_type
FROM [CreditBreton].[dbo].[Demandes de prêt] d
JOIN [CreditBreton].[dbo].[Agences] a ON a.[Numéro d'agence] = d.[Numéro d'agence]
JOIN [CreditBreton].[dbo].[Situations pro] sp ON sp.[Numéro client] = d.[Numéro client]
ORDER BY ecart_par_rapport_a_moyenne DESC;