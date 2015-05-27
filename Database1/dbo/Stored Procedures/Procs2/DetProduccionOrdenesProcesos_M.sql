--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionOrdenesProcesos_M
@IdDetalleProduccionOrdenProceso int,
@IdProduccionOrden int,
@IdProduccionProceso int,
@Horas numeric(12,2),
	@FechaInicio datetime,
	@FechaFinal datetime,
	@HorasReales numeric(12,2) 

,@IdMaquina int

,@Observaciones ntext
,@Orden int=NULL 
,@IdProduccionParteQueCerroEsteProceso int=NULL

AS

if @Orden=-1 begin set @Orden=null end
if @IdProduccionParteQueCerroEsteProceso=-1 begin set @IdProduccionParteQueCerroEsteProceso=null end


UPDATE [DetalleProduccionOrdenProcesos]
SET 
 IdProduccionOrden=@IdProduccionOrden,
 IdProduccionProceso=@IdProduccionProceso,
 Horas=@Horas,
	FechaInicio=@FechaInicio,
	FechaFinal=@FechaFinal,
	HorasReales=@HorasReales,
	IdMaquina=@IdMaquina

,Observaciones=@Observaciones 
,Orden=@Orden
,IdProduccionParteQueCerroEsteProceso=@IdProduccionParteQueCerroEsteProceso

WHERE (IdDetalleProduccionOrdenProceso=@IdDetalleProduccionOrdenProceso)
RETURN(@IdDetalleProduccionOrdenProceso)
