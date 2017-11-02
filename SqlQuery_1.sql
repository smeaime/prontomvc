SELECT TOP (999999) 
    [Project1].[C1] AS [C1], 
    [Project1].[C2] AS [C2], 
    [Project1].[Descripcion] AS [Descripcion], 
    [Project1].[TotalDescargaDia] AS [TotalDescargaDia]
    FROM ( SELECT [Project1].[TotalDescargaDia] AS [TotalDescargaDia], [Project1].[Descripcion] AS [Descripcion], [Project1].[C1] AS [C1], [Project1].[C2] AS [C2], row_number() OVER (ORDER BY [Project1].[C2] DESC) AS [row_number]
        FROM ( SELECT 
            [Extent1].[TotalDescargaDia] AS [TotalDescargaDia], 
            [Extent2].[Descripcion] AS [Descripcion], 
            1 AS [C1], 
             CAST( [Extent1].[Fecha] AS datetime2) AS [C2]
            FROM  [dbo].[CartasDePorteControlDescarga] AS [Extent1]
            LEFT OUTER JOIN [dbo].[WilliamsDestinos] AS [Extent2] ON [Extent1].[IdDestino] = [Extent2].[IdWilliamsDestino]
            WHERE ([Extent1].[Fecha] >= '1980-01-01T00:00:00') AND ([Extent1].[Fecha] <= '2050-01-01T00:00:00') AND (([Extent2].[PuntoVenta] = '0') OR ('0' <= 0)) AND (([Extent1].[IdDestino] = '0') OR ('0' <= 0))
        )  AS [Project1]
    )  AS [Project1]
    WHERE [Project1].[row_number] > 0
    ORDER BY [Project1].[C2] DESC