CREATE PROCEDURE [dbo].[Proveedores_TX_CITI]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar1
			(
			 A_IdComprobanteProveedor INTEGER,
			 A_Iva NUMERIC(18,0)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA1 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras1 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA1 is not null and dcp.ImporteIVA1<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')
 
 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA2 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras2 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA2 is not null and dcp.ImporteIVA2<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA3 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras3 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA3 is not null and dcp.ImporteIVA3<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA4 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras4 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA4 is not null and dcp.ImporteIVA4<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA5 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras5 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA5 is not null and dcp.ImporteIVA5<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA6 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras6 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA6 is not null and dcp.ImporteIVA6<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA7 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras7 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA7 is not null and dcp.ImporteIVA7<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA8 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras8 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA8 is not null and dcp.ImporteIVA8<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA9 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras9 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA9 is not null and dcp.ImporteIVA9<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.ImporteIVA10 * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuentaIvaCompras10 = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(dcp.ImporteIVA10 is not null and dcp.ImporteIVA10<>0 and 
	 Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

 UNION ALL

 SELECT 
  cp.IdComprobanteProveedor,
  ROUND(cp.AjusteIVA * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	(cp.AjusteIVA is not null and cp.AjusteIVA<>0)

 UNION ALL

 SELECT 
  dcp.IdComprobanteProveedor,
  ROUND(dcp.Importe * tc.Coeficiente * cp.CotizacionMoneda,2) * 100
 FROM DetalleComprobantesProveedores dcp
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(cp.Confirmado is null or cp.Confirmado<>'NO') and 
	IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaGrupoIVA and IsNull(Cuentas.VaAlCiti,'')='SI'


CREATE TABLE #Auxiliar2 
			(
			 A_IdComprobanteProveedor INTEGER,
			 A_Iva NUMERIC(18,0)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  A_IdComprobanteProveedor,
  SUM(A_Iva)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.A_IdComprobanteProveedor


CREATE TABLE #Auxiliar3 
			(
			 A_IdProveedor INTEGER,
			 A_IdCliente INTEGER,
			 A_TipoMovimiento VARCHAR(10),
			 A_TipoComprobante VARCHAR(5),
			 A_NumeroNovimiento INTEGER,
			 A_CodigoComprobante VARCHAR(2),
			 A_PuntoVenta INTEGER,
			 A_NumeroComprobante INTEGER,
			 A_Fecha DATETIME,
			 A_Cuit VARCHAR(11),
			 A_Nombre VARCHAR(50),
			 A_Iva NUMERIC(18,0),
			 A_Registro VARCHAR(150)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  Case When cp.IdProveedor is not null Then cp.IdProveedor Else cp.IdProveedorEventual End,
  0,
  'Mov.Prov.',
  tc.DescripcionAb,
  cp.NumeroReferencia,
  Case When cp.Letra='A' Then IsNull(Tc.CodigoAFIP2_Letra_A,'01')
	When cp.Letra='B' Then IsNull(Tc.CodigoAFIP2_Letra_B,'06')
	When cp.Letra='C' Then IsNull(Tc.CodigoAFIP2_Letra_C,'11')
	When cp.Letra='E' Then IsNull(Tc.CodigoAFIP2_Letra_E,'19')
	When cp.Letra='M' Then '51'
	Else '00'
  End,
  Case When cp.NumeroComprobante1 is not null Then cp.NumeroComprobante1 Else 1 End,
  cp.NumeroComprobante2,
  cp.FechaComprobante,  --cp.FechaRecepcion,
  '00000000000',
  '.',
  Abs(#Auxiliar2.A_Iva),
  ''
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN #Auxiliar2 ON cp.IdComprobanteProveedor = #Auxiliar2.A_IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 WHERE (cp.FechaRecepcion between @Desde and @hasta) and 
	(#Auxiliar2.A_Iva is not null and #Auxiliar2.A_Iva<>0) and
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI')

UNION ALL 

 SELECT 
  0,
  0,
  'Asiento',
  'AS',
  Asientos.NumeroAsiento,
  tc.CodigoDGI,
  1,
  Case When ds.NumeroComprobante is not null Then ds.NumeroComprobante Else Asientos.NumeroAsiento End,
  Asientos.FechaAsiento,
  Case When ds.Cuit is not null and len(ds.Cuit)=13
	Then Substring(ds.Cuit,1,2)+Substring(ds.Cuit,4,8)+Substring(ds.Cuit,13,1)
	Else '00000000000'
  End,
  '.',
  Case When ds.Debe is not null 
	Then ds.Debe * 100
       When ds.Haber is not null
	Then ds.Haber * 100 -- * -1
	Else 0
  End,
  ''
 FROM DetalleAsientos ds
 LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = ds.IdAsiento
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante = ds.IdTipoComprobante
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = ds.IdCuenta
 WHERE (Asientos.FechaAsiento between @Desde and @hasta) and 
	(ds.Libro='C' and ds.TipoImporte='I') and 
	(Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

UNION ALL 

 SELECT 
  0,
  0,
  'Gs.banco',
  tc.DescripcionAb,
  Valores.NumeroComprobante,
  tc.CodigoDGI,
  1,
  Valores.NumeroComprobante,
  Valores.FechaComprobante,
  Case When Bancos.Cuit is not null and len(Bancos.Cuit)=13
	Then Substring(Bancos.Cuit,1,2)+Substring(Bancos.Cuit,4,8)+Substring(Bancos.Cuit,13,1)
	Else '00000000000'
  End,
  Bancos.Nombre,
  Valores.IVA * 100, -- * TiposComprobante.Coeficiente,
  ''
 FROM Valores 
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Valores.IdCuentaIVA
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
 WHERE Valores.Estado='G' and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.IVA is not null and Valores.IVA<>0) and 
	(Valores.FechaComprobante between @Desde and @hasta) and
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and 
	(Cuentas.VaAlCiti is not null and Cuentas.VaAlCiti='SI')

UNION ALL 

 SELECT 
  0,
  Cre.IdCliente,
  'NC Ventas',
  'NC',
  Cre.NumeroNotaCredito,
  Case When Cre.TipoABC='A' Then IsNull(Tc.CodigoAFIP2_Letra_A,'03')
	When Cre.TipoABC='B' Then IsNull(Tc.CodigoAFIP2_Letra_B,'08')
	When Cre.TipoABC='C' Then IsNull(Tc.CodigoAFIP2_Letra_C,'13')
	When Cre.TipoABC='E' Then IsNull(Tc.CodigoAFIP2_Letra_E,'21')
  End,
  Cre.PuntoVenta,
  Cre.NumeroNotaCredito,
  Cre.FechaNotaCredito,
  '00000000000',
  '.',
  IsNull(
  Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
	Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
		Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
		(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * 
		Cre.CotizacionMoneda * 100
	When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or 
		IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
	 Then 0
	Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda * 100
  End,0),
  ''
 FROM NotasCredito Cre 
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=4
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE (Cre.FechaNotaCredito between @Desde and @hasta) and IsNull(Cre.Anulada,'NO')<>'SI' and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') and Cre.CtaCte='SI'

UNION ALL 

 SELECT 
  0,
  Dev.IdCliente,
  'NC Dev.',
  'NC',
  Dev.NumeroDevolucion,
  Case When Dev.TipoABC='A' Then IsNull(Tc.CodigoAFIP2_Letra_A,'03')
	When Dev.TipoABC='B' Then IsNull(Tc.CodigoAFIP2_Letra_B,'08')
	When Dev.TipoABC='C' Then IsNull(Tc.CodigoAFIP2_Letra_C,'13')
	When Dev.TipoABC='E' Then IsNull(Tc.CodigoAFIP2_Letra_E,'21')
  End,
  Dev.PuntoVenta,
  Dev.NumeroDevolucion,
  Dev.FechaDevolucion,
  '00000000000',
  '.',
  IsNull(
  Case When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 
	Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
		Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
		(1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1/100) * 
		Dev.CotizacionMoneda * 100
	When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or 
		IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
	 Then 0
	Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * 100
  End,0),
  ''
 FROM Devoluciones Dev 
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=5
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE (Dev.FechaDevolucion between @Desde and @hasta) and IsNull(Dev.Anulada,'NO')<>'SI' and 
	(tc.VaAlCITI is not null and tc.VaAlCITI='SI') 

UPDATE #Auxiliar3
SET A_IdProveedor = 0
WHERE A_IdProveedor IS NULL

UPDATE #Auxiliar3
SET A_IdCliente = 0
WHERE A_IdCliente IS NULL

UPDATE #Auxiliar3
SET A_Cuit = (Select Top 1 Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1) From Proveedores
		Where Proveedores.IdProveedor=#Auxiliar3.A_IdProveedor)
WHERE A_IdProveedor<>0

UPDATE #Auxiliar3
SET A_Cuit = (Select Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa Where IdEmpresa=1)
WHERE A_IdCliente<>0

UPDATE #Auxiliar3
SET A_Cuit = Substring(A_Cuit,1,2)+Substring(A_Cuit,4,8)+Substring(A_Cuit,13,1)
WHERE A_Cuit IS NOT NULL and LEN(A_Cuit)=13 and (A_IdProveedor<>0 or A_IdCliente<>0)

UPDATE #Auxiliar3
SET A_Cuit = '00000000000'
WHERE A_Cuit IS NULL or LEN(LTRIM(A_Cuit))<>11

UPDATE #Auxiliar3
SET A_Nombre = (Select Top 1 Proveedores.RazonSocial From Proveedores Where Proveedores.IdProveedor=#Auxiliar3.A_IdProveedor)
WHERE A_IdProveedor<>0

UPDATE #Auxiliar3
SET A_Nombre = (Select Top 1 Nombre From Empresa Where IdEmpresa=1)
WHERE A_IdCliente<>0

UPDATE #Auxiliar3
SET A_Nombre = '.'
WHERE A_Nombre IS NULL

UPDATE #Auxiliar3
SET A_Registro = #Auxiliar3.A_CodigoComprobante+
		 Substring('0000',1,4-len(Convert(varchar,#Auxiliar3.A_PuntoVenta)))+Convert(varchar,#Auxiliar3.A_PuntoVenta)+
		 Substring('00000000000000000000',1,20-len(Convert(varchar,#Auxiliar3.A_NumeroComprobante)))+Convert(varchar,#Auxiliar3.A_NumeroComprobante)+
		 Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar3.A_Fecha))))+Convert(varchar,Day(#Auxiliar3.A_Fecha))+
			 Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar3.A_Fecha))))+Convert(varchar,Month(#Auxiliar3.A_Fecha))+
			 Convert(varchar,Year(#Auxiliar3.A_Fecha))+
		 #Auxiliar3.A_Cuit+
		 Substring(#Auxiliar3.A_Nombre+'                         ',1,25)+
		 Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar3.A_Iva)))+Convert(varchar,#Auxiliar3.A_Iva)+
		 '00000000000'+
		 '                         '+
		 '000000000000'

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111133'
SET @vector_T='0222224585500'

SELECT 
 #Auxiliar3.A_IdProveedor,
 #Auxiliar3.A_TipoMovimiento as [Movim.],
-- #Auxiliar3.A_TipoComprobante as [Tipo],
 #Auxiliar3.A_NumeroNovimiento as [Nro.mov.],
 #Auxiliar3.A_CodigoComprobante as [Cod.DGI],
 #Auxiliar3.A_PuntoVenta as [Punto vta.],
 #Auxiliar3.A_NumeroComprobante as [Numero],
 #Auxiliar3.A_Fecha as [Fecha],
 #Auxiliar3.A_Cuit as [Cuit],
 #Auxiliar3.A_Nombre as [Proveedor / Cliente],
 Convert(Numeric(18,2),#Auxiliar3.A_Iva)/100 as [Importe IVA],
 #Auxiliar3.A_Registro as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3 
ORDER By A_Fecha,A_CodigoComprobante,A_PuntoVenta,A_NumeroComprobante

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3