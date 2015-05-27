CREATE Procedure [dbo].[Pedidos_CambiarCostos]

@IdDetallePedido int, 
@IdDetalleRecepcion int, 
@IdDetalleSalidaMateriales int, 
@Costo numeric(18,4), 
@IdUsuario int, 
@Motivo ntext,
@IdMoneda int

AS 

SET NOCOUNT ON

DECLARE @IdComprobante int, @Fecha datetime, @CotizacionMoneda numeric(18,3), @PrecioAnterior numeric(18,3), @SubNumero int

IF @IdDetallePedido>0
    BEGIN
	SET @IdComprobante=IsNull((Select Top 1 IdPedido From DetallePedidos Where IdDetallePedido=@IdDetallePedido),0)
	SET @Fecha=IsNull((Select Top 1 FechaPedido From Pedidos Where IdPedido=@IdComprobante),0)
	SET @CotizacionMoneda=IsNull((Select Top 1 CotizacionLibre From Cotizaciones Where Fecha=@Fecha And IdMoneda=@IdMoneda),1)
	SET @PrecioAnterior=IsNull((Select Top 1 Precio From DetallePedidos Where IdDetallePedido=@IdDetallePedido),0)
	SET @SubNumero=IsNull((Select Top 1 SubNumero From Pedidos Where IdPedido=@IdComprobante),0)+1

	INSERT INTO DetallePedidosCambiosPrecio
	(IdDetallePedido, Fecha, IdUsuario, Observaciones, PrecioAnterior, PrecioNuevo)
	VALUES
	(@IdDetallePedido, GetDate(), @IdUsuario, @Motivo, @PrecioAnterior, @Costo)

	IF (Select Top 1 CostoOriginal From DetallePedidos Where IdDetallePedido=@IdDetallePedido) is null
	    BEGIN
		UPDATE DetallePedidos
		SET CostoOriginal=Precio
		WHERE IdDetallePedido=@IdDetallePedido

		UPDATE Pedidos
		SET IdMonedaOriginal=IdMoneda
		WHERE IdPedido=@IdComprobante
	    END

	UPDATE DetallePedidos
	SET Precio=@Costo, IdUsuarioModificoCosto=@IdUsuario, FechaModificacionCosto=GetDate(), ObservacionModificacionCosto=@Motivo
	WHERE IdDetallePedido=@IdDetallePedido

	UPDATE Pedidos
	SET IdMoneda=@IdMoneda, CotizacionMoneda=@CotizacionMoneda, SubNumero=@SubNumero
	WHERE IdPedido=@IdComprobante

	EXEC Pedidos_RecalcularTotales @IdComprobante
    END
IF @IdDetalleRecepcion>0
    BEGIN
	SET @IdComprobante=IsNull((Select Top 1 IdRecepcion From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion),0)
	SET @Fecha=IsNull((Select Top 1 FechaRecepcion From Recepciones Where IdRecepcion=@IdComprobante),0)
	SET @CotizacionMoneda=IsNull((Select Top 1 CotizacionLibre From Cotizaciones Where Fecha=@Fecha And IdMoneda=@IdMoneda),1)

	IF (Select Top 1 CostoOriginal From DetalleRecepciones Where IdDetalleRecepcion=@IdDetalleRecepcion) is null
		UPDATE DetalleRecepciones
		SET CostoOriginal=CostoUnitario, IdMonedaOriginal=IdMoneda
		WHERE IdDetalleRecepcion=@IdDetalleRecepcion

	UPDATE DetalleRecepciones
	SET CostoUnitario=@Costo, IdUsuarioModificoCosto=@IdUsuario, FechaModificacionCosto=GetDate(), ObservacionModificacionCosto=@Motivo, 
		IdMoneda=@IdMoneda, CotizacionMoneda=@CotizacionMoneda
	WHERE IdDetalleRecepcion=@IdDetalleRecepcion
    END

IF @IdDetalleSalidaMateriales>0
    BEGIN
	SET @IdComprobante=IsNull((Select Top 1 IdSalidaMateriales From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales),0)
	SET @Fecha=IsNull((Select Top 1 FechaSalidaMateriales From SalidasMateriales Where IdSalidaMateriales=@IdComprobante),0)
	SET @CotizacionMoneda=IsNull((Select Top 1 CotizacionLibre From Cotizaciones Where Fecha=@Fecha And IdMoneda=@IdMoneda),1)

	IF (Select Top 1 CostoOriginal From DetalleSalidasMateriales Where IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales) is null
		UPDATE DetalleSalidasMateriales
		SET CostoOriginal=CostoUnitario, IdMonedaOriginal=IdMoneda
		WHERE IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales
	UPDATE DetalleSalidasMateriales
	SET CostoUnitario=@Costo, IdUsuarioModificoCosto=@IdUsuario, FechaModificacionCosto=GetDate(), ObservacionModificacionCosto=@Motivo, 
		IdMoneda=@IdMoneda, CotizacionMoneda=@CotizacionMoneda
	WHERE IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales
    END

SET NOCOUNT OFF