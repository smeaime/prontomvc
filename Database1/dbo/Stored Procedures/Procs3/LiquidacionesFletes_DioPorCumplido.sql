CREATE Procedure [dbo].[LiquidacionesFletes_DioPorCumplido]

@IdTipoComprobante int,
@IdComprobante int,
@IdUsuarioDioPorCumplidoLiquidacionFletes int,
@ObservacionDioPorCumplidoLiquidacionFletes ntext

AS 

IF @IdTipoComprobante=60
	UPDATE DetalleRecepciones
	SET IdUsuarioDioPorCumplidoLiquidacionFletes=@IdUsuarioDioPorCumplidoLiquidacionFletes,
		FechaDioPorCumplidoLiquidacionFletes=GetDate(),
		ObservacionDioPorCumplidoLiquidacionFletes=@ObservacionDioPorCumplidoLiquidacionFletes
	WHERE IdDetalleRecepcion=@IdComprobante

IF @IdTipoComprobante=50
	UPDATE DetalleSalidasMateriales
	SET IdUsuarioDioPorCumplidoLiquidacionFletes=@IdUsuarioDioPorCumplidoLiquidacionFletes,
		FechaDioPorCumplidoLiquidacionFletes=GetDate(),
		ObservacionDioPorCumplidoLiquidacionFletes=@ObservacionDioPorCumplidoLiquidacionFletes
	WHERE IdDetalleSalidaMateriales=@IdComprobante

IF @IdTipoComprobante=120
	UPDATE GastosFletes
	SET IdUsuarioDioPorCumplidoLiquidacionFletes=@IdUsuarioDioPorCumplidoLiquidacionFletes,
		FechaDioPorCumplidoLiquidacionFletes=GetDate(),
		ObservacionDioPorCumplidoLiquidacionFletes=@ObservacionDioPorCumplidoLiquidacionFletes
	WHERE IdGastoFlete=@IdComprobante