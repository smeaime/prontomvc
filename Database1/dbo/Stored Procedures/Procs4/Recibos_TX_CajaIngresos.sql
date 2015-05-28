CREATE PROCEDURE [dbo].[Recibos_TX_CajaIngresos]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdRecibo INTEGER,
			 Grupo INTEGER,
			 IdMoneda INTEGER,
			 Tipo VARCHAR(20),
			 NumeroInterno INTEGER,
			 NumeroValor NUMERIC(18,0),
			 FechaVencimiento DATETIME,
			 Banco VARCHAR(50),
			 Caja VARCHAR(50),
			 Tarjeta VARCHAR(50),
			 NumeroTarjeta VARCHAR(20),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetRec.IdRecibo,
  1,
  Recibos.IdMoneda,
  TiposComprobante.DescripcionAB,
  DetRec.NumeroInterno,
  DetRec.NumeroValor,
  DetRec.FechaVencimiento,
  Bancos.Nombre,
  Cajas.Descripcion,
  TarjetasCredito.Nombre,
  DetRec.NumeroTarjetaCredito,
  DetRec.Importe
 FROM DetalleRecibosValores DetRec
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRec.IdRecibo
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetRec.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetRec.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetRec.IdCaja
 LEFT OUTER JOIN TarjetasCredito ON TarjetasCredito.IdTarjetaCredito=DetRec.IdTarjetaCredito
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI'

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, 'RETENCION IVA', Null, Null, Null, Null, Null, Null, Null, Recibos.RetencionIVA
 FROM Recibos
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.RetencionIVA,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, 'RETENCION GANANCIAS', Null, Null, Null, Null, Null, Null, Null, Recibos.RetencionGanancias
 FROM Recibos
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.RetencionGanancias,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros1
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta1 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros1,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros2
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta2 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros2,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros3
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta3 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros3,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros4
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta4 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros4,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros5
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta5 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros5,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros6
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta6 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros6,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros7
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta7 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros7,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros8
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta8 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros8,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros9
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta9 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros9,0)<>0

 UNION ALL

 SELECT Recibos.IdRecibo, 2, Recibos.IdMoneda, Substring(Cuentas.Descripcion,1,20), Null, Null, Null, Null, Null, Null, Null, Recibos.Otros10
 FROM Recibos
 LEFT OUTER JOIN Cuentas ON  Recibos.IdCuenta10 = Cuentas.IdCuenta
 WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI' and IsNull(Recibos.Otros10,0)<>0

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(200)
SET @vector_X='00000011111111161133'
SET @vector_T='000000F4H00201431900'
SET @vector_E='  |  |  |  |  |  |  |  |  |  |  '

SELECT 
 Recibos.IdRecibo as [IdAux1],
 1 as [IdAux2],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux3],
 Recibos.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [Recibo],
 Recibos.FechaRecibo as [Fecha Recibo], 
 Case When Recibos.IdCliente is not null Then Convert(varchar,Clientes.CodigoCliente)+' '+Clientes.RazonSocial COLLATE Modern_Spanish_CI_AS 
	When Recibos.IdCuenta is not null Then Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion
	Else ''
 End as [Origen],
 Monedas.Abreviatura as [Mon.],
 Case When Recibos.IdMoneda<>1 Then 'Cot. '+Convert(varchar,IsNull(Recibos.CotizacionMoneda,0)) Else Null End as [Tipo],
 Case When IsNull(Recibos.Anulado,'NO')='SI' Then 'ANULADO' Else Null End as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Null as [Importe],
 Recibos.Observaciones as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
LEFT OUTER JOIN Cuentas ON Recibos.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda = Monedas.IdMoneda
WHERE Recibos.FechaRecibo between @Desde and @hasta -- and IsNull(Recibos.Anulado,'NO')<>'SI'

UNION ALL

SELECT
 #Auxiliar1.IdRecibo as [IdAux1],
 2 as [IdAux2],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [Recibo],
 Null as [Fecha Recibo], 
 Null as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Case 	When Caja is not null Then Caja 
	When Banco is not null Then Banco 
	When Tarjeta is not null Then Tarjeta 
	 Else Null
 End as [Concepto],
 Case 	When #Auxiliar1.NumeroValor is not null Then Convert(varchar,#Auxiliar1.NumeroValor)
	When #Auxiliar1.NumeroTarjeta is not null Then #Auxiliar1.NumeroTarjeta
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
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
WHERE #Auxiliar1.Grupo=1

UNION ALL

