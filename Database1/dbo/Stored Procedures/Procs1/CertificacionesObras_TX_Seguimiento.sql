CREATE Procedure [dbo].[CertificacionesObras_TX_Seguimiento]

@IdObra int

AS

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdCuentaRetencionGananciasCobros int, @IdCuentaRetencionIva int, @IdCuentaRetencionIvaComprobantesM int

SET @IdTipoComprobanteFacturaVenta=IsNull((Select IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1),0)
SET @IdCuentaRetencionGananciasCobros=IsNull((Select IdCuentaRetencionGananciasCobros From Parametros Where IdParametro=1),0)
SET @IdCuentaRetencionIva=IsNull((Select IdCuentaRetencionIva From Parametros Where IdParametro=1),0)
SET @IdCuentaRetencionIvaComprobantesM=IsNull((Select IdCuentaRetencionIvaComprobantesM From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar0 
			(
			 IdCertificacionObraDatos INTEGER,
			 Renglon INTEGER,
			 NumeroCertificado INTEGER,
			 Version VARCHAR(10),
			 FechaMedicion DATETIME,
			 FechaCertificado DATETIME,
			 Tipo VARCHAR(1),
			 Comprobante VARCHAR(15),
			 FechaComprobante DATETIME,
			 Subtotal NUMERIC(18,2),
			 Iva NUMERIC(18,2),
			 Total NUMERIC(18,2),
			 FechaRecepcionCliente DATETIME,
			 FechaVencimiento DATETIME,
			 ComprobanteRecibo VARCHAR(15),
			 FechaRecibo DATETIME,
			 ImporteRecibo NUMERIC(18,2),
			 RetencionIVA NUMERIC(18,2),
			 RetencionGanancia NUMERIC(18,2),
			 RetencionIIBB NUMERIC(18,2),
			 NumeroTransferencia INTEGER,
			 BancoTransferencia VARCHAR(50),
			 FechaCesionBanco DATETIME,
			 BancoCesion VARCHAR(50),
			 FechaCancelacionCesion DATETIME,
			 Observaciones VARCHAR(1000)
			)

CREATE TABLE #Auxiliar1 
			(
			 IdCertificacionObraDatos INTEGER,
			 NumeroCertificado INTEGER,
			 Version VARCHAR(10),
			 FechaMedicion DATETIME,
			 FechaCertificado DATETIME,
			 Tipo VARCHAR(1),
			 Comprobante VARCHAR(15),
			 FechaComprobante DATETIME,
			 Subtotal NUMERIC(18,2),
			 Iva NUMERIC(18,2),
			 Total NUMERIC(18,2),
			 FechaRecepcionCliente DATETIME,
			 FechaVencimiento DATETIME,
			 FechaCesionBanco DATETIME,
			 BancoCesion VARCHAR(50),
			 FechaCancelacionCesion DATETIME,
			 Observaciones VARCHAR(1000)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdCertificacionObraDatos, FechaComprobante, Tipo, Comprobante) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT Facturas.IdCertificacionObraDatos, cod.NumeroCertificado, cod.Version, cod.FechaFinalizacion, cod.Fecha, 'F', 
	Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura), 
	Facturas.FechaFactura, 
	(Facturas.ImporteTotal-(Facturas.ImporteIva1+Facturas.IVANoDiscriminado))*Facturas.CotizacionMoneda, 
	(Facturas.ImporteIva1+Facturas.IVANoDiscriminado)*Facturas.CotizacionMoneda, Facturas.ImporteTotal*Facturas.CotizacionMoneda, 
	Facturas.FechaRecepcionCliente, cod.FechaVencimiento, cod.FechaCesionBanco, Bancos.Nombre as [Banco], cod.FechaCancelacionCesion, 
	Convert(varchar(1000),cod.Observaciones)
 FROM Facturas
 LEFT OUTER JOIN CertificacionesObrasDatos cod ON cod.IdCertificacionObraDatos=Facturas.IdCertificacionObraDatos
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=cod.IdBanco
 WHERE IsNull(Facturas.Anulada,'')<>'SI' and Facturas.IdCertificacionObraDatos is not null and 
	(Select Top 1 co.IdObra From CertificacionesObras co Where co.NumeroProyecto=cod.NumeroProyecto)=@IdObra

INSERT INTO #Auxiliar1 
 SELECT Facturas.IdCertificacionObraDatos, cod.NumeroCertificado, cod.Version, cod.FechaFinalizacion, cod.Fecha, 'N', 
	NotasCredito.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito), 
	NotasCredito.FechaNotaCredito, 
	(dnci.Importe-(Case When IsNull(Facturas.PorcentajeIva1,0)<>0 Then dnci.Importe-(dnci.Importe/(1+(Facturas.PorcentajeIva1/100))) Else 0 End))*NotasCredito.CotizacionMoneda*-1, 
	(Case When IsNull(Facturas.PorcentajeIva1,0)<>0 Then dnci.Importe-(dnci.Importe/(1+(Facturas.PorcentajeIva1/100))) Else 0 End)*NotasCredito.CotizacionMoneda*-1, 
	dnci.Importe*NotasCredito.CotizacionMoneda*-1, NotasCredito.FechaRecepcionCliente, cod.FechaVencimiento, cod.FechaCesionBanco, Bancos.Nombre as [Banco], 
	cod.FechaCancelacionCesion, Convert(varchar(1000),cod.Observaciones)
 FROM DetalleNotasCreditoImputaciones dnci
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=dnci.IdNotaCredito
 LEFT OUTER JOIN CuentasCorrientesDeudores cc ON cc.IdCtaCte=dnci.IdImputacion
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=cc.IdComprobante and cc.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN CertificacionesObrasDatos cod ON cod.IdCertificacionObraDatos=Facturas.IdCertificacionObraDatos
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=cod.IdBanco
 WHERE IsNull(NotasCredito.Anulada,'')<>'SI' and cc.IdTipoComp=@IdTipoComprobanteFacturaVenta and Facturas.IdCertificacionObraDatos is not null and 
	(Select Top 1 co.IdObra From CertificacionesObras co Where co.NumeroProyecto=cod.NumeroProyecto)=@IdObra

