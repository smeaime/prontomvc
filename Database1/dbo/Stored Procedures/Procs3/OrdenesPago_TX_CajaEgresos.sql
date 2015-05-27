
CREATE PROCEDURE [dbo].[OrdenesPago_TX_CajaEgresos]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdOrdenPago INTEGER,
			 IdDepositoBancario INTEGER,
			 Grupo INTEGER,
			 IdMoneda INTEGER,
			 Tipo VARCHAR(20),
			 NumeroInterno INTEGER,
			 NumeroValor NUMERIC(18,0),
			 FechaVencimiento DATETIME,
			 Banco VARCHAR(50),
			 Caja VARCHAR(50),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetOP.IdOrdenPago,
  0,
  1,
  OrdenesPago.IdMoneda,
  TiposComprobante.DescripcionAB,
  DetOP.NumeroInterno,
  DetOP.NumeroValor,
  DetOP.FechaVencimiento,
  Bancos.Nombre,
  Cajas.Descripcion,
  DetOP.Importe
 FROM DetalleOrdenesPagoValores DetOP
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetOP.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetOP.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetOP.IdCaja
 WHERE OrdenesPago.FechaOrdenPago between @Desde and @hasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI'

 UNION ALL

 SELECT 
  0,
  DepositosBancarios.IdDepositoBancario,
  1,
  DepositosBancarios.IdMonedaEfectivo,
  'CE',
  Null,
  Null,
  Null,
  Null,
  Cajas.Descripcion,
  DepositosBancarios.Efectivo
 FROM DepositosBancarios
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DepositosBancarios.IdCaja
 WHERE DepositosBancarios.FechaDeposito between @Desde and @hasta and IsNull(DepositosBancarios.Anulado,'NO')<>'SI' and 
	DepositosBancarios.IdCaja is not null

 UNION ALL

 SELECT 
  0,
  Det.IdDepositoBancario,
  1,
  Valores.IdMoneda,
  TiposComprobante.DescripcionAB,
  Valores.NumeroInterno,
  Valores.NumeroValor,
  Valores.FechaValor,
  Bancos.Nombre,
  Null,
  Valores.Importe
 FROM DetalleDepositosBancarios Det
 LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=Det.IdDepositoBancario
 LEFT OUTER JOIN Valores ON Valores.IdValor=Det.IdValor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Valores.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=Valores.IdBanco
 WHERE DepositosBancarios.FechaDeposito between @Desde and @hasta and IsNull(DepositosBancarios.Anulado,'NO')<>'SI'

 UNION ALL

 SELECT OrdenesPago.IdOrdenPago, 0, 2, OrdenesPago.IdMoneda, 'RETENCION IVA', Null, Null, Null, Null, Null, OrdenesPago.RetencionIVA
 FROM OrdenesPago
 WHERE OrdenesPago.FechaOrdenPago between @Desde and @hasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI' and IsNull(OrdenesPago.RetencionIVA,0)<>0

 UNION ALL

 SELECT OrdenesPago.IdOrdenPago, 0, 2, OrdenesPago.IdMoneda, 'RETENCION GANANCIAS', Null, Null, Null, Null, Null, OrdenesPago.RetencionGanancias
 FROM OrdenesPago
 WHERE OrdenesPago.FechaOrdenPago between @Desde and @hasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI' and IsNull(OrdenesPago.RetencionGanancias,0)<>0

 UNION ALL

 SELECT OrdenesPago.IdOrdenPago, 0, 2, OrdenesPago.IdMoneda, 'RETENCION IIBB', Null, Null, Null, Null, Null, OrdenesPago.RetencionIBrutos
 FROM OrdenesPago
 WHERE OrdenesPago.FechaOrdenPago between @Desde and @hasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI' and IsNull(OrdenesPago.RetencionIBrutos,0)<>0

 UNION ALL

 SELECT OrdenesPago.IdOrdenPago, 0, 2, OrdenesPago.IdMoneda, 'RETENCION SUSS', Null, Null, Null, Null, Null, OrdenesPago.RetencionSUSS
 FROM OrdenesPago
 WHERE OrdenesPago.FechaOrdenPago between @Desde and @hasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI' and IsNull(OrdenesPago.RetencionSUSS,0)<>0

CREATE TABLE #Auxiliar2 (IdDepositoBancario INTEGER, IdMoneda INTEGER)
INSERT INTO #Auxiliar2 
 SELECT DepositosBancarios.IdDepositoBancario, 
	IsNull(DepositosBancarios.IdMonedaEfectivo, (Select Top 1 Valores.IdMoneda 
							From DetalleDepositosBancarios Det
							Left Outer Join Valores On Valores.IdValor=Det.IdValor))
 FROM DepositosBancarios
 WHERE DepositosBancarios.FechaDeposito between @Desde and @hasta and IsNull(DepositosBancarios.Anulado,'NO')<>'SI'

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(200)
SET @vector_X='00000011111111111133'
SET @vector_T='000000G4H0020142A900'
SET @vector_E='  |  |  |  |  |  |  |  |  |  |  '

SELECT 
 OrdenesPago.IdOrdenPago as [IdAux1],
 1 as [IdAux2],
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [IdAux3],
 OrdenesPago.IdMoneda as [IdAux4],
 0 as [IdAux5],
 OrdenesPago.FechaOrdenPago as [IdAux6], 
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [Comprobante],
 OrdenesPago.FechaOrdenPago as [Fecha], 
 Case When OrdenesPago.IdProveedor is not null Then Convert(varchar,Proveedores.CodigoEmpresa)+' '+Proveedores.RazonSocial 
	When OrdenesPago.IdCuenta is not null Then Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion
	Else ''
 End as [Origen],
 Monedas.Abreviatura as [Mon.],
 Case When OrdenesPago.IdMoneda<>1 Then 'Cot. '+Convert(varchar,IsNull(OrdenesPago.CotizacionMoneda,0)) Else Null End as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Convert(varchar(5000),OrdenesPago.Observaciones) as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago
LEFT OUTER JOIN Proveedores ON OrdenesPago.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Cuentas ON OrdenesPago.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON OrdenesPago.IdMoneda = Monedas.IdMoneda
WHERE OrdenesPago.FechaOrdenPago between @Desde and @hasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI'

UNION ALL

SELECT 
 DepositosBancarios.IdDepositoBancario as [IdAux1],
 1 as [IdAux2],
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [IdAux3],
 #Auxiliar2.IdMoneda as [IdAux4],
 0 as [IdAux5],
 DepositosBancarios.FechaDeposito as [IdAux6], 
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [Comprobante],
 DepositosBancarios.FechaDeposito as [Fecha], 
 Null as [Origen],
 Monedas.Abreviatura as [Mon.],
 Case When #Auxiliar2.IdMoneda<>1 Then 'Cot. '+Convert(varchar,IsNull(DepositosBancarios.CotizacionMoneda,0)) Else Null End as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Convert(varchar(5000),DepositosBancarios.Observaciones COLLATE Modern_Spanish_CI_AS) as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DepositosBancarios
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdDepositoBancario=DepositosBancarios.IdDepositoBancario
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=#Auxiliar2.IdMoneda
WHERE DepositosBancarios.FechaDeposito between @Desde and @hasta and IsNull(DepositosBancarios.Anulado,'NO')<>'SI' 

UNION ALL

SELECT
 #Auxiliar1.IdOrdenPago as [IdAux1],
 2 as [IdAux2],
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [IdAux3],
 OrdenesPago.IdMoneda as [IdAux4],
 0 as [IdAux5],
 OrdenesPago.FechaOrdenPago as [IdAux6], 
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Case 	When #Auxiliar1.Caja is not null Then #Auxiliar1.Caja 
	When #Auxiliar1.Banco is not null Then #Auxiliar1.Banco 
	 Else Null
 End as [Concepto],
 Case 	When #Auxiliar1.NumeroValor is not null Then Convert(varchar,#Auxiliar1.NumeroValor)
	Else Null
 End as [Numero],
 #Auxiliar1.NumeroInterno as [Nro.Int.],
 #Auxiliar1.FechaVencimiento as [Fec.Vto.],
 #Auxiliar1.Importe as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar1.IdOrdenPago
WHERE #Auxiliar1.Grupo=1 and IsNull(#Auxiliar1.IdOrdenPago,0)>0

UNION ALL

SELECT
 DepositosBancarios.IdDepositoBancario as [IdAux1],
 2 as [IdAux2],
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 DepositosBancarios.FechaDeposito as [IdAux6], 
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Case 	When #Auxiliar1.Caja is not null Then #Auxiliar1.Caja 
	When #Auxiliar1.Banco is not null Then #Auxiliar1.Banco 
	 Else Null
 End as [Concepto],
 Case 	When #Auxiliar1.NumeroValor is not null Then Convert(varchar,#Auxiliar1.NumeroValor)
	Else Null
 End as [Numero],
 #Auxiliar1.NumeroInterno as [Nro.Int.],
 #Auxiliar1.FechaVencimiento as [Fec.Vto.],
 #Auxiliar1.Importe as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=#Auxiliar1.IdDepositoBancario
WHERE #Auxiliar1.Grupo=1 and IsNull(#Auxiliar1.IdDepositoBancario,0)>0

UNION ALL

SELECT 
 OrdenesPago.IdOrdenPago as [IdAux1],
 3 as [IdAux2],
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [IdAux3],
 OrdenesPago.IdMoneda as [IdAux4],
 0 as [IdAux5],
 OrdenesPago.FechaOrdenPago as [IdAux6], 
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago
WHERE OrdenesPago.FechaOrdenPago between @Desde and @hasta and IsNull(OrdenesPago.Anulada,'NO')<>'SI'

UNION ALL

SELECT 
 DepositosBancarios.IdDepositoBancario as [IdAux1],
 3 as [IdAux2],
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [IdAux3],
 #Auxiliar2.IdMoneda as [IdAux4],
 0 as [IdAux5],
 DepositosBancarios.FechaDeposito as [IdAux6], 
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DepositosBancarios
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdDepositoBancario=DepositosBancarios.IdDepositoBancario
WHERE DepositosBancarios.FechaDeposito between @Desde and @hasta and IsNull(DepositosBancarios.Anulado,'NO')<>'SI' 

UNION ALL

SELECT
 #Auxiliar1.IdOrdenPago as [IdAux1],
 4 as [IdAux2],
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [IdAux3],
 OrdenesPago.IdMoneda as [IdAux4],
 0 as [IdAux5],
 OrdenesPago.FechaOrdenPago as [IdAux6], 
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 #Auxiliar1.Importe as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar1.IdOrdenPago
WHERE #Auxiliar1.Grupo=2 and IsNull(#Auxiliar1.IdOrdenPago,0)>0

UNION ALL

SELECT
 #Auxiliar1.IdDepositoBancario as [IdAux1],
 4 as [IdAux2],
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 DepositosBancarios.FechaDeposito as [IdAux6], 
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 #Auxiliar1.Importe as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=#Auxiliar1.IdDepositoBancario
WHERE #Auxiliar1.Grupo=2 and IsNull(#Auxiliar1.IdDepositoBancario,0)>0

UNION ALL

SELECT 
 #Auxiliar1.IdOrdenPago as [IdAux1],
 5 as [IdAux2],
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 OrdenesPago.FechaOrdenPago as [IdAux6], 
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar1.IdOrdenPago
WHERE #Auxiliar1.Grupo=2 and IsNull(#Auxiliar1.IdOrdenPago,0)>0
GROUP BY #Auxiliar1.IdOrdenPago, #Auxiliar1.IdMoneda, OrdenesPago.NumeroOrdenPago, OrdenesPago.FechaOrdenPago

UNION ALL

SELECT 
 #Auxiliar1.IdDepositoBancario as [IdAux1],
 5 as [IdAux2],
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 DepositosBancarios.FechaDeposito as [IdAux6], 
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=#Auxiliar1.IdDepositoBancario
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdDepositoBancario=#Auxiliar1.IdDepositoBancario
WHERE #Auxiliar1.Grupo=2 and IsNull(#Auxiliar1.IdDepositoBancario,0)>0
GROUP BY #Auxiliar1.IdDepositoBancario, #Auxiliar1.IdMoneda, DepositosBancarios.NumeroDeposito, DepositosBancarios.FechaDeposito

UNION ALL

SELECT 
 #Auxiliar1.IdOrdenPago as [IdAux1],
 6 as [IdAux2],
 'OP '+Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
	Convert(varchar,OrdenesPago.NumeroOrdenPago) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 OrdenesPago.FechaOrdenPago as [IdAux6], 
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 'TOTAL OP' as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
 Null as [Observaciones],
 '  |  |  |  |  |  | BOL |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar1.IdOrdenPago
WHERE IsNull(#Auxiliar1.IdOrdenPago,0)>0
GROUP BY #Auxiliar1.IdOrdenPago, #Auxiliar1.IdMoneda, OrdenesPago.NumeroOrdenPago, OrdenesPago.FechaOrdenPago

UNION ALL

SELECT 
 #Auxiliar1.IdDepositoBancario as [IdAux1],
 6 as [IdAux2],
 'DE '+Substring('0000000000',1,10-Len(Convert(varchar,DepositosBancarios.NumeroDeposito)))+
	Convert(varchar,DepositosBancarios.NumeroDeposito) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 DepositosBancarios.FechaDeposito as [IdAux6], 
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 'TOTAL DE' as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
 Null as [Observaciones],
 '  |  |  |  |  |  | BOL |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=#Auxiliar1.IdDepositoBancario
WHERE IsNull(#Auxiliar1.IdDepositoBancario,0)>0
GROUP BY #Auxiliar1.IdDepositoBancario, #Auxiliar1.IdMoneda, DepositosBancarios.NumeroDeposito, DepositosBancarios.FechaDeposito

UNION ALL

SELECT 
 0 as [IdAux1],
 7 as [IdAux2],
 'zzzzzz' as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL

SELECT 
 0 as [IdAux1],
 8 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Comprobante],
 Null as [Fecha], 
 'RESUMEN GENERAL '+IsNull(Monedas.Abreviatura,'') as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
 Null as [Observaciones],
 '  |  | BOL |  |  |  |  |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=#Auxiliar1.IdMoneda
GROUP BY #Auxiliar1.Tipo, #Auxiliar1.IdMoneda, Monedas.Abreviatura

UNION ALL

SELECT 
 0 as [IdAux1],
 8 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Comprobante],
 Null as [Fecha], 
 'TOTAL GENERAL '+IsNull(Monedas.Abreviatura,'') as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
 Null as [Observaciones],
 '  |  | BOL |  |  |  |  |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=#Auxiliar1.IdMoneda
GROUP BY #Auxiliar1.IdMoneda, Monedas.Abreviatura

UNION ALL

SELECT 
 0 as [IdAux1],
 8 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 1 as [IdAux5],
 999999 as [IdAux6],
 Null as [Comprobante],
 Null as [Fecha], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
 Null as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY #Auxiliar1.IdMoneda

UNION ALL

SELECT 
 0 as [IdAux1],
 10 as [IdAux2],
 'zzzzzz' as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Comprobante],
 Null as [Fecha], 
 'TOTAL GENERAL EN PESOS' as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe*IsNull(OrdenesPago.CotizacionMoneda,DepositosBancarios.CotizacionMoneda)) as [Importe],
 Null as [Observaciones],
 '  |  | BOL |  |  |  |  |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar1.IdOrdenPago
LEFT OUTER JOIN DepositosBancarios ON DepositosBancarios.IdDepositoBancario=#Auxiliar1.IdDepositoBancario

ORDER BY [IdAux6], [IdAux3], [IdAux2], [IdAux4], [IdAux5], [Origen], [Nro.Int.]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
