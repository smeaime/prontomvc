
IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_EstadisticasDeDescarga]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wCartasDePorte_TX_EstadisticasDeDescarga]
go



CREATE PROCEDURE [dbo].[wCartasDePorte_TX_EstadisticasDeDescarga]

			 @startRowIndex int  = NULL,
            @maximumRows int  = NULL,
            @estado int  = NULL,
            @QueContenga  VARCHAR(50) = NULL,
            @idVendedor int  = NULL,
            @idCorredor int  = NULL,
            @idDestinatario int  = NULL,
            @idIntermediario int  = NULL,
            @idRemComercial int  = NULL,
            @idArticulo int  = NULL,
            @idProcedencia int  = NULL,
            @idDestino int  = NULL,
            @AplicarANDuORalFiltro int  = NULL,
            @ModoExportacion  VARCHAR(20) = NULL,

			@fechadesde datetime,
			@fechahasta datetime,

            @puntoventa int  = NULL, 
            @optDivisionSyngenta  VARCHAR(50) = NULL,
           --@bTraerDuplicados As Boolean = False,
            @Contrato  VARCHAR(50) = NULL, 
            @QueContenga2  VARCHAR(50) = NULL,
            @idClienteAuxiliarint int  = NULL,
            @AgrupadorDeTandaPeriodos int  = NULL,
            @Vagon  int  = NULL,
			@Patente VARCHAR(10) = NULL,
            @optCamionVagon  VARCHAR(10) = NULL,


            @fechadesdeAnterior As DateTime= NULL,
			@fechahastaAnterior As DateTime= NULL

AS



--set @ModoExportacion='Ambos'
--set @pv=-1



--set @fechadesde='2015-06-01 00:00:00'
--set @fechahasta='2015-06-01 00:00:00'
--set @fechahasta='2014-06-01 00:00:00'
--set @fechadesde='2014-06-01 00:00:00'




						/*

                        .Sucursal = SqlFunctions.StringConvert(Sucursal), _
                        .Modo = Modo, _
                        .Producto = Producto, _
                        .CantCartas = g.Count, _
                        .NetoPto = g.Sum(Function(i) If(i.NetoFinal, 0)) / 1000, _
                        .Merma = g.Sum(Function(i) (If(i.Merma, 0) + If(i.HumedadDesnormalizada, 0))) / 1000, _
                        .NetoFinal = g.Sum(Function(i) If(i.NetoProc, 0)) / 1000, _
                        .Importe = g.Sum(Function(i) CDec( _
                                                         CDec(If(i.TarifaFacturada, 0)) * CDec(If(i.NetoPto, 0)) / 1000 _
                                                        )), _
                        .PV1 = CInt(g.Where(Function(i) i.PuntoVenta = 1 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .PV2 = CInt(g.Where(Function(i) i.PuntoVenta = 2 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .PV3 = CInt(g.Where(Function(i) i.PuntoVenta = 3 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .PV4 = CInt(g.Where(Function(i) i.PuntoVenta = 4 And i.FechaIngreso >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .TotalEntrega = CInt(g.Where(Function(i) i.FechaDescarga >= fechadesde And If(Modo, "NO") = "NO") _
                                            .DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .TotalExportacion = CInt(g.Where(Function(i) i.FechaDescarga >= fechadesde And If(Modo, "NO") = "SI") _
                                            .DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .TotalBuques = 0, _
                        .Total = CInt(g.Where(Function(i) i.FechaDescarga >= fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .Porcent = 0, _
                        .PeriodoAnterior = CInt(g.Where(Function(i) i.FechaDescarga < fechadesde).DefaultIfEmpty().Sum(Function(i) If(i.NetoFinal, 0)) / 1000), _
                        .Diferen = 0, _
                        .DiferencPorcent = 0 _
						er
						*/

