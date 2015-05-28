
CREATE Procedure DetProduccionOrdenesProcesos_TX_PorFechaParaProgramadorDeRecursos
	@Desde datetime,
	@Hasta datetime,
	@Area int=NULL,
	@Sector int=NULL,
	@Linea int=NULL,
	@Proceso int=NULL,
	@Maquina int=NULL
AS 

if @area=-1 begin set @area=null end
if @Sector=-1 begin set @Sector=null end
if @Linea=-1 begin set @Linea=null end
if @Proceso=-1 begin set @Proceso=null end
if @Maquina=-1 begin set @Maquina=null end


SELECT DET.*,
	CAB.FechaInicioPrevista,
	CAB.FechaFinalPrevista,
	CAB.NumeroOrdenProduccion,
	CAB.Programada,
	CAB.Anulada,
	dbo.fProduccionAvanzado(Det.IdProduccionOrden,Det.IdProduccionProceso) as [Avance],
	case when FechaInicio is null or idMaquina is null then 'SI' else 'NO' end as Programable, 
	ProduccionProcesos.Descripcion,
	Articulos.descripcion as Articulo,
	CAB.IdArticuloGenerado,
	CAB.Cantidad,
	dbo.fProduccionOrden_EnEjecucion(Det.IdProduccionOrden,det.IdProduccionProceso) as PartesAsociados
FROM [DetalleProduccionOrdenProcesos] DET
inner join ProduccionOrdenes CAB on CAB.idProduccionOrden=DET.idProduccionOrden
LEFT OUTER JOIN Articulos ON CAB.IdArticuloGenerado = Articulos.IdArticulo
left outer join ProduccionProcesos on ProduccionProcesos.idProduccionProceso=DET.idProduccionProceso
left outer join ProduccionSectores on ProduccionSectores.idProduccionSector=ProduccionProcesos.idProduccionProceso
left outer join PROD_Maquinas Maquinas on Maquinas.idArticulo=DET.idMaquina
left outer join ProduccionLineas Lineas on Lineas.idProduccionLinea=Maquinas.idProduccionLinea

--WHERE ((DET.FechaInicio between @Desde and @Hasta) OR DET.FechaInicio is null OR (CAB.FechaInicioPrevista between @Desde and @Hasta))
-- el where de arriba dejaba afuera del programador los que empezaban antes del rango, pero terminaban dentro!!!!!
WHERE ((DET.FechaInicio < @Hasta and DET.FechaFinal > @Desde) OR DET.FechaInicio is null OR (CAB.FechaInicioPrevista <@Hasta and FechaFinalPrevista>@Desde))
and ProduccionProcesos.idProduccionSector=IsNull(@Sector,ProduccionProcesos.idProduccionSector)
and DET.idProduccionProceso=IsNull(@Proceso,DET.idProduccionProceso)

and (Lineas.idProduccionLinea=IsNull(@Linea,Lineas.idProduccionLinea) or Lineas.idProduccionLinea is null)
and (DET.idMaquina=IsNull(@Maquina,DET.idMaquina)or DET.idMaquina is null)
and (idProduccionArea=IsNull(@Area,idProduccionArea) or idProduccionArea is null)
AND (cab.Anulada<>'SI' OR cab.anulada IS NULL)	
and (not cab.aprobo is null) --está aprobada



