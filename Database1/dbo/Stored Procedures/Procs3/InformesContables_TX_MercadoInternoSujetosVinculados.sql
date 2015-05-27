CREATE PROCEDURE [dbo].[InformesContables_TX_MercadoInternoSujetosVinculados]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar10
			(
			 IdComprobanteProveedor INTEGER,
			 IVAComprasPorcentaje NUMERIC(18,2),
			 ImporteIva NUMERIC(18,2)
			)
INSERT INTO #Auxiliar10 
 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje1, Round(dcp.ImporteIVA1 * cp.CotizacionMoneda,2)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA1,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje2, Round(dcp.ImporteIVA2 * cp.CotizacionMoneda,2)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA2,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje3, Round(dcp.ImporteIVA3 * cp.CotizacionMoneda,2)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA3,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje4, Round(dcp.ImporteIVA4 * cp.CotizacionMoneda,2)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA4,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje5, Round(dcp.ImporteIVA5 * cp.CotizacionMoneda,2)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA5,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje6, Round(dcp.ImporteIVA6 * cp.CotizacionMoneda,2)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA6,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje7, Round(dcp.ImporteIVA7 * cp.CotizacionMoneda,2)
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA7,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje8, Round(dcp.ImporteIVA8 * cp.CotizacionMoneda,2) 
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA8,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje9, Round(dcp.ImporteIVA9 * cp.CotizacionMoneda,2) 
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA9,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, dcp.IVAComprasPorcentaje10, Round(dcp.ImporteIVA10 * cp.CotizacionMoneda,2) 
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.ImporteIVA10,0)<>0

 UNION ALL

 SELECT cp.IdComprobanteProveedor, 21,Round(cp.AjusteIVA * cp.CotizacionMoneda,2) 
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(cp.AjusteIVA,0)<>0

 UNION ALL

 SELECT dcp.IdComprobanteProveedor, 21, Round(dcp.Importe * cp.CotizacionMoneda,2) 
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(dcp.Importe,0)<>0 and 
	IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaGrupoIVA 

CREATE TABLE #Auxiliar11
			(
			 IdComprobanteProveedor INTEGER,
			 IVAComprasPorcentaje NUMERIC(18,2),
			 ImporteIva NUMERIC(18,0)
			)
INSERT INTO #Auxiliar11 
 SELECT IdComprobanteProveedor, IVAComprasPorcentaje, Sum(ImporteIva)
 FROM #Auxiliar10
 GROUP BY IdComprobanteProveedor, IVAComprasPorcentaje


