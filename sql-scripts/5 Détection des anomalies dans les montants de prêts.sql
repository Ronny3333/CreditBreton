-- D�tection des anomalies dans les montants de pr�ts
--Objectif : Trouver des demandes de pr�t dont le montant est significativement plus �lev� que la moyenne (potentielles anomalies)

SELECT 
	d.[Num�ro demande de pr�t],
	d.[Montant op�ration],
	a.[Ville] As Agence,
	sp.[Cat�gorie socioprofessionnelle],
	d.[Montant op�ration] - AVG(d.[Montant op�ration]) OVER (PARTITION BY a.[Ville]) As ecart_par_rapport_a_moyenne,
	1.5 * STDEV(d.[Montant op�ration]) OVER (PARTITION BY a.[Ville]) As double_ecart_type
FROM [CreditBreton].[dbo].[Demandes de pr�t] d
JOIN [CreditBreton].[dbo].[Agences] a ON a.[Num�ro d'agence] = d.[Num�ro d'agence]
JOIN [CreditBreton].[dbo].[Situations pro] sp ON sp.[Num�ro client] = d.[Num�ro client]
ORDER BY ecart_par_rapport_a_moyenne DESC;