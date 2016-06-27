declare  @ModoExportacion varchar(20)
declare  @pv integer


declare  @fechadesde2 datetime
declare  @fechahasta2 datetime
declare  @fechadesde datetime
declare  @fechahasta datetime

set @fechadesde2='2016-06-01 00:00:00'
set @fechahasta2='2016-06-01 00:00:00'
set @fechahasta2='2016-06-01 00:00:00'
set @fechadesde='2016-06-01 00:00:00'



SELECT *
from CartasDePorte cdp
join Articulos art On art.IdArticulo = cdp.IdArticulo 
                Where cdp.Vendedor > 0 
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


					/*
	Group BY  art.Descripcion, Modo = cdp.Exporta, cdp.PuntoVenta 
                  Select New With { _
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
                    } _
                ).Where(Function(i) i.Total > 0).ToList
				
				*/