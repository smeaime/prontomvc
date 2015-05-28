
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionFichasProcesos_A


@IdDetalleProduccionFichaProceso int output,
@IdProduccionFicha int,
@IdProduccionProceso int,
@Horas numeric(12,2),
@Observaciones ntext

AS 
INSERT INTO [DetalleProduccionFichaProcesos]
(
 IdProduccionFicha,
 IdProduccionProceso,
 Horas,
 Observaciones
)
VALUES
(
 @IdProduccionFicha,
 @IdProduccionProceso,
 @Horas,
 @Observaciones
)
SELECT @IdDetalleProduccionFichaProceso=@@identity
RETURN(@IdDetalleProduccionFichaProceso)

