

	declare @p0 decimal(31,2), @p1 decimal(31,2),@p2 decimal(31,2),@p3 decimal(31,2),@p4 decimal(31,2)
	,@p5 int,@p6 decimal(33,4),@p7 decimal(31,2),@p8 int,@p9 datetime,@p10 datetime,
	@p11 varchar(2),@p12 varchar(2),@p13 nvarchar(11),@p14 nvarchar(7)


	set @p0=1000.00
	set @p1=1000.00  
	  set @p2=1000.00  
	 set @p3=0  
	  set @p4=1000.00   
	 set @p5=0  
	  set @p6=0  
	   set @p7=1000.00 
	    set @p8=0
	   set @p9='2013-01-01 00:00:00'   
	   set @p10='2013-04-29 00:00:00'  
	    set @p11='SI' 
	     set @p12='SI' 
	     set @p13=N'Exportación'   
		 set @p14=N'Entrega'


SELECT 
    (CASE 
        WHEN [t9].[Exporta] = @p12 THEN @p13
        ELSE CONVERT(NVarChar(11),@p14)
     END) AS [Sucursal], [t9].[value22] AS [Ano], [t9].[value32] AS [Month], [t9].[value222] AS [Producto], [t9].[value] AS [CantCartas], [t9].[value2] AS [NetoFinal], [t9].[value3] AS [Merma], [t9].[value4] AS [NetoPto], [t9].[value5] AS [Importe]
FROM (
    SELECT COUNT(*) AS [value], SUM([t8].[value4]) AS [value2], SUM([t8].[value5]) AS [value3], SUM([t8].[value6]) AS [value4], SUM([t8].[value]) AS [value5], [t8].[value2] AS [value22], [t8].[value22] AS [value222], [t8].[value3] AS [value32], [t8].[Exporta]
    FROM (
        SELECT 
            (CASE 
                WHEN [t7].[TarifaFacturada] > @p3 THEN (([t7].[TarifaFacturada]) * ([t7].[NetoPto])) / @p4
                ELSE ((COALESCE(CONVERT(Decimal(33,4),[dbo].[wTarifaWilliamsEstimada]([t7].[Vendedor], [t7].[IdArticulo], [t7].[Destino], @p5)),@p6)) * ([t7].[NetoPto])) / @p7
             END) AS [value], [t7].[Vendedor], [t7].[RazonSocial], [t7].[FechaDescarga], [t7].[Anulada], [t7].[Corredor], [t7].[Entregador], [t7].[value2], [t7].[value22], [t7].[value3], [t7].[Exporta], [t7].[value4], [t7].[value5], [t7].[value] AS [value6]
        FROM (
            SELECT CONVERT(Int,(COALESCE([t6].[NetoPto],0)) / @p2) AS [value], [t6].[TarifaFacturada], [t6].[NetoPto], [t6].[Vendedor], [t6].[IdArticulo], [t6].[Destino], [t6].[RazonSocial], [t6].[FechaDescarga], [t6].[Anulada], [t6].[Corredor], [t6].[Entregador], [t6].[value2], [t6].[value22], [t6].[value3], [t6].[Exporta], [t6].[value4], [t6].[value] AS [value5]
            FROM (
                SELECT CONVERT(Int,(COALESCE([t5].[Merma],0)) / @p1) AS [value], [t5].[NetoPto], [t5].[TarifaFacturada], [t5].[Vendedor], [t5].[IdArticulo], [t5].[Destino], [t5].[RazonSocial], [t5].[FechaDescarga], [t5].[Anulada], [t5].[Corredor], [t5].[Entregador], [t5].[value2], [t5].[value22], [t5].[value3], [t5].[Exporta], [t5].[value] AS [value4]
                FROM (
                    SELECT CONVERT(Int,(COALESCE([t4].[NetoFinal],0)) / @p0) AS [value], [t4].[Merma], [t4].[NetoPto], [t4].[TarifaFacturada], [t4].[Vendedor], [t4].[IdArticulo], [t4].[Destino], [t4].[RazonSocial], [t4].[FechaDescarga], [t4].[Anulada], [t4].[Corredor], [t4].[Entregador], [t4].[value] AS [value2], [t4].[value2] AS [value22], [t4].[value3], [t4].[Exporta]
                    FROM (
                        SELECT DATEPART(Year, [t0].[FechaDescarga]) AS [value], [t2].[Descripcion] AS [value2], DATEPART(Month, [t0].[FechaDescarga]) AS [value3], [t0].[Exporta], [t0].[NetoFinal], [t0].[Merma], [t0].[NetoPto], [t0].[TarifaFacturada], [t0].[Vendedor], [t0].[IdArticulo], [t0].[Destino], [t1].[RazonSocial], [t0].[FechaDescarga], [t0].[Anulada], [t0].[Corredor], [t0].[Entregador]
                        FROM [dbo].[CartasDePorte] AS [t0]
                        INNER JOIN [dbo].[Clientes] AS [t1] ON [t0].[Vendedor] = ([t1].[IdCliente])
                        LEFT OUTER JOIN [dbo].[Articulos] AS [t2] ON ([t2].[IdArticulo]) = [t0].[IdArticulo]
                        LEFT OUTER JOIN [dbo].[Clientes] AS [t3] ON ([t3].[IdCliente]) = [t0].[Vendedor]
                        ) AS [t4]
                    ) AS [t5]
                ) AS [t6]
            ) AS [t7]
        ) AS [t8]
    WHERE ([t8].[Vendedor] > @p8) AND ([t8].[RazonSocial] IS NOT NULL) AND ([t8].[FechaDescarga] >= @p9) AND ([t8].[FechaDescarga] <= @p10) AND ([t8].[Anulada] <> @p11) AND ((1) = 1) AND (([t8].[Vendedor] IS NOT NULL) AND ([t8].[Corredor] IS NOT NULL) AND ([t8].[Entregador] IS NOT NULL))
    GROUP BY [t8].[value2], [t8].[value22], [t8].[value3], [t8].[Exporta]
    ) AS [t9]

	
	