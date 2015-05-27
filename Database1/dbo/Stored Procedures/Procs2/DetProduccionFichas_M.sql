
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure DetProduccionFichas_M

	@IdDetalleProduccionFicha int ,
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

UPDATE [DetalleProduccionFichas]
SET 
 IdProduccionFicha=@IdProduccionFicha,
 IdArticulo=@IdArticulo,
 IdStock=@IdStock,
 Partida=@Partida,
 Cantidad=@Cantidad,
 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 Observaciones=@Observaciones,
 Porcentaje=@Porcentaje,
 Tolerancia=@Tolerancia,
 IdProduccionProceso=@IdProduccionProceso,
 IdColor=@IdColor

WHERE (IdDetalleProduccionFicha=@IdDetalleProduccionFicha)




IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleProduccionFicha)