SELECT  art.Descripcion as Producto, cdp.Exporta as Modo, cdp.PuntoVenta as Sucursal , count(*) as CantCartas,
	sum(Merma + HumedadDesnormalizada) /1000 as Merma, sum(NetoFinal) /1000 as NetoPto,
	sum(NetoProc)/1000 as NetoFinal , sum(TarifaFacturada*NetoPto)/1000 as Importe,
	sum(case  when cdp.PuntoVenta = 1 And FechaIngreso >= @fechadesde  then NetoFinal else 0 end )/1000 as PV1,
	sum(case  when cdp.PuntoVenta = 2 And FechaIngreso >= @fechadesde  then NetoFinal else 0 end )/1000 as PV2,
	sum(case  when cdp.PuntoVenta = 3 And FechaIngreso >= @fechadesde  then NetoFinal else 0 end ) /1000 as PV3,
	sum(case  when cdp.PuntoVenta = 4 And FechaIngreso >= @fechadesde  then NetoFinal else 0 end )/1000 as PV4,
	sum(case  when isnull(Exporta, 'NO') = 'NO' And FechaDescarga >= @fechadesde  then NetoFinal else 0 end )/1000 as TotalEntrega,
	sum(case  when isnull(Exporta, 'NO') = 'SI' And FechaDescarga >= @fechadesde  then NetoFinal else 0 end )/1000 as TotalExportacion,
	0 as TotalBuques,
	sum(case  when FechaDescarga >= @fechadesde  then NetoFinal else 0 end ) /1000 as Total,
	0 as Porcent,
	sum(case  when FechaDescarga < @fechadesde  then NetoFinal else 0 end )/1000 as PeriodoAnterior,
	0 as Diferen,
	0 as DiferencPorcent
--from CartasDePorte cdp
from dbo.fSQL_GetDataTableFiltradoYPaginado
( 
						@startRowIndex, 
							@maximumRows, 
							@estado,
							@QueContenga, 
							@idVendedor, 

							@idCorredor, 
							@idDestinatario, 
							@idIntermediario,
							@idRemComercial, 
							@idArticulo,

							@idProcedencia,
							@idDestino,
							@AplicarANDuORalFiltro,
							@ModoExportacion,
							@fechadesdeAnterior,

							@fechahasta, 
							@puntoventa, 
							NULL,
							 'FALSE',--duplicados?
							@Contrato, 

							@QueContenga2, 
							@idClienteAuxiliarint, 
							@AgrupadorDeTandaPeriodos, 
							@Vagon,
							@Patente, 

							@optCamionVagon

					) as cdp



join Articulos art On art.IdArticulo = cdp.IdArticulo 

Where	
			not cdp.FechaDescarga is null and
          ( 
                (cdp.FechaDescarga >= @fechadesde And cdp.FechaDescarga <= @fechahasta) 
                Or 
                (cdp.FechaDescarga >= @fechadesdeAnterior And cdp.FechaDescarga <= @fechahastaAnterior) 
            ) 
        
Group BY  art.Descripcion, cdp.Exporta, cdp.PuntoVenta 

go






[wCartasDePorte_TX_EstadisticasDeDescarga] 
					NULL, 
					NULL, 
					4,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					-1, --@idArticulo,

					NULL, --@idProcedencia,
					-1,---1, --@idDestino,
					NULL, --@AplicarANDuORalFiltro,
					'Entregas', --'Ambos', --'Buques',
					'20161101',
					
					'20170510',
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL

					,'20151101','20160510'

go

     --var desde = new DateTime(2016, 11, 1);
     --       var hasta = new DateTime(2017, 5, 10);
     --       var desdeAnt = new DateTime(2015, 11, 1); //nov
     --       var hastaAnt = new DateTime(2016, 5, 10); //mayo



select * -- sum(cdp.netofinal)
from 
 dbo.fSQL_GetDataTableFiltradoYPaginado(

					NULL, 
					NULL, 
					4,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, --@idArticulo,

					NULL, --@idProcedencia,
					NULL, --@idDestino,
					NULL, --@AplicarANDuORalFiltro,
					'Entregas', --'Ambos', --'Buques',
					'20161101',

					'20170510',
					NULL, 
					NULL,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, 
					NULL
)
as cdp
where cdp.exporta='SI'



select  sum(cdp.netofinal)
from 
 dbo.fSQL_GetDataTableFiltradoYPaginado(

					NULL, 
					NULL, 
					4,
					NULL, 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, --@idArticulo,

					NULL, --@idProcedencia,
					NULL, --@idDestino,
					NULL, --@AplicarANDuORalFiltro,
					'Ambos', --'Buques',
					'20151101',
					
					'20160510',
					NULL, 
					NULL,
					'FALSE', 
					NULL, 

					NULL, 
					NULL, 
					NULL,
					NULL, 
					NULL, 
					NULL
)
as cdp


--'2015-06-01 00:00:00','2015-06-01 00:00:00','2014-06-01 00:00:00','2014-06-01 00:00:00'

--[wCartasDePorte_TX_EstadisticasDeDescarga] 'Ambos',-1
go



--select top 10 * from cartasdeporte order by idcartadeporte desc