INSERT INTO #Auxiliar1 
 SELECT cod.IdCertificacionObraDatos, cod.NumeroCertificado, cod.Version, cod.FechaFinalizacion, cod.Fecha, Null, Null, Null, Null, Null, Null, Null, 
	cod.FechaVencimiento, cod.FechaCesionBanco, Bancos.Nombre as [Banco], cod.FechaCancelacionCesion, Convert(varchar(1000),cod.Observaciones)
 FROM CertificacionesObrasDatos cod
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=cod.IdBanco
 WHERE Not Exists(Select Top 1 #Auxiliar1.IdCertificacionObraDatos From #Auxiliar1 Where #Auxiliar1.IdCertificacionObraDatos=cod.IdCertificacionObraDatos) and 
(Select Top 1 co.IdObra From CertificacionesObras co Where co.NumeroProyecto=cod.NumeroProyecto)=@IdObra


CREATE TABLE #Auxiliar2 
			(
			 IdCertificacionObraDatos INTEGER,
			 Comprobante VARCHAR(15),
			 ComprobanteRecibo VARCHAR(15),
			 Fecha DATETIME,
			 Importe NUMERIC(18,2),
			 RetencionIVA NUMERIC(18,2),
			 RetencionGanancias NUMERIC(18,2),
			 RetencionIBrutos NUMERIC(18,2),
			 NumeroTransferencia INTEGER,
			 Banco VARCHAR(50)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdCertificacionObraDatos, ComprobanteRecibo, Comprobante) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT Facturas.IdCertificacionObraDatos, 
	Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura), 
	Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo), 
	Recibos.FechaRecibo, dr.Importe*Recibos.CotizacionMoneda, 
	(Recibos.RetencionIVA+	
		Case When IsNull(Recibos.IdCuenta1,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta1,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros1,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta2,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta2,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros2,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta3,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta3,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros3,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta4,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta4,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros4,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta5,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta5,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros5,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta6,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta6,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros6,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta7,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta7,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros7,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta8,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta8,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros8,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta9,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta9,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros9,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta10,0)=@IdCuentaRetencionIva or IsNull(Recibos.IdCuenta10,0)=@IdCuentaRetencionIvaComprobantesM Then IsNull(Recibos.Otros10,0) Else 0 End)*Recibos.CotizacionMoneda,
	(Recibos.RetencionGanancias+	
		Case When IsNull(Recibos.IdCuenta1,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros1,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta2,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros2,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta3,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros3,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta4,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros4,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta5,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros5,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta6,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros6,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta7,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros7,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta8,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros8,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta9,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros9,0) Else 0 End+
		Case When IsNull(Recibos.IdCuenta10,0)=@IdCuentaRetencionGananciasCobros Then IsNull(Recibos.Otros10,0) Else 0 End)*Recibos.CotizacionMoneda,
	(Recibos.RetencionIBrutos+	
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta1,0)) Then IsNull(Recibos.Otros1,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta2,0)) Then IsNull(Recibos.Otros2,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta3,0)) Then IsNull(Recibos.Otros3,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta4,0)) Then IsNull(Recibos.Otros4,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta5,0)) Then IsNull(Recibos.Otros5,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta6,0)) Then IsNull(Recibos.Otros6,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta7,0)) Then IsNull(Recibos.Otros7,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta8,0)) Then IsNull(Recibos.Otros8,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta9,0)) Then IsNull(Recibos.Otros9,0) Else 0 End+
		Case When Exists(Select Top 1 Provincias.IdProvincia From Provincias Where Provincias.IdCuentaRetencionIBrutosCobranzas=IsNull(Recibos.IdCuenta10,0)) Then IsNull(Recibos.Otros10,0) Else 0 End)*Recibos.CotizacionMoneda,
	(Select Top 1 drv.NumeroTransferencia From DetalleRecibosValores drv Where drv.IdRecibo=dr.IdRecibo and drv.NumeroTransferencia is not null),
	(Select Top 1 Bancos.Nombre From DetalleRecibosValores drv 
		Left Outer Join Bancos On Bancos.IdBanco=drv.IdBancoTransferencia
		Where drv.IdRecibo=dr.IdRecibo and drv.IdBancoTransferencia is not null)
 FROM DetalleRecibos dr
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=dr.IdRecibo
 LEFT OUTER JOIN CuentasCorrientesDeudores cc ON cc.IdCtaCte=dr.IdImputacion
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=cc.IdComprobante and cc.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN CertificacionesObrasDatos cod ON cod.IdCertificacionObraDatos=Facturas.IdCertificacionObraDatos
 WHERE IsNull(Recibos.Anulado,'')<>'SI' and cc.IdTipoComp=@IdTipoComprobanteFacturaVenta and Facturas.IdCertificacionObraDatos is not null and 
	(Select Top 1 co.IdObra From CertificacionesObras co Where co.NumeroProyecto=cod.NumeroProyecto)=@IdObra


DECLARE @IdCertificacionObraDatos INTEGER, @NumeroCertificado INTEGER, @Version VARCHAR(10), @FechaMedicion DATETIME, @FechaCertificado DATETIME, 
	@Tipo VARCHAR(1), @Comprobante VARCHAR(15), @FechaComprobante DATETIME, @Subtotal NUMERIC(18,2), @Iva NUMERIC(18,2),@Total NUMERIC(18,2),
	@FechaRecepcionCliente DATETIME, @FechaVencimiento DATETIME, @FechaCesionBanco DATETIME, @BancoCesion VARCHAR(50), @Renglon INTEGER, 
	@FechaCancelacionCesion DATETIME, @Observaciones VARCHAR(1000), @IdCertificacionObraDatos2 INTEGER, @Comprobante2 VARCHAR(15), 
	@ComprobanteRecibo VARCHAR(15), @Fecha DATETIME, @Importe NUMERIC(18,2), @RetencionIVA NUMERIC(18,2), @RetencionGanancias NUMERIC(18,2),
	@RetencionIBrutos NUMERIC(18,2), @NumeroTransferencia INTEGER, @Banco VARCHAR(50)

DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdCertificacionObraDatos, NumeroCertificado, Version, FechaMedicion, FechaCertificado, Tipo, Comprobante, FechaComprobante, 
			Subtotal, Iva, Total, FechaRecepcionCliente, FechaVencimiento, FechaCesionBanco, BancoCesion, FechaCancelacionCesion, Observaciones
		FROM #Auxiliar1
		ORDER BY IdCertificacionObraDatos, FechaComprobante, Tipo, Comprobante
OPEN Cur1
FETCH NEXT FROM Cur1 INTO @IdCertificacionObraDatos, @NumeroCertificado, @Version, @FechaMedicion, @FechaCertificado, @Tipo, @Comprobante, 
				@FechaComprobante, @Subtotal, @Iva, @Total, @FechaRecepcionCliente, @FechaVencimiento, @FechaCesionBanco, 
				@BancoCesion, @FechaCancelacionCesion, @Observaciones
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @Renglon=1
	INSERT INTO #Auxiliar0
	(IdCertificacionObraDatos, Renglon, NumeroCertificado, Version, FechaMedicion, FechaCertificado, Tipo, Comprobante, FechaComprobante, 
	 Subtotal, Iva, Total, FechaRecepcionCliente, FechaVencimiento, ComprobanteRecibo, FechaRecibo, ImporteRecibo, RetencionIVA, RetencionGanancia, 
	 RetencionIIBB, NumeroTransferencia, BancoTransferencia, FechaCesionBanco, BancoCesion, FechaCancelacionCesion, Observaciones)
	VALUES
	(@IdCertificacionObraDatos, @Renglon, @NumeroCertificado, @Version, @FechaMedicion, @FechaCertificado, @Tipo, @Comprobante, @FechaComprobante, 
	 @Subtotal, @Iva, @Total, @FechaRecepcionCliente, @FechaVencimiento, Null, Null, Null, Null, Null, Null, Null, Null, @FechaCesionBanco, 
	 @BancoCesion, @FechaCancelacionCesion, @Observaciones)

	DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR 
			SELECT IdCertificacionObraDatos, Comprobante, ComprobanteRecibo, Fecha, Importe, RetencionIVA, 
				RetencionGanancias, RetencionIBrutos, NumeroTransferencia, Banco
			FROM #Auxiliar2 
			WHERE Comprobante=@Comprobante
			ORDER BY IdCertificacionObraDatos, ComprobanteRecibo, Comprobante
	OPEN Cur2
	FETCH NEXT FROM Cur2 INTO @IdCertificacionObraDatos2, @Comprobante2, @ComprobanteRecibo, @Fecha, @Importe, @RetencionIVA, @RetencionGanancias, 
					@RetencionIBrutos, @NumeroTransferencia, @Banco
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		IF @Renglon=1
			UPDATE #Auxiliar0
			SET ComprobanteRecibo=@ComprobanteRecibo, FechaRecibo=@Fecha, ImporteRecibo=@Importe, RetencionIVA=@RetencionIVA, 
				RetencionGanancia=@RetencionGanancias, RetencionIIBB=@RetencionIBrutos, NumeroTransferencia=@NumeroTransferencia, 
				BancoTransferencia=@Banco
			WHERE IdCertificacionObraDatos=@IdCertificacionObraDatos and Comprobante=@Comprobante
		ELSE
			INSERT INTO #Auxiliar0
			(IdCertificacionObraDatos, Renglon, NumeroCertificado, Version, FechaMedicion, FechaCertificado, Tipo, Comprobante, FechaComprobante, 
			 Subtotal, Iva, Total, FechaRecepcionCliente, FechaVencimiento, ComprobanteRecibo, FechaRecibo, ImporteRecibo, RetencionIVA, RetencionGanancia, 
			 RetencionIIBB, NumeroTransferencia, BancoTransferencia, FechaCesionBanco, BancoCesion, FechaCancelacionCesion, Observaciones)
			VALUES
			(@IdCertificacionObraDatos, @Renglon, @NumeroCertificado, @Version, Null, Null, @Tipo, @Comprobante, Null, 
			 Null, Null, Null, Null, Null, @ComprobanteRecibo, @Fecha, @Importe, @RetencionIVA, @RetencionGanancias, @RetencionIBrutos, 
			 @NumeroTransferencia, @Banco, Null, Null, Null, Null)
		SET @Renglon=@Renglon+1
		FETCH NEXT FROM Cur2 INTO @IdCertificacionObraDatos2, @Comprobante2, @ComprobanteRecibo, @Fecha, @Importe, @RetencionIVA, @RetencionGanancias, 
						@RetencionIBrutos, @NumeroTransferencia, @Banco
	   END
	CLOSE Cur2
	DEALLOCATE Cur2

	FETCH NEXT FROM Cur1 INTO @IdCertificacionObraDatos, @NumeroCertificado, @Version, @FechaMedicion, @FechaCertificado, @Tipo, @Comprobante, 
					@FechaComprobante, @Subtotal, @Iva, @Total, @FechaRecepcionCliente, @FechaVencimiento, @FechaCesionBanco, 
					@BancoCesion, @FechaCancelacionCesion, @Observaciones
   END
CLOSE Cur1
DEALLOCATE Cur1

SET NOCOUNT OFF

SELECT *
FROM #Auxiliar0
ORDER BY NumeroCertificado, Version, Comprobante, FechaRecibo, ComprobanteRecibo, Renglon

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2