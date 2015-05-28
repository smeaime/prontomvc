
CREATE Procedure [dbo].[wPedidos_A]

@IdPedido int,
@NumeroPedido int,
@IdProveedor int,
@FechaPedido datetime,
@LugarEntrega ntext,
@FormaPago ntext,
@Observaciones ntext,
@Bonificacion numeric(12,2),
@TotalIva1 numeric(12,2),
@TotalPedido numeric(12,2),
@PorcentajeIva1 numeric(6,2),
@IdComprador int,
@PorcentajeBonificacion numeric(6,2),
@NumeroComparativa int,
@Contacto varchar(50),
@PlazoEntrega ntext,
@Garantia ntext,
@Documentacion ntext,
@Aprobo int,
@IdMoneda int,
@FechaAprobacion datetime,
@Importante ntext,
@TipoCompra int,
@Cumplido varchar(2),
@DetalleCondicionCompra varchar(200),
@IdAutorizoCumplido int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
@SubNumero int,
@UsuarioAnulacion varchar(6),
@FechaAnulacion datetime,
@MotivoAnulacion ntext,
@ImprimeImportante varchar(2),
@ImprimePlazoEntrega varchar(2),
@ImprimeLugarEntrega varchar(2),
@ImprimeFormaPago varchar(2),
@ImprimeImputaciones varchar(2),
@ImprimeInspecciones varchar(2),
@ImprimeGarantia varchar(2),
@ImprimeDocumentacion varchar(2),
@CotizacionDolar numeric(18,3),
@CotizacionMoneda numeric(18,3),
@PedidoExterior varchar(2),
@IdCondicionCompra int,
@IdPedidoOriginal int,
@IdOrigenTransmision int,
@FechaImportacionTransmision datetime,
@Subcontrato varchar(2),
@IdPedidoAbierto int,
@NumeroLicitacion varchar(20),
@Transmitir_a_SAT varchar(2),
@NumeracionAutomatica varchar(2),
@Impresa varchar(2),
@EmbarcadoA varchar(50),
@FacturarA varchar(50),
@ProveedorExt varchar(50),
@ImpuestosInternos numeric(18,2),
@FechaSalida datetime,
@CodigoControl numeric(10,0),
@CircuitoFirmasCompleto varchar(2)

AS

DECLARE @ReturnValue int

IF IsNull(@IdPedido,0)<=0
    BEGIN
	BEGIN TRAN
	IF @IdOrigenTransmision IS NULL AND ISNULL(@NumeracionAutomatica,'NO')='SI'
	   BEGIN
		IF @PedidoExterior='NO'
		   BEGIN
			Set @NumeroPedido=IsNull((Select Top 1 P.ProximoNumeroPedido
								From Parametros P Where P.IdParametro=1),1)
			Update Parametros
			Set ProximoNumeroPedido=@NumeroPedido+1
		   END
		ELSE
		   BEGIN
			Set @NumeroPedido=IsNull((Select Top 1 P.ProximoNumeroPedidoExterior
								From Parametros P Where P.IdParametro=1),1)
			Update Parametros
			Set ProximoNumeroPedidoExterior=@NumeroPedido+1
		   END
	   END
	
	SET @CodigoControl=Convert(numeric(10,0),RAND()*10000000000)
	
	INSERT INTO Pedidos
	(
	 NumeroPedido,
	 IdProveedor,
	 FechaPedido,
	 LugarEntrega,
	 FormaPago,
	 Observaciones,
	 Bonificacion,
	 TotalIva1,
	 TotalPedido,
	 PorcentajeIva1,
	 IdComprador,
	 PorcentajeBonificacion,
	 NumeroComparativa,
	 Contacto,
	 PlazoEntrega,
	 Garantia,
	 Documentacion,
	 Aprobo,
	 IdMoneda,
	 FechaAprobacion,
	 Importante,
	 TipoCompra,
	 Cumplido,
	 DetalleCondicionCompra,
	 IdAutorizoCumplido,
	 IdDioPorCumplido,
	 FechaDadoPorCumplido,
	 ObservacionesCumplido,
	 SubNumero,
	 UsuarioAnulacion,
	 FechaAnulacion,
	 MotivoAnulacion,
	 ImprimeImportante,
	 ImprimePlazoEntrega,
	 ImprimeLugarEntrega, 
	 ImprimeFormaPago,
	 ImprimeImputaciones,
	 ImprimeInspecciones,
	 ImprimeGarantia,
	 ImprimeDocumentacion,
	 CotizacionDolar,
	 CotizacionMoneda,
	 PedidoExterior,
	 IdCondicionCompra,
	 IdPedidoOriginal,
	 IdOrigenTransmision,
	 FechaImportacionTransmision,
	 Subcontrato,
	 IdPedidoAbierto,
	 NumeroLicitacion,
	 Transmitir_a_SAT,
	 NumeracionAutomatica,
	 Impresa,
	 EmbarcadoA,
	 FacturarA,
	 ProveedorExt,
	 ImpuestosInternos,
	 FechaSalida,
	 CodigoControl,
	 CircuitoFirmasCompleto
	)
	VALUES
	(
	 @NumeroPedido,
	 @IdProveedor,
	 @FechaPedido,
	 @LugarEntrega,
	 @FormaPago,
	 @Observaciones,
	 @Bonificacion,
	 @TotalIva1,
	 @TotalPedido,
	 @PorcentajeIva1,
	 @IdComprador,
	 @PorcentajeBonificacion,
	 @NumeroComparativa,
	 @Contacto,
	 @PlazoEntrega,
	 @Garantia,
	 @Documentacion,
	 @Aprobo,
	 @IdMoneda,
	 @FechaAprobacion,
	 @Importante,
	 @TipoCompra,
	 @Cumplido,
	 @DetalleCondicionCompra,
	 @IdAutorizoCumplido,
	 @IdDioPorCumplido,
	 @FechaDadoPorCumplido,
	 @ObservacionesCumplido,
	 @SubNumero,
	 @UsuarioAnulacion,
	 @FechaAnulacion,
	 @MotivoAnulacion,
	 @ImprimeImportante,
	 @ImprimePlazoEntrega,
	 @ImprimeLugarEntrega, 
	 @ImprimeFormaPago,
	 @ImprimeImputaciones,
	 @ImprimeInspecciones,
	 @ImprimeGarantia,
	 @ImprimeDocumentacion,
	 @CotizacionDolar,
	 @CotizacionMoneda,
	 @PedidoExterior,
	 @IdCondicionCompra,
	 @IdPedidoOriginal,
	 @IdOrigenTransmision,
	 @FechaImportacionTransmision,
	 @Subcontrato,
	 @IdPedidoAbierto,
	 @NumeroLicitacion,
	 @Transmitir_a_SAT,
	 @NumeracionAutomatica,
	 @Impresa,
	 @EmbarcadoA,
	 @FacturarA,
	 @ProveedorExt,
	 @ImpuestosInternos,
	 @FechaSalida,
	 @CodigoControl,
	 @CircuitoFirmasCompleto
	)

	SELECT @ReturnValue = SCOPE_IDENTITY()
	
	IF @@ERROR <> 0
	    BEGIN
		ROLLBACK TRAN
		RETURN -1
	    END
	ELSE
	    BEGIN
		COMMIT TRAN
	    END
    END
