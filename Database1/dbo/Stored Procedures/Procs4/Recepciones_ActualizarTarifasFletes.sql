CREATE Procedure [dbo].[Recepciones_ActualizarTarifasFletes]

@IdTarifaFlete int,
@IdTipoComprobante int,
@IdDetalleComprobante int

AS

DECLARE @TarifaFlete numeric(18,2), @CodigoTarifador varchar(10), @IdComprobante int

SET @TarifaFlete=IsNull((Select Top 1 ValorUnitario From TarifasFletes Where IdTarifaFlete=@IdTarifaFlete),0)
SET @CodigoTarifador=IsNull((Select Top 1 Codigo From TarifasFletes Where IdTarifaFlete=@IdTarifaFlete),'')

IF @IdTipoComprobante=50
    BEGIN
	SET @IdComprobante=IsNull((Select Top 1 IdSalidaMateriales From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleComprobante),0)

	UPDATE SalidasMateriales
	SET IdTarifaFlete=@IdTarifaFlete, CodigoTarifador=@CodigoTarifador, TarifaFlete=@TarifaFlete
	WHERE IdSalidaMateriales=@IdComprobante
    END

IF @IdTipoComprobante=60
    BEGIN
	SET @IdComprobante=IsNull((Select Top 1 IdRecepcion From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleComprobante),0)

	UPDATE Recepciones
	SET IdTarifaFlete=@IdTarifaFlete, CodigoTarifador=@CodigoTarifador, TarifaFlete=@TarifaFlete
	WHERE IdRecepcion=@IdComprobante
    END