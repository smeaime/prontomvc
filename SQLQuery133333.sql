exec sp_executesql N'SELECT 
    *
    FROM ( SELECT 
        *
        FROM [dbo].[Presupuestos] AS [Extent1]
        WHERE ([Extent1].[FechaIngreso] >= @p0) AND ([Extent1].[FechaIngreso] <= @p1)
    )  AS [GroupBy1]',N'@p0 datetime2(7),@p1 datetime2(7)',@p0='2015-02-01',@p1='2015-02-28'