SELECT 
 Recibos.IdRecibo as [IdAux1],
 3 as [IdAux2],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux3],
 Recibos.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
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
FROM Recibos
WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI'

UNION ALL

SELECT
 #Auxiliar1.IdRecibo as [IdAux1],
 4 as [IdAux2],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [Recibo],
 Null as [Fecha Recibo], 
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
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
WHERE #Auxiliar1.Grupo=2

UNION ALL

SELECT 
 #Auxiliar1.IdRecibo as [IdAux1],
 5 as [IdAux2],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
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
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
WHERE #Auxiliar1.Grupo=2
GROUP BY #Auxiliar1.IdRecibo, #Auxiliar1.IdMoneda, Recibos.Tipo, Recibos.PuntoVenta, Recibos.NumeroRecibo, Recibos.FechaRecibo

UNION ALL

SELECT 
 #Auxiliar1.IdRecibo as [IdAux1],
 6 as [IdAux2],
 Recibos.Tipo+' '+Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo) as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
 Null as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 'TOTAL RECIBO' as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe) as [Importe],
 Null as [Observaciones],
 '  |  |  |  |  |  | BOL |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
GROUP BY #Auxiliar1.IdRecibo, #Auxiliar1.IdMoneda, Recibos.Tipo, Recibos.PuntoVenta, Recibos.NumeroRecibo, Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1],
 7 as [IdAux2],
 'zzzzzz' as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
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
FROM Recibos
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
LEFT OUTER JOIN Cuentas ON Recibos.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda = Monedas.IdMoneda
WHERE Recibos.FechaRecibo between @Desde and @hasta and IsNull(Recibos.Anulado,'NO')<>'SI'
GROUP BY Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1],
 8 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
 'RESUMEN DIARIO '+IsNull(Monedas.Abreviatura,'')+' - '+Convert(varchar,Recibos.FechaRecibo,103) as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe) as [Importe],
 Null as [Observaciones],
 '  |  | BOL |  |  |  |  |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=#Auxiliar1.IdMoneda
GROUP BY #Auxiliar1.Tipo, #Auxiliar1.IdMoneda, Monedas.Abreviatura, Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1],
 8 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
 'TOTAL DIARIO '+IsNull(Monedas.Abreviatura,'')+' - '+Convert(varchar,Recibos.FechaRecibo,103) as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe) as [Importe],
 Null as [Observaciones],
 '  |  | BOL |  |  |  |  |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=#Auxiliar1.IdMoneda
GROUP BY #Auxiliar1.IdMoneda, Monedas.Abreviatura, Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1],
 8 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 1 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
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
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
GROUP BY #Auxiliar1.IdMoneda, Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1],
 10 as [IdAux2],
 'zzzzzz' as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
 'TOTAL GENERAL DIARIO EN PESOS '+Convert(varchar,Recibos.FechaRecibo,103) as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe*Recibos.CotizacionMoneda) as [Importe],
 Null as [Observaciones],
 '  |  | BOL |  |  |  |  |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo
GROUP BY Recibos.FechaRecibo

UNION ALL

SELECT 
 0 as [IdAux1],
 70 as [IdAux2],
 'zzzzzz' as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
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
 80 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
 'RESUMEN GENERAL '+IsNull(Monedas.Abreviatura,'') as [Origen],
 Null as [Mon.],
 #Auxiliar1.Tipo as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe) as [Importe],
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
 80 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
 'TOTAL GENERAL '+IsNull(Monedas.Abreviatura,'') as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe) as [Importe],
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
 80 as [IdAux2],
 'zzzzzz' as [IdAux3],
 #Auxiliar1.IdMoneda as [IdAux4],
 1 as [IdAux5],
 999999 as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
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
GROUP BY #Auxiliar1.IdMoneda

UNION ALL

SELECT 
 0 as [IdAux1],
 100 as [IdAux2],
 'zzzzzz' as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 999999 as [IdAux6],
 Null as [Recibo],
 Null as [Fecha Recibo], 
 'TOTAL GENERAL EN PESOS' as [Origen],
 Null as [Mon.],
 Null as [Tipo],
 Null as [Concepto],
 Null as [Numero],
 Null as [Nro.Int.],
 Null as [Fec.Vto.],
 Sum(#Auxiliar1.Importe*Recibos.CotizacionMoneda) as [Importe],
 Null as [Observaciones],
 '  |  | BOL |  |  |  |  |  |  | BOL |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar1.IdRecibo

ORDER BY [IdAux6], [IdAux3], [IdAux2], [IdAux4], [IdAux5], [Origen], [Nro.Int.]

DROP TABLE #Auxiliar1