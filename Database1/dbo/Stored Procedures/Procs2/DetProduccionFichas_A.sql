
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionFichas_A

	@IdDetalleProduccionFicha int  output,
	@IdProduccionFicha int,

	@IdArticulo int,
	@IdStock int,
	@Partida varchar(20),
	@Cantidad numeric(12,2),
	@CantidadAdicional numeric(12,2),
	@IdUnidad int,
	@Cantidad1 numeric(12,2),
	@Cantidad2 numeric(12,2),
	@Observaciones ntext,
	
	@Porcentaje numeric(18,2),
	@Tolerancia numeric(18,2),

	@IdProduccionProceso INT,
	@IdColor int

AS 

BEGIN TRAN


INSERT INTO [DetalleProduccionFichas]
(
 IdProduccionFicha,

 IdArticulo,
 IdStock,
 Partida,
 Cantidad,
 CantidadAdicional,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 Observaciones,
Porcentaje,
Tolerancia,
IdProduccionProceso,
IdColor
)
VALUES 
(

 @IdProduccionFicha,

 @IdArticulo,
 @IdStock,
 @Partida,
 @Cantidad,
 @CantidadAdicional,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @Observaciones,
 @Porcentaje,
@Tolerancia,
@IdProduccionProceso,
@IdColor

)
SELECT @IdDetalleProduccionFicha=@@identity




IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleProduccionFicha)
