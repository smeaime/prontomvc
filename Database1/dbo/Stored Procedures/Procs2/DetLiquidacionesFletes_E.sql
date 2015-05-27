CREATE Procedure [dbo].[DetLiquidacionesFletes_E]

@IdDetalleLiquidacionFlete int  

AS 

BEGIN TRAN

DECLARE @IdTipoComprobante int, @IdComprobante int

SET @IdTipoComprobante=IsNull((Select Top 1 IdTipoComprobante From DetalleLiquidacionesFletes Where IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete),0)
SET @IdComprobante=IsNull((Select Top 1 IdComprobante From DetalleLiquidacionesFletes Where IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete),0)

IF @IdTipoComprobante=60
	UPDATE DetalleRecepciones
	SET IdDetalleLiquidacionFlete=Null
	WHERE IdDetalleRecepcion=@IdComprobante
IF @IdTipoComprobante=50
	UPDATE DetalleSalidasMateriales
	SET IdDetalleLiquidacionFlete=Null
	WHERE IdDetalleSalidaMateriales=@IdComprobante
IF @IdTipoComprobante=120
	UPDATE GastosFletes
	SET IdDetalleLiquidacionFlete=Null
	WHERE IdGastoFlete=@IdComprobante

DELETE [DetalleLiquidacionesFletes]
WHERE (IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete)

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction: