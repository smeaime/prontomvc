
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionOrdenesProcesos_A


@IdDetalleProduccionOrdenProceso int output,
@IdProduccionOrden int,
@IdProduccionProceso int,
@Horas numeric(12,2),
	@FechaInicio datetime,
	@FechaFinal datetime,
	@HorasReales numeric(12,2) 

,@IdMaquina int

,@Observaciones ntext
,@Orden int
,@IdProduccionParteQueCerroEsteProceso int

AS 
INSERT INTO [DetalleProduccionOrdenProcesos]
(
 IdProduccionOrden,
 IdProduccionProceso,
 Horas,
	FechaInicio ,
	FechaFinal,
	HorasReales,
IdMaquina
,Observaciones 
,Orden
,IdProduccionParteQueCerroEsteProceso
)
VALUES
(
 @IdProduccionOrden,
 @IdProduccionProceso,
 @Horas,
	@FechaInicio ,
	@FechaFinal,
	@HorasReales,
@IdMaquina
,@Observaciones
,@Orden
,@IdProduccionParteQueCerroEsteProceso
)
SELECT @IdDetalleProduccionOrdenProceso=@@identity
RETURN(@IdDetalleProduccionOrdenProceso)

