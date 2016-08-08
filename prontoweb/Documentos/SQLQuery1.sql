SELECT 
    [GroupBy1].[A1] AS [C1]
    FROM ( 
	
	SELECT 
        COUNT(1) AS [A1]
        FROM [dbo].[CartasDePorte] AS [Extent1]
        WHERE ([Extent1].[IdFacturaImputada] IN (0,-1) OR [Extent1].[IdFacturaImputada] IS NULL) 
		AND ( NOT (('SI' = [Extent1].[Anulada]) AND ([Extent1].[Anulada] IS NOT NULL))) 
		AND ((([Extent1].[Subcontr1] IN (16729)) AND ([Extent1].[Subcontr1] IS NOT NULL)) 
		OR (([Extent1].[Subcontr2] IN (16729)) AND ([Extent1].[Subcontr2] IS NOT NULL)))

    )  AS [GroupBy1]


	CREATE NONCLUSTERED INDEX CartasDePorte_IdFacturaImputada_Subcontr
ON [dbo].[CartasDePorte] ([IdFacturaImputada])
INCLUDE ([Anulada],[Subcontr1],[Subcontr2])