CREATE TABLE #Auxiliar1 
			(
			 CodigoRegistro VARCHAR(2),
			 TipoMovimiento VARCHAR(1),
			 TipoRegistro VARCHAR(1),
			 TipoComprobante INTEGER,
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 Fecha DATETIME,
			 Cuit VARCHAR(11),
			 Nombre VARCHAR(30),
			 ImporteTotal NUMERIC(18,0),
			 ImporteExento NUMERIC(18,0),
			 ImporteGravado NUMERIC(18,0),
			 ImporteExento2 NUMERIC(18,0),
			 CodigoAlicuotaIva INTEGER,
			 ImporteIva NUMERIC(18,0),
			 TipoOperacion INTEGER,
			 Registro VARCHAR(1000)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  'C1',
  'C',
  'C',
  Case When cp.Letra='A' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_A,'0'))
	When cp.Letra='B' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_B,'0'))
	When cp.Letra='C' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_C,'0'))
	When cp.Letra='M' Then 51 
	Else 0 
  End,
  IsNull(cp.NumeroComprobante1,1),
  IsNull(cp.NumeroComprobante2,0),
  cp.FechaComprobante,
  Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1),
  Substring(Proveedores.RazonSocial,1,30),
  cp.TotalComprobante * cp.CotizacionMoneda * 100,
  IsNull((Select Sum(IsNull(dc.Importe,0)) From DetalleComprobantesProveedores dc 
		Where dc.IdComprobanteProveedor=cp.IdComprobanteProveedor and not (IsNull(dc.ImporteIva1,0)<>0 or IsNull(dc.ImporteIva2,0)<>0 or IsNull(dc.ImporteIva3,0)<>0 or IsNull(dc.ImporteIva4,0)<>0 or 
			IsNull(dc.ImporteIva5,0)<>0 or IsNull(dc.ImporteIva6,0)<>0 or IsNull(dc.ImporteIva7,0)<>0 or IsNull(dc.ImporteIva8,0)<>0 or IsNull(dc.ImporteIva9,0)<>0 or IsNull(dc.ImporteIva10,0)<>0)),0) * cp.CotizacionMoneda * 100,
  IsNull((Select Sum(IsNull(dc.Importe,0)) From DetalleComprobantesProveedores dc 
		Where dc.IdComprobanteProveedor=cp.IdComprobanteProveedor and (IsNull(dc.ImporteIva1,0)<>0 or IsNull(dc.ImporteIva2,0)<>0 or IsNull(dc.ImporteIva3,0)<>0 or IsNull(dc.ImporteIva4,0)<>0 or 
			IsNull(dc.ImporteIva5,0)<>0 or IsNull(dc.ImporteIva6,0)<>0 or IsNull(dc.ImporteIva7,0)<>0 or IsNull(dc.ImporteIva8,0)<>0 or IsNull(dc.ImporteIva9,0)<>0 or IsNull(dc.ImporteIva10,0)<>0)),0) * cp.CotizacionMoneda * 100,
  IsNull((Select Sum(IsNull(dc.Importe,0)) From DetalleComprobantesProveedores dc 
		Where dc.IdComprobanteProveedor=cp.IdComprobanteProveedor and not (IsNull(dc.ImporteIva1,0)<>0 or IsNull(dc.ImporteIva2,0)<>0 or IsNull(dc.ImporteIva3,0)<>0 or IsNull(dc.ImporteIva4,0)<>0 or 
			IsNull(dc.ImporteIva5,0)<>0 or IsNull(dc.ImporteIva6,0)<>0 or IsNull(dc.ImporteIva7,0)<>0 or IsNull(dc.ImporteIva8,0)<>0 or IsNull(dc.ImporteIva9,0)<>0 or IsNull(dc.ImporteIva10,0)<>0)),0) * cp.CotizacionMoneda * 100,
  Null,
  Null,
  Null,
  ''
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI'

 UNION ALL 

 SELECT 
  'C2',
  'C',
  'C',
  Case When cp.Letra='A' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_A,'0'))
	When cp.Letra='B' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_B,'0'))
	When cp.Letra='C' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_C,'0'))
	When cp.Letra='M' Then 51 
	Else 0 
  End,
  IsNull(cp.NumeroComprobante1,1),
  IsNull(cp.NumeroComprobante2,0),
  cp.FechaComprobante,
  Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1),
  Substring(Proveedores.RazonSocial,1,30),
  Null,
  Null,
  Null,
  Null,
  #Auxiliar11.IVAComprasPorcentaje * 100,
  #Auxiliar11.ImporteIva * 100,
  Null,
  ''
 FROM #Auxiliar11
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = #Auxiliar11.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor

 UNION ALL 

 SELECT 
  'C3',
  'C',
  'C',
  Case When cp.Letra='A' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_A,'0'))
	When cp.Letra='B' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_B,'0'))
	When cp.Letra='C' Then Convert(integer,IsNull(tc.CodigoAFIP3_Letra_C,'0'))
	When cp.Letra='M' Then 51 
	Else 0 
  End,
  IsNull(cp.NumeroComprobante1,1),
  IsNull(cp.NumeroComprobante2,0),
  cp.FechaComprobante,
  Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1),
  Substring(Proveedores.RazonSocial,1,30),
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  IsNull(TiposOperaciones.Codigo,0),
  ''
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = cp.IdProveedor
 LEFT OUTER JOIN TiposOperaciones ON TiposOperaciones.IdTipoOperacion = cp.IdTipoOperacion
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and IsNull(Proveedores.OperacionesMercadoInternoEntidadVinculada,'')='SI'

 UNION ALL 

 SELECT 
  'V1',
  'C',
  'V',
  Case When IsNull(Fac.NumeroFacturaInicial,0)>0 Then 80 Else Case When Fac.TipoABC='A' Then 1 When Fac.TipoABC='B' Then 6 When Fac.TipoABC='C' Then 11 When Fac.TipoABC='E' Then 19 End End,
  Fac.PuntoVenta,
  Fac.NumeroFactura,
  Fac.FechaFactura,
  Substring(Clientes.Cuit,1,2)+Substring(Clientes.Cuit,4,8)+Substring(Clientes.Cuit,13,1),
  Substring(Clientes.RazonSocial,1,30),
  Fac.ImporteTotal * Fac.CotizacionMoneda * 100,
  (Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3 + IsNull(Fac.PercepcionIVA,0) + IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)) * Fac.CotizacionMoneda * 100,
  Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
	Then ((Fac.ImporteTotal - IsNull(Fac.RetencionIBrutos1,0) - IsNull(Fac.RetencionIBrutos2,0) - IsNull(Fac.RetencionIBrutos3,0) - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
		IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / (1+(IsNull(Fac.PorcentajeIva1,0)/100))-IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)=9 or (Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0)
	Then 0
	Else ((Fac.ImporteTotal - IsNull(Fac.ImporteIva1,0) - IsNull(Fac.ImporteIva2,0) - IsNull(Fac.RetencionIBrutos1,0) - IsNull(Fac.RetencionIBrutos2,0) - IsNull(Fac.RetencionIBrutos3,0) - 
		IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) - IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
  End * 100,
  Case When Not (Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)=9) and Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0
	Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)
  End * 100,
  Null,
  Null,
  Null,
  ''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Fac.IdCliente
 WHERE (Fac.FechaFactura between @Desde and @hasta) and IsNull(Fac.Anulada,'')<>'SI' and IsNull(Clientes.OperacionesMercadoInternoEntidadVinculada,'')='SI'

 UNION ALL 

 SELECT 
  'V2',
  'C',
  'V',
  Case When IsNull(Fac.NumeroFacturaInicial,0)>0 Then 80 Else Case When Fac.TipoABC='A' Then 1 When Fac.TipoABC='B' Then 6 When Fac.TipoABC='C' Then 11 When Fac.TipoABC='E' Then 19 End End,
  Fac.PuntoVenta,
  Fac.NumeroFactura,
  Fac.FechaFactura,
  Substring(Clientes.Cuit,1,2)+Substring(Clientes.Cuit,4,8)+Substring(Clientes.Cuit,13,1),
  Substring(Clientes.RazonSocial,1,30),
  Null,
  Null,
  Null,
  Null,
  Fac.PorcentajeIva1 * 100,
  Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)<>8 and IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
	 Then ((Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
		IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) + IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Clientes.IdCodigoIva)=9 or (Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0)
	 Then 0
	Else (Fac.ImporteIva1 + Fac.ImporteIva2 + IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
  End * 100,
  Null,
  ''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Fac.IdCliente
 WHERE (Fac.FechaFactura between @Desde and @hasta) and IsNull(Fac.Anulada,'')<>'SI' and IsNull(Clientes.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(Fac.PorcentajeIva1,0)<>0

 UNION ALL 

 SELECT 
  'V3',
  'C',
  'V',
  Case When IsNull(Fac.NumeroFacturaInicial,0)>0 Then 80 Else Case When Fac.TipoABC='A' Then 1 When Fac.TipoABC='B' Then 6 When Fac.TipoABC='C' Then 11 When Fac.TipoABC='E' Then 19 End End,
  Fac.PuntoVenta,
  Fac.NumeroFactura,
  Fac.FechaFactura,
  Substring(Clientes.Cuit,1,2)+Substring(Clientes.Cuit,4,8)+Substring(Clientes.Cuit,13,1),
  Substring(Clientes.RazonSocial,1,30),
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  IsNull(TiposOperaciones.Codigo,0),
  ''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN TiposOperaciones ON TiposOperaciones.IdTipoOperacion = Fac.IdTipoOperacion
 WHERE (Fac.FechaFactura between @Desde and @hasta) and IsNull(Fac.Anulada,'')<>'SI' and IsNull(Clientes.OperacionesMercadoInternoEntidadVinculada,'')='SI'

 UNION ALL 

 SELECT 
  'V1',
  'C',
  'V',
  Case When Cre.TipoABC='A' Then 3 When Cre.TipoABC='B' Then 8 When Cre.TipoABC='C' Then 13 When Cre.TipoABC='E' Then 21 End,
  Cre.PuntoVenta,
  Cre.NumeroNotaCredito,
  Cre.FechaNotaCredito,
  Substring(Clientes.Cuit,1,2)+Substring(Clientes.Cuit,4,8)+Substring(Clientes.Cuit,13,1),
  Substring(Clientes.RazonSocial,1,30),
  Cre.ImporteTotal * Cre.CotizacionMoneda * 100,
  (IsNull(Cre.PercepcionIVA,0) + IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0) + 
	IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda * 100,
  Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)<>8 
	Then IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI'),0) / (1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda
	When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)=9
	 Then 0
	Else IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI'),0) * Cre.CotizacionMoneda
  End * 100,
  Case When Not (Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)=9)
	 Then (IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado<>'SI'),0) + 
		IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda
	Else 0
  End * 100,
  Null,
  Null,
  Null,
  ''
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Cre.IdCliente
 WHERE (Cre.FechaNotaCredito between @Desde and @hasta) and IsNull(Cre.Anulada,'')<>'SI' and IsNull(Clientes.OperacionesMercadoInternoEntidadVinculada,'')='SI'

 UNION ALL 

 SELECT 
  'V2',
  'C',
  'V',
  Case When Cre.TipoABC='A' Then 3 When Cre.TipoABC='B' Then 8 When Cre.TipoABC='C' Then 13 When Cre.TipoABC='E' Then 21 End,
  Cre.PuntoVenta,
  Cre.NumeroNotaCredito,
  Cre.FechaNotaCredito,
  Substring(Clientes.Cuit,1,2)+Substring(Clientes.Cuit,4,8)+Substring(Clientes.Cuit,13,1),
  Substring(Clientes.RazonSocial,1,30),
  Null,
  Null,
  Null,
  Null,
  Cre.PorcentajeIva1 * 100,
  Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)<>8 
	Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
		(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * Cre.CotizacionMoneda
	When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Clientes.IdCodigoIva)=9
	 Then 0
	Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda
  End * 100,
  IsNull(TiposOperaciones.Codigo,0),
  ''
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN TiposOperaciones ON TiposOperaciones.IdTipoOperacion = Cre.IdTipoOperacion
 WHERE (Cre.FechaNotaCredito between @Desde and @hasta) and IsNull(Cre.Anulada,'')<>'SI' and IsNull(Clientes.OperacionesMercadoInternoEntidadVinculada,'')='SI' and IsNull(Cre.PorcentajeIva1,0)<>0

