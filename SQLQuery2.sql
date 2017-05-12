declare @startRowIndex int,@maximumRows int,@estado int,@QueContenga nvarchar(4000),@idVendedor int,@idCorredor int,@idDestinatario int,@idIntermediario int,@idRemComercial int,@idArticulo int,@idProcedencia int,@idDestino int,@AplicarANDuORalFiltro int,@ModoExportacion nvarchar(4000),@fechadesde datetime2(7),@fechahasta datetime2(7),@puntoventa int,@IdAcopio int,@bTraerDuplicados bit,@Contrato nvarchar(4000),@QueContenga2 nvarchar(4000),@idClienteAuxiliarint int,@AgrupadorDeTandaPeriodos int,@Vagon int,@Patente nvarchar(4000),
@optCamionVagon nvarchar(4000),@p__linq__0 datetime2(7),
@p__linq__1 datetime2(7),@p__linq__2 datetime2(7),@p__linq__3 datetime2(7),@p__linq__4 datetime2(7),
@p__linq__5 datetime2(7),@p__linq__6 datetime2(7),@p__linq__7 datetime2(7),@p__linq__8 datetime2(7),@p__linq__9 datetime2(7)

select @startRowIndex=NULL,@maximumRows=NULL,@estado=4,@QueContenga=NULL,@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,@idIntermediario=-1,
@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@idDestino=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Ambos',
@fechadesde='2015-11-01 00:00:00',@fechahasta='2017-05-10 00:00:00',@puntoventa=-1,@IdAcopio=NULL,@bTraerDuplicados=0,@Contrato=NULL,
@QueContenga2=NULL,@idClienteAuxiliarint=NULL,@AgrupadorDeTandaPeriodos=NULL,@Vagon=NULL,@Patente=NULL,@optCamionVagon=NULL,
@p__linq__0='2016-11-01 00:00:00',@p__linq__1='2016-11-01 00:00:00',@p__linq__2='2016-11-01 00:00:00',@p__linq__3='2017-05-10 00:00:00',@p__linq__4='2016-11-01 00:00:00',@p__linq__5='2015-11-01 00:00:00',@p__linq__6='2016-11-01 00:00:00',@p__linq__7='2016-05-10 00:00:00',@p__linq__8='2016-11-01 00:00:00',@p__linq__9='2016-05-10 00:00:00'    



select  sum(netofinal)
from [fSQL_GetDataTableFiltradoYPaginado](@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, @idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion
, @p__linq__5, @p__linq__7, @puntoventa, @IdAcopio, @bTraerDuplicados, @Contrato, @QueContenga2, @idClienteAuxiliarint, @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon) 




select  sum(netofinal)

from [fSQL_GetDataTableFiltradoYPaginado](@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, 
@idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion, 
@fechadesde, @fechahasta, @puntoventa, @IdAcopio, @bTraerDuplicados, @Contrato, @QueContenga2, @idClienteAuxiliarint,
 @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon) 


 select sum(c3)
	from (
SELECT 
    1 AS [C1], 
    [GroupBy1].[K2] AS [ClienteFacturado], 
    [GroupBy1].[K1] AS [PuntoVenta], 
    [GroupBy1].[K3] AS [C2], 
    [GroupBy1].[A1] AS [C3]
    FROM ( SELECT 
        [Project1].[K1] AS [K1], 
        [Project1].[K2] AS [K2], 
        [Project1].[K3] AS [K3], 
        SUM([Project1].[A1]) AS [A1]
        FROM ( SELECT 
            [Project1].[PuntoVenta] AS [K1], 
            [Project1].[ClienteFacturado] AS [K2], 
            CASE WHEN ((CASE WHEN ([Project1].[FechaDescarga] IS NULL) THEN @p__linq__8 ELSE [Project1].[FechaDescarga] END) <= @p__linq__9) THEN cast(1 as bit) WHEN ( NOT ((CASE WHEN ([Project1].[FechaDescarga] IS NULL) THEN @p__linq__8 ELSE [Project1].[FechaDescarga] END) <= @p__linq__9)) THEN cast(0 as bit) END AS [K3], 
            [Project1].[NetoFinal] / cast(1000 as decimal(18)) AS [A1]
            FROM ( SELECT 
                [Extent1].[NetoFinal] AS [NetoFinal], 
                [Extent1].[FechaDescarga] AS [FechaDescarga], 
                [Extent1].[PuntoVenta] AS [PuntoVenta], 
                [Extent1].[ClienteFacturado] AS [ClienteFacturado]
                FROM [dbo].[fSQL_GetDataTableFiltradoYPaginado](@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, @idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion, @fechadesde, @fechahasta, @puntoventa, @IdAcopio, @bTraerDuplicados, @Contrato, @QueContenga2, @idClienteAuxiliarint, @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon) AS [Extent1]
                WHERE ([Extent1].[FechaDescarga] IS NOT NULL) AND ((((CASE WHEN ([Extent1].[FechaDescarga] IS NULL) THEN @p__linq__0 ELSE [Extent1].[FechaDescarga] END) >= @p__linq__1) AND ((CASE WHEN ([Extent1].[FechaDescarga] IS NULL) THEN @p__linq__2 ELSE [Extent1].[FechaDescarga] END) <= @p__linq__3)) OR (((CASE WHEN ([Extent1].[FechaDescarga] IS NULL) THEN @p__linq__4 ELSE [Extent1].[FechaDescarga] END) >= @p__linq__5) AND ((CASE WHEN ([Extent1].[FechaDescarga] IS NULL) THEN @p__linq__6 ELSE [Extent1].[FechaDescarga] END) <= @p__linq__7)))
            )  AS [Project1]
        )  AS [Project1]
        GROUP BY [K1], [K2], [K3]
    )  AS [GroupBy1]

	where [GroupBy1].[K3]=1
	) as AAA


