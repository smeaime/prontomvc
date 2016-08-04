
IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wCartasDePorte_TX_EstadisticasDeDescarga]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE [dbo].[wCartasDePorte_TX_EstadisticasDeDescarga]
go



CREATE PROCEDURE [dbo].[wCartasDePorte_TX_EstadisticasDeDescarga]

@ModoExportacion varchar(20),
@pv integer,

@fechadesde2 datetime,
@fechahasta2 datetime,
@fechadesde datetime,
@fechahasta datetime

AS



--set @ModoExportacion='Ambos'
--set @pv=-1



--set @fechadesde2='2015-06-01 00:00:00'
--set @fechahasta2='2015-06-01 00:00:00'
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
from dbo.fSQL_GetDataTableFiltradoYPaginado ( NULL, NULL, NULL,@fechadesde,@fechahasta2 ) as cdp
join Articulos art On art.IdArticulo = cdp.IdArticulo 

Where	cdp.Vendedor > 0 
        And ( 
                (cdp.FechaDescarga >= @fechadesde2 And cdp.FechaDescarga <= @fechahasta2) 
                Or 
                (cdp.FechaDescarga >= @fechadesde And cdp.FechaDescarga <= @fechahasta) 
            ) 
        And (cdp.Anulada <> 'SI') 
        And ((@ModoExportacion = 'Ambos') 
                Or (@ModoExportacion = 'Todos') 
                Or (@ModoExportacion = 'Entregas' And isnull(cdp.Exporta, 'NO') = 'NO') 
                Or (@ModoExportacion = 'Export' And isnull(cdp.Exporta, 'NO') = 'SI')) 
        And (@pv = -1 Or cdp.PuntoVenta = @pv)

Group BY  art.Descripcion, cdp.Exporta, cdp.PuntoVenta 

go



[wCartasDePorte_TX_EstadisticasDeDescarga] 'Buques',-1,'2014-01-06 00:00:00','2015-21-06 00:00:00','2013-01-06 00:00:00','2013-21-06 00:00:00'
go

[wCartasDePorte_TX_EstadisticasDeDescarga] 'Ambos',-1,'2015-06-01 00:00:00','2015-06-01 00:00:00','2014-06-01 00:00:00','2014-06-01 00:00:00'
go