UPDATE #Auxiliar1
SET Cuit = '00000000000'
WHERE Cuit IS NULL or LEN(LTRIM(Cuit))<>11

UPDATE #Auxiliar1
SET Registro = 
		TipoMovimiento+
		TipoRegistro+
		Substring('000',1,3-len(Convert(varchar,TipoComprobante)))+Convert(varchar,TipoComprobante)+
		Substring('0000',1,4-len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta)+
		Substring('00000000000000000000',1,20-len(Convert(varchar,NumeroComprobante)))+Convert(varchar,NumeroComprobante)+
		Convert(varchar,Year(Fecha))+Substring('00',1,2-len(Convert(varchar,Month(Fecha))))+Convert(varchar,Month(Fecha))+Substring('00',1,2-len(Convert(varchar,Day(Fecha))))+Convert(varchar,Day(Fecha))+
		'N'+
		Substring(Cuit+'           ',1,11)+
		Substring(Nombre+'                              ',1,30)+
		Substring('000000000000000',1,15-len(Convert(varchar,ImporteTotal)))+Convert(varchar,ImporteTotal)+
		Substring('000000000000000',1,15-len(Convert(varchar,ImporteExento)))+Convert(varchar,ImporteExento)+
		Substring('000000000000000',1,15-len(Convert(varchar,ImporteGravado)))+Convert(varchar,ImporteGravado)+
		Substring('000000000000000',1,15-len(Convert(varchar,ImporteExento2)))+Convert(varchar,ImporteExento2)
WHERE CodigoRegistro='C1' or CodigoRegistro='V1'

UPDATE #Auxiliar1
SET Registro = 
		'A'+
		TipoRegistro+
		Substring('000',1,3-len(Convert(varchar,TipoComprobante)))+Convert(varchar,TipoComprobante)+
		Substring('0000',1,4-len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta)+
		Substring('00000000000000000000',1,20-len(Convert(varchar,NumeroComprobante)))+Convert(varchar,NumeroComprobante)+
		Substring(Cuit+'           ',1,11)+
		Substring('0000',1,4-len(Convert(varchar,CodigoAlicuotaIva)))+Convert(varchar,CodigoAlicuotaIva)+
		Substring('000000000000000',1,15-len(Convert(varchar,ImporteIva)))+Convert(varchar,ImporteIva)
WHERE CodigoRegistro='C2' or CodigoRegistro='V2'

UPDATE #Auxiliar1
SET Registro = 
		'V'+
		TipoRegistro+
		Substring('000',1,3-len(Convert(varchar,TipoComprobante)))+Convert(varchar,TipoComprobante)+
		Substring('0000',1,4-len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta)+
		Substring('00000000000000000000',1,20-len(Convert(varchar,NumeroComprobante)))+Convert(varchar,NumeroComprobante)+
		Substring(Cuit+'           ',1,11)+
		Substring('00',1,2-len(Convert(varchar,TipoOperacion)))+Convert(varchar,TipoOperacion)
WHERE CodigoRegistro='C3' or CodigoRegistro='V3'

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111133'
SET @vector_T='05555555555555555500'

SELECT 
 0 as [IdAux],
 CodigoRegistro as [CodigoRegistro],
 TipoMovimiento as [TipoMovimiento],
 TipoRegistro as [TipoRegistro],
 TipoComprobante  as [TipoComprobante],
 PuntoVenta as [PuntoVenta],
 NumeroComprobante as [NumeroComprobante],
 Fecha as [Fecha],
 Cuit as [Cuit],
 Nombre as [Nombre],
 ImporteTotal as [ImporteTotal],
 ImporteExento as [ImporteExento],
 ImporteGravado as [ImporteGravado],
 ImporteExento2 as [ImporteExento2],
 CodigoAlicuotaIva as [CodigoAlicuotaIva],
 ImporteIva as [ImporteIva],
 TipoOperacion as [TipoOperacion],
 Registro as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
ORDER BY TipoMovimiento, TipoRegistro, TipoComprobante, Fecha, PuntoVenta, NumeroComprobante, Cuit, CodigoRegistro

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11