ELSE
    BEGIN
	UPDATE Pedidos
	SET 
	 NumeroPedido=@NumeroPedido,
	 IdProveedor=@IdProveedor,
	 FechaPedido=@FechaPedido,
	 LugarEntrega=@LugarEntrega,
	 FormaPago=@FormaPago,
	 Observaciones=@Observaciones,
	 Bonificacion=@Bonificacion,
	 TotalIva1=@TotalIva1,
	 TotalPedido=@TotalPedido,
	 PorcentajeIva1=@PorcentajeIva1,
	 IdComprador=@IdComprador,
	 PorcentajeBonificacion=@PorcentajeBonificacion,
	 NumeroComparativa=@NumeroComparativa,
	 Contacto=@Contacto,
	 PlazoEntrega=@PlazoEntrega,
	 Garantia=@Garantia,
	 Documentacion=@Documentacion,
	 Aprobo=@Aprobo,
	 IdMoneda=@IdMoneda,
	 FechaAprobacion=@FechaAprobacion,
	 Importante=@Importante,
	 TipoCompra=@TipoCompra,
	 Cumplido=@Cumplido,
	 DetalleCondicionCompra=@DetalleCondicionCompra,
	 IdAutorizoCumplido=@IdAutorizoCumplido,
	 IdDioPorCumplido=@IdDioPorCumplido,
	 FechaDadoPorCumplido=@FechaDadoPorCumplido,
	 ObservacionesCumplido=@ObservacionesCumplido,
	 SubNumero=@SubNumero,
	 UsuarioAnulacion=@UsuarioAnulacion,
	 FechaAnulacion=@FechaAnulacion,
	 MotivoAnulacion=@MotivoAnulacion,
	 ImprimeImportante=@ImprimeImportante,
	 ImprimePlazoEntrega=@ImprimePlazoEntrega,
	 ImprimeLugarEntrega=@ImprimeLugarEntrega,
	 ImprimeFormaPago=@ImprimeFormaPago,
	 ImprimeImputaciones=@ImprimeImputaciones,
	 ImprimeInspecciones=@ImprimeInspecciones,
	 ImprimeGarantia=@ImprimeGarantia,
	 ImprimeDocumentacion=@ImprimeDocumentacion,
	 CotizacionDolar=@CotizacionDolar,
	 CotizacionMoneda=@CotizacionMoneda,
	 PedidoExterior=@PedidoExterior,
	 IdCondicionCompra=@IdCondicionCompra,
	 IdPedidoOriginal=@IdPedidoOriginal,
	 IdOrigenTransmision=@IdOrigenTransmision,
	 FechaImportacionTransmision=@FechaImportacionTransmision,
	 Subcontrato=@Subcontrato,
	 IdPedidoAbierto=@IdPedidoAbierto,
	 NumeroLicitacion=@NumeroLicitacion,
	 Transmitir_a_SAT=@Transmitir_a_SAT,
	 NumeracionAutomatica=@NumeracionAutomatica,
	 Impresa=@Impresa,
	 EmbarcadoA=@EmbarcadoA,
	 FacturarA=@FacturarA,
	 ProveedorExt=@ProveedorExt,
	 ImpuestosInternos=@ImpuestosInternos,
	 FechaSalida=@FechaSalida,
	 CodigoControl=@CodigoControl,
	 CircuitoFirmasCompleto=@CircuitoFirmasCompleto
	WHERE (IdPedido=@IdPedido)

	SELECT @ReturnValue = @IdPedido
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @ReturnValue

