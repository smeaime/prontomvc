CREATE Procedure [dbo].[DetComprobantesProveedores_A]

@IdDetalleComprobanteProveedor int  output,
@IdComprobanteProveedor int,
@IdArticulo int,
@CodigoArticulo varchar(8),
@IdCuenta int,
@CodigoCuenta varchar(10),
@PorcentajeIvaAplicado numeric(6,2),
@Importe numeric(12,2),
@IdCuentaGasto int,
@IdCuentaIvaCompras1 int,
@IVAComprasPorcentaje1 numeric(6,2),
@ImporteIVA1 numeric(18,2),
@AplicarIVA1 varchar(2),
@IdCuentaIvaCompras2 int,
@IVAComprasPorcentaje2 numeric(6,2),
@ImporteIVA2 numeric(18,2),
@AplicarIVA2 varchar(2),
@IdCuentaIvaCompras3 int,
@IVAComprasPorcentaje3 numeric(6,2),
@ImporteIVA3 numeric(18,2),
@AplicarIVA3 varchar(2),
@IdCuentaIvaCompras4 int,
@IVAComprasPorcentaje4 numeric(6,2),
@ImporteIVA4 numeric(18,2),
@AplicarIVA4 varchar(2),
@IdCuentaIvaCompras5 int,
@IVAComprasPorcentaje5 numeric(6,2),
@ImporteIVA5 numeric(18,2),
@AplicarIVA5 varchar(2),
@IdObra int,
@Item int,
@IdCuentaIvaCompras6 int,
@IVAComprasPorcentaje6 numeric(6,2),
@ImporteIVA6 numeric(18,2),
@AplicarIVA6 varchar(2),
@IdCuentaIvaCompras7 int,
@IVAComprasPorcentaje7 numeric(6,2),
@ImporteIVA7 numeric(18,2),
@AplicarIVA7 varchar(2),
@IdCuentaIvaCompras8 int,
@IVAComprasPorcentaje8 numeric(6,2),
@ImporteIVA8 numeric(18,2),
@AplicarIVA8 varchar(2),
@IdCuentaIvaCompras9 int,
@IVAComprasPorcentaje9 numeric(6,2),
@ImporteIVA9 numeric(18,2),
@AplicarIVA9 varchar(2),
@IdCuentaIvaCompras10 int,
@IVAComprasPorcentaje10 numeric(6,2),
@ImporteIVA10 numeric(18,2),
@AplicarIVA10 varchar(2),
@IVAComprasPorcentajeDirecto numeric(6,2),
@IdCuentaBancaria int,
@PRESTOConcepto varchar(13),
@PRESTOObra varchar(13),
@IdDetalleRecepcion int,
@TomarEnCalculoDeImpuestos varchar(2),
@IdRubroContable int,
@IdPedido int,
@IdDetallePedido int,
@Importacion_FOB numeric(18,2),
@Importacion_PosicionAduana varchar(20),
@Importacion_Despacho varchar(30),
@Importacion_Guia varchar(20),
@Importacion_IdPaisOrigen int,
@Importacion_FechaEmbarque datetime,
@Importacion_FechaOficializacion datetime,
@IdProvinciaDestino1 int,
@PorcentajeProvinciaDestino1 numeric(6,2),
@IdProvinciaDestino2 int,
@PorcentajeProvinciaDestino2 numeric(6,2),
@IdDistribucionObra int,
@Cantidad numeric(18,2),
@IdDetalleObraDestino int,
@IdPresupuestoObraRubro int,
@IdPedidoAnticipo int,
@PorcentajeAnticipo numeric(6,2),
@PorcentajeCertificacion numeric(6,2),
@IdPresupuestoObrasNodo int,
@IdDetalleComprobanteProveedorOriginal int,
@NumeroSubcontrato int,
@IdSubcontrato int,
@AmpliacionSubcontrato varchar(2),
@IdDetalleSubcontratoDatos int,
@IdEquipoDestino int,
@IdUsuarioModificoCuenta int,
@FechaModificacionCuenta datetime

AS 

IF @IdDetalleRecepcion is null and @IdDetallePedido is not null
    BEGIN
	DECLARE @Letra varchar(1),@NumeroComprobante1 int,@NumeroComprobante2 int, @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP varchar(2)

	SET @Letra=IsNull((Select Top 1 Letra From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),'')
	SET @NumeroComprobante1=IsNull((Select Top 1 NumeroComprobante1 From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),0)
	SET @NumeroComprobante2=IsNull((Select Top 1 NumeroComprobante2 From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),0)

	SET @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP=IsNull((Select Top 1 Valor From Parametros2 Where Campo='DesactivarDarPorCumplidoPedidoSinRecepcionEnCP'),'NO')
	IF @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP='NO'
	    BEGIN
		UPDATE DetallePedidos
		SET Cumplido = 'SI', IdDioPorCumplido=0, FechaDadoPorCumplido=GetDate(), 
			ObservacionesCumplido='Comprobante proveedor '+
				@Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,@NumeroComprobante1)))+Convert(varchar,@NumeroComprobante1)+'-'+
					Substring('00000000',1,8-Len(Convert(varchar,@NumeroComprobante2)))+Convert(varchar,@NumeroComprobante2)
		WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and IsNull(Cumplido,'NO')<>'SI' 
		
		EXEC Pedidos_ActualizarEstadoPorIdPedido @IdPedido
	    END
    END

DECLARE @CostoReposicionPorComprobanteProveedor varchar(2)

SET @CostoReposicionPorComprobanteProveedor=IsNull((Select Top 1 Valor From Parametros2 Where Campo='CostoReposicionPorComprobanteProveedor'),'SI')

IF @IdArticulo is not null and @CostoReposicionPorComprobanteProveedor='SI'
    BEGIN
	DECLARE @FechaComprobante datetime, @FechaUltimoCostoReposicion datetime, @CotizacionMoneda numeric(18,4), @CotizacionDolar numeric(18,4), 
		@CostoReposicion numeric(18,2), @CostoReposicionDolar numeric(18,2), @IdMonedaRecepcion int, @IdMonedaComprobante int

	SET @FechaComprobante=IsNull((Select Top 1 FechaComprobante From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),Convert(datetime,'01/01/2000'))
	SET @CotizacionMoneda=IsNull((Select Top 1 CotizacionMoneda From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),1)
	SET @CotizacionDolar=IsNull((Select Top 1 CotizacionDolar From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),1)
	SET @IdMonedaComprobante=IsNull((Select Top 1 IdMoneda From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),1)
	SET @IdMonedaRecepcion=IsNull((Select Top 1 IdMoneda From DetalleRecepciones Where DetalleRecepciones.IdDetalleRecepcion=@IdDetalleRecepcion),1)
	SET @CostoReposicion=0
	SET @CostoReposicionDolar=0

	IF IsNull(@Cantidad,0)<>0
		SET @CostoReposicion=Round(@Importe / @Cantidad * @CotizacionMoneda,2)
	IF IsNull(@Cantidad,0)<>0 and @CotizacionDolar<>0
		SET @CostoReposicionDolar=Round(@Importe / @Cantidad * @CotizacionMoneda / @CotizacionDolar,2)
	SET @FechaUltimoCostoReposicion=IsNull((Select Top 1 Articulos.FechaUltimoCostoReposicion From Articulos
						Where Articulos.IdArticulo=@IdArticulo),Convert(datetime,'01/01/2000'))
	IF @FechaComprobante>=@FechaUltimoCostoReposicion and @CostoReposicion<>0 and @CostoReposicionDolar<>0
		UPDATE Articulos 
		SET CostoReposicion=@CostoReposicion, CostoReposicionDolar=@CostoReposicionDolar, FechaUltimoCostoReposicion=@FechaComprobante
		WHERE Articulos.IdArticulo=@IdArticulo

	IF IsNull(@IdDetalleRecepcion,0)<>0 and @CotizacionMoneda<>0 and @IdMonedaComprobante=@IdMonedaRecepcion
		UPDATE DetalleRecepciones 
		SET CostoUnitario=@CostoReposicion/@CotizacionMoneda
		WHERE DetalleRecepciones.IdDetalleRecepcion=@IdDetalleRecepcion
    END

INSERT INTO [DetalleComprobantesProveedores]
(
 IdComprobanteProveedor,
 IdArticulo,
 CodigoArticulo,
 IdCuenta,
 CodigoCuenta,
 PorcentajeIvaAplicado,
 Importe,
 IdCuentaGasto,
 IdCuentaIvaCompras1,
 IVAComprasPorcentaje1,
 ImporteIVA1,
 AplicarIVA1,
 IdCuentaIvaCompras2,
 IVAComprasPorcentaje2,
 ImporteIVA2,
 AplicarIVA2,
 IdCuentaIvaCompras3,
 IVAComprasPorcentaje3,
 ImporteIVA3,
 AplicarIVA3,
 IdCuentaIvaCompras4,
 IVAComprasPorcentaje4,
 ImporteIVA4,
 AplicarIVA4,
 IdCuentaIvaCompras5,
 IVAComprasPorcentaje5,
 ImporteIVA5,
 AplicarIVA5,
 IdObra,
 Item,
 IdCuentaIvaCompras6,
 IVAComprasPorcentaje6,
 ImporteIVA6,
 AplicarIVA6,
 IdCuentaIvaCompras7,
 IVAComprasPorcentaje7,
 ImporteIVA7,
 AplicarIVA7,
 IdCuentaIvaCompras8,
 IVAComprasPorcentaje8,
 ImporteIVA8,
 AplicarIVA8,
 IdCuentaIvaCompras9,
 IVAComprasPorcentaje9,
 ImporteIVA9,
 AplicarIVA9,
 IdCuentaIvaCompras10,
 IVAComprasPorcentaje10,
 ImporteIVA10,
 AplicarIVA10,
 IVAComprasPorcentajeDirecto,
 IdCuentaBancaria,
 PRESTOConcepto,
 PRESTOObra,
 IdDetalleRecepcion,
 TomarEnCalculoDeImpuestos,
 IdRubroContable,
 IdPedido,
 IdDetallePedido,
 Importacion_FOB,
 Importacion_PosicionAduana,
 Importacion_Despacho,
 Importacion_Guia,
 Importacion_IdPaisOrigen,
 Importacion_FechaEmbarque,
 Importacion_FechaOficializacion,
 IdProvinciaDestino1,
 PorcentajeProvinciaDestino1,
 IdProvinciaDestino2,
 PorcentajeProvinciaDestino2, IdDistribucionObra,
 Cantidad,
 IdDetalleObraDestino,
 IdPresupuestoObraRubro,
 IdPedidoAnticipo,
 PorcentajeAnticipo,
 PorcentajeCertificacion,
 IdPresupuestoObrasNodo,
 IdDetalleComprobanteProveedorOriginal,
 NumeroSubcontrato,
 IdSubcontrato,
 AmpliacionSubcontrato,
 IdDetalleSubcontratoDatos,
 IdEquipoDestino,
 IdUsuarioModificoCuenta,
 FechaModificacionCuenta
)
VALUES
(
 @IdComprobanteProveedor,
 @IdArticulo,
 @CodigoArticulo,
 @IdCuenta,
 @CodigoCuenta,
 @PorcentajeIvaAplicado,
 @Importe,
 @IdCuentaGasto,
 @IdCuentaIvaCompras1,
 @IVAComprasPorcentaje1,
 @ImporteIVA1,
 @AplicarIVA1,
 @IdCuentaIvaCompras2, @IVAComprasPorcentaje2,
 @ImporteIVA2,
 @AplicarIVA2,
 @IdCuentaIvaCompras3,
 @IVAComprasPorcentaje3,
 @ImporteIVA3,
 @AplicarIVA3,
 @IdCuentaIvaCompras4,
 @IVAComprasPorcentaje4,
 @ImporteIVA4,
 @AplicarIVA4,
 @IdCuentaIvaCompras5,
 @IVAComprasPorcentaje5,
 @ImporteIVA5,
 @AplicarIVA5,
 @IdObra,
 @Item,
 @IdCuentaIvaCompras6,
 @IVAComprasPorcentaje6,
 @ImporteIVA6,
 @AplicarIVA6,
 @IdCuentaIvaCompras7,
 @IVAComprasPorcentaje7,
 @ImporteIVA7,
 @AplicarIVA7,
 @IdCuentaIvaCompras8,
 @IVAComprasPorcentaje8,
 @ImporteIVA8,
 @AplicarIVA8,
 @IdCuentaIvaCompras9,
 @IVAComprasPorcentaje9,
 @ImporteIVA9,
 @AplicarIVA9,
 @IdCuentaIvaCompras10,
 @IVAComprasPorcentaje10,
 @ImporteIVA10,
 @AplicarIVA10,
 @IVAComprasPorcentajeDirecto,
 @IdCuentaBancaria,
 @PRESTOConcepto,
 @PRESTOObra,
 @IdDetalleRecepcion, @TomarEnCalculoDeImpuestos,
 @IdRubroContable,
 @IdPedido,
 @IdDetallePedido,
 @Importacion_FOB,
 @Importacion_PosicionAduana,
 @Importacion_Despacho,
 @Importacion_Guia,
 @Importacion_IdPaisOrigen,
 @Importacion_FechaEmbarque,
 @Importacion_FechaOficializacion,
 @IdProvinciaDestino1,
 @PorcentajeProvinciaDestino1,
 @IdProvinciaDestino2,
 @PorcentajeProvinciaDestino2,
 @IdDistribucionObra,
 @Cantidad,
 @IdDetalleObraDestino,
 @IdPresupuestoObraRubro,
 @IdPedidoAnticipo,
 @PorcentajeAnticipo,
 @PorcentajeCertificacion,
 @IdPresupuestoObrasNodo,
 @IdDetalleComprobanteProveedorOriginal,
 @NumeroSubcontrato,
 @IdSubcontrato,
 @AmpliacionSubcontrato,
 @IdDetalleSubcontratoDatos,
 @IdEquipoDestino,
 @IdUsuarioModificoCuenta,
 @FechaModificacionCuenta
)

SELECT @IdDetalleComprobanteProveedor=@@identity

RETURN(@IdDetalleComprobanteProveedor)