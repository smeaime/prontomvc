CREATE Procedure [dbo].[DetLiquidacionesFletes_A]

@IdDetalleLiquidacionFlete int  output,
@IdLiquidacionFlete int,
@IdTipoComprobante int,
@IdComprobante int,
@Importe numeric(18,2),
@IdTarifaFlete int,
@ValorUnitarioTarifa numeric(18,2),
@EquivalenciaAUnidadTarifa numeric(18,6),
@Tipo varchar(12)

AS 

BEGIN TRAN

INSERT INTO [DetalleLiquidacionesFletes]
(
 IdLiquidacionFlete,
 IdTipoComprobante,
 IdComprobante,
 Importe,
 IdTarifaFlete,
 ValorUnitarioTarifa,
 EquivalenciaAUnidadTarifa,
 Tipo
)
VALUES 
(
 @IdLiquidacionFlete,
 @IdTipoComprobante,
 @IdComprobante,
 @Importe,
 @IdTarifaFlete,
 @ValorUnitarioTarifa,
 @EquivalenciaAUnidadTarifa,
 @Tipo
)
SELECT @IdDetalleLiquidacionFlete=@@identity

IF @IdTipoComprobante=60
	UPDATE DetalleRecepciones
	SET IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete
	WHERE IdDetalleRecepcion=@IdComprobante
IF @IdTipoComprobante=50
	UPDATE DetalleSalidasMateriales
	SET IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete
	WHERE IdDetalleSalidaMateriales=@IdComprobante
IF @IdTipoComprobante=120
	UPDATE GastosFletes
	SET IdDetalleLiquidacionFlete=@IdDetalleLiquidacionFlete
	WHERE IdGastoFlete=@IdComprobante

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdDetalleLiquidacionFlete)