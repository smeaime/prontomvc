CREATE Procedure [dbo].[Pedidos_A]

@IdPedido int  output,
@NumeroPedido int,
@IdProveedor int,
@FechaPedido datetime,
@LugarEntrega ntext,
@FormaPago ntext,
@Observaciones ntext,
@Bonificacion numeric(18,2),
@TotalIva1 numeric(18,2),
@TotalIva2 numeric(18,2),
@TotalPedido numeric(18,2),
@PorcentajeIva1 numeric(6,2),
@PorcentajeIva2 numeric(6,2),
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
@Consorcial varchar(2),
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
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100),
@ArchivoAdjunto3 varchar(100),
@ArchivoAdjunto4 varchar(100),
@ArchivoAdjunto5 varchar(100),
@ArchivoAdjunto6 varchar(100),
@ArchivoAdjunto7 varchar(100),
@ArchivoAdjunto8 varchar(100),
@ArchivoAdjunto9 varchar(100),
@ArchivoAdjunto10 varchar(100),
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
@PRESTOPedido varchar(13),
@PRESTOFechaProceso datetime,
@IdCondicionCompra int,
@EnviarEmail tinyint,
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
@CircuitoFirmasCompleto varchar(2),
@OtrosConceptos1 numeric(18,2),
@OtrosConceptos2 numeric(18,2),
@OtrosConceptos3 numeric(18,2),
@OtrosConceptos4 numeric(18,2),
@OtrosConceptos5 numeric(18,2),
@IdClausula int,
@IncluirObservacionesRM varchar(2),
@NumeroSubcontrato int,
@IdPuntoVenta int,
@PuntoVenta int,
@IdMonedaOriginal int,
@IdLugarEntrega int,
@ConfirmadoPorWeb   varchar(2),
@IdTipoCompraRM int,
@FechaEnvioProveedor datetime,
@IdUsuarioEnvioProveedor int,
@IdPlazoEntrega int

AS

BEGIN TRAN

IF @IdOrigenTransmision IS NULL AND ISNULL(@NumeracionAutomatica,'NO')='SI'
    BEGIN
	IF IsNull(@IdPuntoVenta,0)>0 
	    BEGIN
		SET @NumeroPedido=IsNull((Select Top 1 ProximoNumero From PuntosVenta Where IdPuntoVenta=@IdPuntoVenta),1)
		UPDATE PuntosVenta
		SET ProximoNumero=@NumeroPedido+1
		WHERE IdPuntoVenta=@IdPuntoVenta
	    END
	ELSE
	    BEGIN
		IF @PedidoExterior='NO'
		    BEGIN
			SET @NumeroPedido=IsNull((Select Top 1 ProximoNumeroPedido From Parametros Where IdParametro=1),1)
			UPDATE Parametros
			SET ProximoNumeroPedido=@NumeroPedido+1
		    END
		ELSE
		    BEGIN
			SET @NumeroPedido=IsNull((Select Top 1 ProximoNumeroPedidoExterior From Parametros Where IdParametro=1),1)
			UPDATE Parametros
			SET ProximoNumeroPedidoExterior=@NumeroPedido+1
		    END
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
 TotalIva2,
 TotalPedido,
 PorcentajeIva1,
 PorcentajeIva2,
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
 Consorcial,
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
 ArchivoAdjunto1,
 ArchivoAdjunto2,
 ArchivoAdjunto3,
 ArchivoAdjunto4,
 ArchivoAdjunto5,
 ArchivoAdjunto6,
 ArchivoAdjunto7,
 ArchivoAdjunto8,
 ArchivoAdjunto9,
 ArchivoAdjunto10,
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
 PRESTOPedido,
 PRESTOFechaProceso,
 IdCondicionCompra,
 EnviarEmail,
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
 CircuitoFirmasCompleto,
 OtrosConceptos1,
 OtrosConceptos2,
 OtrosConceptos3,
 OtrosConceptos4,
 OtrosConceptos5,
 IdClausula,
 IncluirObservacionesRM,
 NumeroSubcontrato,
 IdPuntoVenta,
 PuntoVenta,
 IdMonedaOriginal,
 IdLugarEntrega,
 ConfirmadoPorWeb,
 IdTipoCompraRM,
 FechaEnvioProveedor,
 IdUsuarioEnvioProveedor,
 IdPlazoEntrega
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
 @TotalIva2,
 @TotalPedido,
 @PorcentajeIva1,
 @PorcentajeIva2,
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
 @Consorcial,
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
 @ArchivoAdjunto1,
 @ArchivoAdjunto2,
 @ArchivoAdjunto3,
 @ArchivoAdjunto4,
 @ArchivoAdjunto5,
 @ArchivoAdjunto6,
 @ArchivoAdjunto7,
 @ArchivoAdjunto8,
 @ArchivoAdjunto9,
 @ArchivoAdjunto10,
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
 @PRESTOPedido,
 @PRESTOFechaProceso,
 @IdCondicionCompra,
 @EnviarEmail,
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
 @CircuitoFirmasCompleto,
 @OtrosConceptos1,
 @OtrosConceptos2,
 @OtrosConceptos3,
 @OtrosConceptos4,
 @OtrosConceptos5,
 @IdClausula,
 @IncluirObservacionesRM,
 @NumeroSubcontrato,
 @IdPuntoVenta,
 @PuntoVenta,
 @IdMonedaOriginal,
 @IdLugarEntrega,
 @ConfirmadoPorWeb,
 @IdTipoCompraRM,
 @FechaEnvioProveedor,
 @IdUsuarioEnvioProveedor,
 @IdPlazoEntrega
)

SELECT @IdPedido=@@identity

IF IsNull(@Aprobo,0)>0 and IsNull(@CircuitoFirmasCompleto,'NO')='NO' 
    BEGIN
	DECLARE @RespetarPrecedencia varchar(2)

	SET @RespetarPrecedencia=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Respetar precedencia en circuito de firmas'),'NO')

	EXEC AutorizacionesPorComprobante_Generar @RespetarPrecedencia

	IF Not Exists(Select Top 1 IdComprobante From _TempAutorizaciones Where IdFormulario=4 and IdComprobante=@IdPedido)
		UPDATE Pedidos
		SET CircuitoFirmasCompleto='SI'
		WHERE IdPedido=@IdPedido
    END

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdPedido)