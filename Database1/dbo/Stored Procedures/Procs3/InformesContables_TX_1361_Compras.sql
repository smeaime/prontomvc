CREATE PROCEDURE [dbo].[InformesContables_TX_1361_Compras]

@Desde datetime,
@Hasta datetime,
@IdCuentasAdicionalesImpuestosInternos varchar(1000) = Null,
@Formato varchar(10) = Null

AS

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')

DECLARE @IdTipoCuentaGrupoIVA int, @IdCuentaImpuestosInternos int, @ImpuestosInternosMasHijas varchar(2), @IdCuentaPercepcionIVACompras int, @IdCtaAdicCol1 int,@IdCtaAdicCol2 int,@IdCtaAdicCol3 int,@IdCtaAdicCol4 int, @IdCtaAdicCol5 int

SET @IdCuentaPercepcionIVACompras=IsNull((Select IdCuentaPercepcionIVACompras From Parametros Where Parametros.IdParametro=1),0)
SET @IdCuentasAdicionalesImpuestosInternos=IsNull(@IdCuentasAdicionalesImpuestosInternos,'')
SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)
SET @IdTipoCuentaGrupoIVA=(Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1)
SET @IdCuentaImpuestosInternos=IsNull((Select IdCuentaImpuestosInternos From Parametros Where IdParametro=1),0)
SET @ImpuestosInternosMasHijas='SI'

CREATE TABLE #Auxiliar0	
			(
			 IdCuenta INTEGER,
			 IdCuentaMadre INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT Cuentas.IdCuenta, Null
 FROM Cuentas 
 WHERE Cuentas.IdCuenta=@IdCuentaImpuestosInternos or Patindex('%('+Convert(varchar,Cuentas.IdCuenta)+')%', @IdCuentasAdicionalesImpuestosInternos)<>0
IF @ImpuestosInternosMasHijas='SI'
	INSERT INTO #Auxiliar0 
	 SELECT Cuentas.IdCuenta, IsNull(CuentasGastos.IdCuentaMadre,-1)
	 FROM Cuentas 
	 LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto
	 WHERE IsNull(CuentasGastos.IdCuentaMadre,-1)=@IdCuentaImpuestosInternos or 
		Patindex('%('+Convert(varchar,IsNull(CuentasGastos.IdCuentaMadre,-1))+')%',@IdCuentasAdicionalesImpuestosInternos)<>0

CREATE TABLE #Auxiliar10
			(
			 A_IdComprobante INTEGER,
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 4),
			 A_Total NUMERIC(18, 3),
			 A_ImportePercepcionesOPagosImpuestoAlValorAgregado NUMERIC(19,3),
			 A_ImportePercepcionesIIBB NUMERIC(19,3)
			)
