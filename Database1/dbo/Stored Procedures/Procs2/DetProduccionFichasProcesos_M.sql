--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionFichasProcesos_M
@IdDetalleProduccionFichaProceso int,
@IdProduccionFicha int,
@IdProduccionProceso int,
@Horas numeric(12,2),
@Observaciones ntext
AS
UPDATE [DetalleProduccionFichaProcesos]
SET 
 IdProduccionFicha=@IdProduccionFicha,
 IdProduccionProceso=@IdProduccionProceso,
 Horas=@Horas,
 Observaciones=@Observaciones
WHERE (IdDetalleProduccionFichaProceso=@IdDetalleProduccionFichaProceso)
RETURN(@IdDetalleProduccionFichaProceso)