INSERT INTO #Auxiliar10 
 SELECT 
	dcp.IdComprobanteProveedor,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and Not (dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0))
		Then Case When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and 
						dcp.ImporteIVA6=0 and dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0 and 
						Not IsNull(dcp.IdCuenta,-1)=@IdCuentaPercepcionIVACompras and 
						Not Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1))
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3)
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then Case When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and 
						dcp.ImporteIVA6=0 and dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0 and 
						Not IsNull(dcp.IdCuenta,-1)=@IdCuentaPercepcionIVACompras and 
						Not Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1))
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA)
		Then Case When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and 
					dcp.ImporteIVA6=0 and dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0
				 Then 0
				 Else Case When Not IsNull(dcp.IdCuenta,-1)=@IdCuentaPercepcionIVACompras and 
								Not Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1))
						 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
						 Else 0 
					End
			End
		Else 0
	End,
	Case When IsNull(dcp.IVAComprasPorcentaje1,0)<>0 Then dcp.IVAComprasPorcentaje1
		When IsNull(dcp.IVAComprasPorcentaje2,0)<>0 Then dcp.IVAComprasPorcentaje2
		When IsNull(dcp.IVAComprasPorcentaje3,0)<>0 Then dcp.IVAComprasPorcentaje3
		When IsNull(dcp.IVAComprasPorcentaje4,0)<>0 Then dcp.IVAComprasPorcentaje4
		When IsNull(dcp.IVAComprasPorcentaje5,0)<>0 Then dcp.IVAComprasPorcentaje5
		When IsNull(dcp.IVAComprasPorcentaje6,0)<>0 Then dcp.IVAComprasPorcentaje6
		When IsNull(dcp.IVAComprasPorcentaje7,0)<>0 Then dcp.IVAComprasPorcentaje7
		When IsNull(dcp.IVAComprasPorcentaje8,0)<>0 Then dcp.IVAComprasPorcentaje8
		When IsNull(dcp.IVAComprasPorcentaje9,0)<>0 Then dcp.IVAComprasPorcentaje9
		When IsNull(dcp.IVAComprasPorcentaje10,0)<>0 Then dcp.IVAComprasPorcentaje10
		Else 0
	End,
	Round((IsNull(dcp.ImporteIVA1,0)+IsNull(dcp.ImporteIVA2,0)+IsNull(dcp.ImporteIVA3,0)+IsNull(dcp.ImporteIVA4,0)+IsNull(dcp.ImporteIVA5,0)+
			IsNull(dcp.ImporteIVA6,0)+IsNull(dcp.ImporteIVA7,0)+IsNull(dcp.ImporteIVA8,0)+IsNull(dcp.ImporteIVA9,0)+IsNull(dcp.ImporteIVA10,0)) * cp.CotizacionMoneda,4),
	0,
	Case When IsNull(dcp.IdCuenta,-1)=@IdCuentaPercepcionIVACompras Then Round(dcp.Importe*cp.CotizacionMoneda,3) Else 0 End,
	Case When Exists(Select Top 1 Pv.IdProvincia From Provincias Pv Where IsNull(Pv.IdCuentaPercepcionIIBBComprasJurisdiccionLocal,0)=IsNull(dcp.IdCuenta,-1))
		Then Round(dcp.Importe*cp.CotizacionMoneda,3)
		Else 0
	End
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(cp.Confirmado,'SI')<>'NO' and not cp.IdTipoComprobante in (13,19)

 UNION ALL

 SELECT 
	cp.IdComprobanteProveedor,
	0,
	0,
	0,
	IsNull(cp.PorcentajeIVAAplicacionAjuste,0),
	Round(cp.AjusteIVA*cp.CotizacionMoneda,4),
	0,
	0,
	0
 FROM ComprobantesProveedores cp 
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON  cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE cp.FechaRecepcion between @Desde and @hasta and IsNull(cp.AjusteIVA,0)<>0 and IsNull(cp.Confirmado,'SI')<>'NO' and not cp.IdTipoComprobante in (13,19)

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	0,
--	IsNull(dcp.IVAComprasPorcentajeDirecto,0),
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	0,
	0,
	0
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE cp.FechaRecepcion between @Desde and @hasta and IsNull(cp.Confirmado,'SI')<>'NO' and 
	(Cuentas.IdTipoCuentaGrupo is not null and Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA) and not cp.IdTipoComprobante in (13,19) and 
	IsNull(dcp.IdCuenta,-1)<>@IdCuentaPercepcionIVACompras


CREATE TABLE #Auxiliar12 
			(
			 A_IdComprobante INTEGER,
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 4),
			 A_Total NUMERIC(18, 3),
			 A_ImportePercepcionesOPagosImpuestoAlValorAgregado NUMERIC(19,3),
			 A_ImportePercepcionesIIBB NUMERIC(19,3)
			)
INSERT INTO #Auxiliar12 
 SELECT 
	#Auxiliar10.A_IdComprobante,
	SUM(#Auxiliar10.A_NetoNoGravado),
	SUM(#Auxiliar10.A_NetoNoGravadoImpInt),
	SUM(#Auxiliar10.A_NetoGravado),
	#Auxiliar10.A_Tasa,
	SUM(#Auxiliar10.A_IVA),
	SUM(#Auxiliar10.A_NetoNoGravado+#Auxiliar10.A_NetoNoGravadoImpInt+#Auxiliar10.A_NetoGravado+#Auxiliar10.A_IVA+#Auxiliar10.A_ImportePercepcionesOPagosImpuestoAlValorAgregado+#Auxiliar10.A_ImportePercepcionesIIBB),
	SUM(#Auxiliar10.A_ImportePercepcionesOPagosImpuestoAlValorAgregado),
	SUM(#Auxiliar10.A_ImportePercepcionesIIBB)
 FROM #Auxiliar10 
 GROUP BY #Auxiliar10.A_IdComprobante, #Auxiliar10.A_Tasa


CREATE TABLE #Auxiliar 
			(
			 TipoRegistro VARCHAR(1),
			 FechaComprobante DATETIME,
			 TipoComprobante VARCHAR(2),
			 Coeficiente INTEGER,
			 ControladorFiscal VARCHAR(1),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 CantidadHojas VARCHAR(3),
			 AñoDelDocumento INTEGER,
			 CodigoAduana INTEGER,
			 CodigoDestinacion VARCHAR(4),
			 NumeroDespacho INTEGER,
			 DigitoVerificadorNumeroDespacho VARCHAR(1),
			 FechaDespachoAPlaza VARCHAR(8),
			 TipoDocumentoIdentificacionVendedor VARCHAR(2),
			 NumeroDocumentoIdentificacionVendedor VARCHAR(11),
			 RazonSocialVendedor VARCHAR(50),
			 ImporteTotal NUMERIC(19,0),
			 ImporteNoGravado NUMERIC(19,0),
			 ImporteGravado NUMERIC(19,0),
			 AlicuotaIVA NUMERIC(5,0),
			 ImporteIVADiscriminado NUMERIC(19,0),
			 ImporteExento NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestoAlValorAgregado NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestosNacionales NUMERIC(19,0),
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 ImporteImpuestosInternos NUMERIC(19,0),
			 TipoResponsable VARCHAR(2),
			 Moneda VARCHAR(3),
			 CotizacionMoneda INTEGER,
			 CantidadAlicuotasIVA VARCHAR(1),
			 CodigoOperacion VARCHAR(1),
			 CAI VARCHAR(14),
			 FechaVencimiento VARCHAR(8),
			 InformacionAdicional VARCHAR(75),
			 Registro VARCHAR(400),
			 FechaRecepcion DATETIME
			)

INSERT INTO #Auxiliar 
 SELECT 
	'1',
	cp.FechaRecepcion,
	Case When cp.Letra='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'01')
		When cp.Letra='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'06')
		When cp.Letra='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'11')
		When cp.Letra='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'19')
		When cp.Letra='M' Then '51'
		Else '00'
	End,
	Tc.Coeficiente,
	' ',
	cp.NumeroComprobante1,
	cp.NumeroComprobante2,
	'001',
	Case When cp.FechaDespachoAPlaza is not null Then Year(cp.FechaDespachoAPlaza) Else 0 End,
	Case When CodigosAduana.Codigo is not null Then CodigosAduana.Codigo Else 0 End,
	Case When CodigosDestinacion.Codigo is not null Then CodigosDestinacion.Codigo Else '' End,
	Case When cp.NumeroDespacho is not null Then cp.NumeroDespacho Else 0 End,
	Case When cp.DigitoVerificadorNumeroDespacho is not null Then cp.DigitoVerificadorNumeroDespacho Else ' ' End,
	Case When cp.FechaDespachoAPlaza is not null 
		Then Convert(varchar,Year(cp.FechaDespachoAPlaza))+
			Substring('00',1,2-len(Convert(varchar,Month(cp.FechaDespachoAPlaza))))+Convert(varchar,Month(cp.FechaDespachoAPlaza))+			
			Substring('00',1,2-len(Convert(varchar,Day(cp.FechaDespachoAPlaza))))+Convert(varchar,Day(cp.FechaDespachoAPlaza))
		Else '00000000'
	End,
	'80',
	Substring(Prov.Cuit,1,2)+Substring(Prov.Cuit,4,8)+Substring(Prov.Cuit,13,1),
	Prov.RazonSocial,
	#Auxiliar12.A_Total * 100,
	#Auxiliar12.A_NetoNoGravado * 100,
	#Auxiliar12.A_NetoGravado * 100,
	#Auxiliar12.A_Tasa * 100,
	#Auxiliar12.A_IVA * 100,
	0,
	#Auxiliar12.A_ImportePercepcionesOPagosImpuestoAlValorAgregado * 100,
	0,
	#Auxiliar12.A_ImportePercepcionesIIBB * 100,
	0,
	#Auxiliar12.A_NetoNoGravadoImpInt * 100,
	Case When DescripcionIva.CodigoAFIP is not null 
		Then Substring('00',1,2-Len(Convert(varchar,DescripcionIva.CodigoAFIP)))+Convert(varchar,DescripcionIva.CodigoAFIP)
		Else '01'
	End,
	Monedas.CodigoAFIP,
	cp.CotizacionMoneda * 1000000,
	'1',
	Case When cp.Letra='E' Then 'E' Else ' ' End,
 	Case When IsNumeric(cp.NumeroCAI)=1 and Patindex('%-%', cp.NumeroCAI)=0 and Patindex('%.%', cp.NumeroCAI)=0 and Len(Ltrim(Rtrim(IsNull(cp.NumeroCAI,''))))<=14
		Then Substring('00000000000000',1,14-Len(Convert(varchar,Convert(numeric(20,0),IsNull(cp.NumeroCAI,'0')))))+Convert(varchar,Convert(numeric(20,0),IsNull(cp.NumeroCAI,'0')))
		Else '00000000000000'
	End,
	Convert(varchar,Year(Case When IsNull(cp.FechaVencimientoCAI,@Hasta)<cp.FechaRecepcion Then @Hasta Else IsNull(cp.FechaVencimientoCAI,@Hasta) End))+
			Substring('00',1,2-len(Convert(varchar,Month(Case When IsNull(cp.FechaVencimientoCAI,@Hasta)<cp.FechaRecepcion Then @Hasta Else IsNull(cp.FechaVencimientoCAI,@Hasta) End))))+Convert(varchar,Month(Case When IsNull(cp.FechaVencimientoCAI,@Hasta)<cp.FechaRecepcion Then @Hasta Else IsNull(cp.FechaVencimientoCAI,@Hasta) End))+			
			Substring('00',1,2-len(Convert(varchar,Day(Case When IsNull(cp.FechaVencimientoCAI,@Hasta)<cp.FechaRecepcion Then @Hasta Else IsNull(cp.FechaVencimientoCAI,@Hasta) End))))+Convert(varchar,Day(Case When IsNull(cp.FechaVencimientoCAI,@Hasta)<cp.FechaRecepcion Then @Hasta Else IsNull(cp.FechaVencimientoCAI,@Hasta) End)),
	'',
	'',
	cp.FechaRecepcion
 FROM #Auxiliar12
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar12.A_IdComprobante
 LEFT OUTER JOIN Proveedores Prov ON Prov.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Prov.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=cp.IdMoneda
 LEFT OUTER JOIN TiposComprobante Tc ON cp.IdTipoComprobante = Tc.IdTipoComprobante
 LEFT OUTER JOIN CodigosAduana ON CodigosAduana.IdCodigoAduana=cp.IdCodigoAduana
 LEFT OUTER JOIN CodigosDestinacion ON CodigosDestinacion.IdCodigoDestinacion=cp.IdCodigoDestinacion
 WHERE IsNull(Tc.VaAlRegistroComprasAFIP,'NO')='SI' and (cp.FechaRecepcion between @Desde and @hasta) and IsNull(cp.Confirmado,'SI')='SI' and 
	IsNull(#Auxiliar12.A_Total,0)>=0

INSERT INTO #Auxiliar 
 SELECT 
	'1',
	Valores.FechaGasto,
	Case When Tc.Coeficiente>0 Then '02' Else '03' End,
	Tc.Coeficiente,
	' ',
	0,
	Valores.NumeroComprobante,
	'001',
	0,
	0,
	'',
	0,
	' ',
	'00000000',
	'80',
	Substring(Bancos.Cuit,1,2)+Substring(Bancos.Cuit,4,8)+Substring(Bancos.Cuit,13,1),
	Bancos.Nombre,
	Valores.Importe * IsNull(Valores.CotizacionMoneda,1) * 100,
	Case When Valores.IdCuentaContable<>@IdCtaAdicCol1 and Valores.IdCuentaContable<>@IdCtaAdicCol2 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol3 and Valores.IdCuentaContable<>@IdCtaAdicCol4 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol5
		Then Case When Valores.Iva=0 Then Valores.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End
		Else 0
	End * 100,
	Case When Valores.IdCuentaContable<>@IdCtaAdicCol1 and Valores.IdCuentaContable<>@IdCtaAdicCol2 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol3 and Valores.IdCuentaContable<>@IdCtaAdicCol4 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol5 
		Then Case When Valores.Iva=0 Then 0 Else Case When  Valores.Importe>=Valores.iva Then (Valores.Importe-Valores.iva) * IsNull(Valores.CotizacionMoneda,1) Else 0 End End
		Else 0
	End * 100,
	IsNull(Valores.PorcentajeIva,0) * 100,
	Case When IsNull(Valores.IdCuentaIVA,-1)=@IdCuentaPercepcionIVACompras Then 0 Else Valores.Iva * IsNull(Valores.CotizacionMoneda,1) * 100 End,
	0,
	Case When IsNull(Valores.IdCuentaIVA,-1)=@IdCuentaPercepcionIVACompras Then Valores.Iva * IsNull(Valores.CotizacionMoneda,1) * 100 Else 0 End,
	0,
	0,
	0,
	Case When Valores.IdCuentaContable<>@IdCtaAdicCol1 and Valores.IdCuentaContable<>@IdCtaAdicCol2 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol3 and Valores.IdCuentaContable<>@IdCtaAdicCol4 and 
			Valores.IdCuentaContable<>@IdCtaAdicCol5 and Valores.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0)
		Then Case When Valores.Iva=0 Then Valores.Importe * IsNull(Valores.CotizacionMoneda,1) Else 0 End
		Else 0
	End * 100,
	Case When DescripcionIva.CodigoAFIP is not null 
		Then Substring('00',1,2-Len(Convert(varchar,DescripcionIva.CodigoAFIP)))+Convert(varchar,DescripcionIva.CodigoAFIP)
		Else '01'
	End,
	Monedas.CodigoAFIP,
	Valores.CotizacionMoneda * 1000000,
	'1',
	' ',
	'00000000000000',
	'00000000',
	'',
	'',
	Valores.FechaGasto
 FROM Valores
 LEFT OUTER JOIN TiposComprobante Tc ON Valores.IdTipoComprobante = Tc.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco = Bancos.IdBanco
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Bancos.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=1
 WHERE IsNull(Tc.VaAlRegistroComprasAFIP,'NO')='SI' and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.FechaGasto between @Desde and @hasta) and Valores.Estado='G' and 
	(IsNull(Valores.Iva,0)<>0 or 
	 IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol1 or IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol2 or 
	 IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol3 or IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol4 or 
	 IsNull(Valores.IdCuentaContable,-1)=@IdCtaAdicCol5 or IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol1 or 
	 IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol2 or IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol3 or 
	 IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol4 or IsNull(Valores.IdCuentaIVA,-1)=@IdCtaAdicCol5)

UPDATE #Auxiliar
SET TipoDocumentoIdentificacionVendedor='86', NumeroDocumentoIdentificacionVendedor='27000000006'
WHERE Len(Ltrim(Rtrim(IsNull(NumeroDocumentoIdentificacionVendedor,''))))<>11

UPDATE #Auxiliar
SET CAI='00000000000000'
WHERE Len(Ltrim(Rtrim(IsNull(CAI,''))))<>14

UPDATE #Auxiliar
SET Registro = 	#Auxiliar.TipoRegistro+
		Convert(varchar,Year(#Auxiliar.FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaComprobante))))+Convert(varchar,Month(#Auxiliar.FechaComprobante))+			
			Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaComprobante))))+Convert(varchar,Day(#Auxiliar.FechaComprobante))+
		#Auxiliar.TipoComprobante+
		#Auxiliar.ControladorFiscal+
		Substring('0000',1,4-len(Convert(varchar,#Auxiliar.PuntoVenta)))+Convert(varchar,#Auxiliar.PuntoVenta)+
		Substring('00000000000000000000',1,20-len(Convert(varchar,#Auxiliar.NumeroComprobante)))+Convert(varchar,#Auxiliar.NumeroComprobante)+
		Convert(varchar,Year(#Auxiliar.FechaRecepcion))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaRecepcion))))+Convert(varchar,Month(#Auxiliar.FechaRecepcion))+			
			Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaRecepcion))))+Convert(varchar,Day(#Auxiliar.FechaRecepcion))+
		Substring('000',1,3-len(Convert(varchar,#Auxiliar.CodigoAduana)))+Convert(varchar,#Auxiliar.CodigoAduana)+
		Substring(#Auxiliar.CodigoDestinacion+'    ',1,4)+
		Substring('000000',1,6-len(Convert(varchar,#Auxiliar.NumeroDespacho)))+Convert(varchar,#Auxiliar.NumeroDespacho)+
		#Auxiliar.DigitoVerificadorNumeroDespacho+
		#Auxiliar.TipoDocumentoIdentificacionVendedor+
		#Auxiliar.NumeroDocumentoIdentificacionVendedor+
		Substring(IsNull(#Auxiliar.RazonSocialVendedor,'')+'                              ',1,30)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteTotal)))+Convert(varchar,#Auxiliar.ImporteTotal),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteNoGravado)))+Convert(varchar,#Auxiliar.ImporteNoGravado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteGravado)))+Convert(varchar,#Auxiliar.ImporteGravado),1,15)+
		Substring(Substring('00000',1,5-len(Convert(varchar,#Auxiliar.AlicuotaIVA)))+Convert(varchar,#Auxiliar.AlicuotaIVA),2,4)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteIVADiscriminado)))+Convert(varchar,#Auxiliar.ImporteIVADiscriminado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteExento)))+Convert(varchar,#Auxiliar.ImporteExento),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesOPagosImpuestoAlValorAgregado)))+Convert(varchar,#Auxiliar.ImportePercepcionesOPagosImpuestoAlValorAgregado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesOPagosImpuestosNacionales)))+Convert(varchar,#Auxiliar.ImportePercepcionesOPagosImpuestosNacionales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesIIBB)))+Convert(varchar,#Auxiliar.ImportePercepcionesIIBB),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteImpuestosInternos)))+Convert(varchar,#Auxiliar.ImporteImpuestosInternos),1,15)+
		#Auxiliar.TipoResponsable+
		#Auxiliar.Moneda+
		Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar.CotizacionMoneda)))+Convert(varchar,#Auxiliar.CotizacionMoneda),1,10)+
		#Auxiliar.CantidadAlicuotasIVA+
		#Auxiliar.CodigoOperacion+
		#Auxiliar.CAI+
		#Auxiliar.FechaVencimiento+
		Substring(#Auxiliar.InformacionAdicional+'                                                                           ',1,75)

CREATE TABLE #Auxiliar1 
			(
			 TipoRegistro VARCHAR(1),
			 Periodo VARCHAR(6),
			 CantidadRegistrosTipo1 INTEGER,
			 CuitEmpresa VARCHAR(11),
			 ImporteTotal NUMERIC(19,0),
			 ImporteNoGravado NUMERIC(19,0),
			 ImporteGravado NUMERIC(19,0),
			 ImporteIVADiscriminado NUMERIC(19,0),
			 ImporteExento NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestoAlValorAgregado NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestosNacionales NUMERIC(19,0),
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 ImporteImpuestosInternos NUMERIC(19,0),
			 Registro VARCHAR(400)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	'2',
	Convert(varchar,Year(@Desde))+Substring('00',1,2-len(Convert(varchar,Month(@Desde))))+Convert(varchar,Month(@Desde)),
	(Select Count(*) From #Auxiliar),
	(Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
	(Select Sum(ImporteTotal*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImporteNoGravado*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImporteGravado*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImporteIVADiscriminado*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImporteExento*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImportePercepcionesOPagosImpuestoAlValorAgregado*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImportePercepcionesOPagosImpuestosNacionales*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImportePercepcionesIIBB*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImportePercepcionesImpuestosMunicipales*IsNull(Coeficiente,1)) From #Auxiliar),
	(Select Sum(ImporteImpuestosInternos*IsNull(Coeficiente,1)) From #Auxiliar),
	''

UPDATE #Auxiliar1
SET Registro = 	#Auxiliar1.TipoRegistro+
		#Auxiliar1.Periodo+
		'          '+
		Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)))+Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)+
		'                               '+
		#Auxiliar1.CuitEmpresa+
		'                              '+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteTotal)))+Convert(varchar,#Auxiliar1.ImporteTotal),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteNoGravado)))+Convert(varchar,#Auxiliar1.ImporteNoGravado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteGravado)))+Convert(varchar,#Auxiliar1.ImporteGravado),1,15)+
		'    '+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteIVADiscriminado)))+Convert(varchar,#Auxiliar1.ImporteIVADiscriminado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteExento)))+Convert(varchar,#Auxiliar1.ImporteExento),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesOPagosImpuestoAlValorAgregado)))+Convert(varchar,#Auxiliar1.ImportePercepcionesOPagosImpuestoAlValorAgregado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesOPagosImpuestosNacionales)))+Convert(varchar,#Auxiliar1.ImportePercepcionesOPagosImpuestosNacionales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesIIBB)))+Convert(varchar,#Auxiliar1.ImportePercepcionesIIBB),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,#Auxiliar1.ImportePercepcionesImpuestosMunicipales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteImpuestosInternos)))+Convert(varchar,#Auxiliar1.ImporteImpuestosInternos),1,15)+
		'                                                                                                                  '

INSERT INTO #Auxiliar 
 SELECT 
	#Auxiliar1.TipoRegistro,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	#Auxiliar1.ImporteTotal,
	#Auxiliar1.ImporteNoGravado,
	#Auxiliar1.ImporteGravado,
	Null,
	#Auxiliar1.ImporteIVADiscriminado,
	#Auxiliar1.ImporteExento,
	#Auxiliar1.ImportePercepcionesOPagosImpuestoAlValorAgregado,
	#Auxiliar1.ImportePercepcionesOPagosImpuestosNacionales,
	#Auxiliar1.ImportePercepcionesIIBB,
	#Auxiliar1.ImportePercepcionesImpuestosMunicipales,
	#Auxiliar1.ImporteImpuestosInternos,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	#Auxiliar1.Registro,
	Null
 FROM #Auxiliar1

SET NOCOUNT OFF

IF @Formato='SinFormato'
  BEGIN
	SELECT * FROM #Auxiliar
	WHERE TipoRegistro='1'
	ORDER By TipoRegistro, FechaComprobante, TipoComprobante, PuntoVenta, NumeroComprobante
  END
ELSE
  BEGIN
	DECLARE @vector_X varchar(50),@vector_T varchar(50)
	SET @vector_X='011111111111111111111111111111111111133'
	SET @vector_T='024311215555552433334336466632253556500'

	SELECT 
		0 as [IdAux],
		TipoRegistro as [Tipo reg.],
		FechaComprobante as [Fecha comp.],
		TipoComprobante as [Tipo comp.],
		ControladorFiscal as [C.fiscal],
		PuntoVenta as [Pto.vta.],
		NumeroComprobante as [Nro.comp.],
		CantidadHojas as [Hojas],
		AñoDelDocumento as [Año doc.],
		CodigoAduana as [Cod.aduana],
		CodigoDestinacion as [Cod.dest.],
		NumeroDespacho as [Nro.despacho],
		DigitoVerificadorNumeroDespacho as [Dig.verif.],
		FechaDespachoAPlaza as [Fecha desp.],
		TipoDocumentoIdentificacionVendedor as [Tipo doc.],
		NumeroDocumentoIdentificacionVendedor as [Nro.doc.],
		RazonSocialVendedor as [Entidad],
		ImporteTotal as [Imp.total],
		ImporteNoGravado as [Imp no grav.],
		ImporteGravado as [Imp grav.],
		AlicuotaIVA as [% IVA],
		ImporteIVADiscriminado as [IVA],
		ImporteExento as [Imp.exento],
		ImportePercepcionesOPagosImpuestoAlValorAgregado as [Imp.perc.IVA],
		ImportePercepcionesOPagosImpuestosNacionales as [Imp.cta.impuestos],
		ImportePercepcionesIIBB as [Imp.perc.IIBB],
		ImportePercepcionesImpuestosMunicipales as [Imp.perc.impuestos],
		ImporteImpuestosInternos as [Imp.impuestos int.],
		TipoResponsable as [Tipo resp.],
		Moneda as [Moneda],
		CotizacionMoneda as [Cot.moneda],
		CantidadAlicuotasIVA as [Cant.alicuotas],
		CodigoOperacion as [Cod.ope.],
		CAI as [Nro.CAI],
		FechaVencimiento as [Fecha vto.CAI],
		Registro as [Registro],		InformacionAdicional as [Informacion adicional],
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
	FROM #Auxiliar 
	ORDER By TipoRegistro, FechaComprobante, TipoComprobante, PuntoVenta, NumeroComprobante
  END
  
DROP TABLE #Auxiliar
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar12