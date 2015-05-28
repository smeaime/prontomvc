CREATE  Procedure [dbo].[Clientes_TX_AnalisisCobranzaFacturacionDetallado]

@Desde datetime, 
@Hasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdMonedaPesos int, @IdMonedaDolar int, @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
		@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int

SET @IdMonedaPesos=(Select IdMoneda From Parametros Where IdParametro=1)
SET @IdMonedaDolar=(Select IdMonedaDolar From Parametros Where IdParametro=1)
SET @IdTipoComprobanteFacturaVenta=(Select IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 PuntoVenta INTEGER,
			 Fecha DATETIME,
			 Comprobante VARCHAR(100),
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 2, DetRec.IdRecibo, Year(Recibos.FechaRecibo), Month(Recibos.FechaRecibo), 
	Case When Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta Then Facturas.PuntoVenta
		When Cta.IdTipoComp=@IdTipoComprobanteDevoluciones Then Devoluciones.PuntoVenta
		When Cta.IdTipoComp=@IdTipoComprobanteNotaDebito Then NotasDebito.PuntoVenta
		When Cta.IdTipoComp=@IdTipoComprobanteNotaCredito Then NotasCredito.PuntoVenta
		Else 0
	End, 
	Recibos.FechaRecibo,
	'RE '+IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
		Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)+' s/'+
	Case When Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Facturas.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura),
			Substring('00000000',1,8-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante))
	When Cta.IdTipoComp=@IdTipoComprobanteDevoluciones
	 Then TiposComprobante.DescripcionAb+' '+IsNull(Devoluciones.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion),
			Substring('00000000',1,8-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante))
	When Cta.IdTipoComp=@IdTipoComprobanteNotaDebito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasDebito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito),
			Substring('00000000',1,8-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante))
	When Cta.IdTipoComp=@IdTipoComprobanteNotaCredito
	 Then TiposComprobante.DescripcionAb+' '+IsNull(NotasCredito.TipoABC+'-','')+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,NotasCredito.PuntoVenta)))+Convert(varchar,NotasCredito.PuntoVenta)+'-','')+
		IsNull(Substring('00000000',1,8-Len(Convert(varchar,NotasCredito.NumeroNotaCredito)))+Convert(varchar,NotasCredito.NumeroNotaCredito),
			Substring('00000000',1,8-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante))
	When Cta.IdTipoComp=@IdTipoComprobanteRecibo
	 Then TiposComprobante.DescripcionAb+' '+
		IsNull(Substring('0000',1,4-Len(Convert(varchar,r1.PuntoVenta)))+Convert(varchar,r1.PuntoVenta)+'-','')+
		IsNull(Substring('0000000000',1,10-Len(Convert(varchar,r1.NumeroRecibo)))+Convert(varchar,r1.NumeroRecibo),
			Substring('00000000',1,8-Len(Convert(varchar,Cta.NumeroComprobante)))+Convert(varchar,Cta.NumeroComprobante))
	 Else 'Anticipo RE '+IsNull(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-','')+
		Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	End+' del '+Convert(varchar,IsNull(Cta.Fecha,Recibos.FechaRecibo),103),
	DetRec.Importe*Recibos.CotizacionMoneda
 FROM DetalleRecibos DetRec
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRec.IdRecibo
 LEFT OUTER JOIN CuentasCorrientesDeudores Cta ON Cta.IdCtaCte=DetRec.IdImputacion
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Cta.IdTipoComp
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos r1 ON r1.IdRecibo=Cta.IdComprobante and Cta.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE Recibos.FechaRecibo between @Desde and @Hasta and IsNull(Recibos.Anulado,'NO')<>'SI'

INSERT INTO #Auxiliar1 
 SELECT 1, Facturas.IdFactura, Year(Facturas.FechaFactura), Month(Facturas.FechaFactura), Facturas.PuntoVenta, Facturas.FechaFactura, 
		'FA '+IsNull(Facturas.TipoABC+'-','')+IsNull(Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-','')+
			Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)+' del '+Convert(varchar,Facturas.FechaFactura,103), 
		Facturas.ImporteTotal*Facturas.CotizacionMoneda
 FROM Facturas
 WHERE Facturas.FechaFactura between @Desde and @Hasta and IsNull(Facturas.Anulada,'NO')<>'SI'

CREATE TABLE #Auxiliar2 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 PuntoVenta INTEGER,
			 Fecha DATETIME,
			 Comprobante VARCHAR(100),
			 Importe NUMERIC(18,2),
			 Importe1 NUMERIC(18,2),
			 Importe2 NUMERIC(18,2),
			 Importe3 NUMERIC(18,2),
			 Importe4 NUMERIC(18,2),
			 Importe5 NUMERIC(18,2),
			 Importe6 NUMERIC(18,2),
			 Importe7 NUMERIC(18,2),
			 Importe8 NUMERIC(18,2),
			 Importe9 NUMERIC(18,2),
			 Importe10 NUMERIC(18,2),
			 Importe11 NUMERIC(18,2),
			 Importe12 NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT IdTipoComprobante, IdComprobante, Año, Mes, PuntoVenta, Fecha, Comprobante, Importe, 
	Case When Mes=1 Then Importe Else Null End, Case When Mes=2 Then Importe Else Null End, Case When Mes=3 Then Importe Else Null End, 
	Case When Mes=4 Then Importe Else Null End, Case When Mes=5 Then Importe Else Null End, Case When Mes=6 Then Importe Else Null End, 
	Case When Mes=7 Then Importe Else Null End, Case When Mes=8 Then Importe Else Null End, Case When Mes=9 Then Importe Else Null End, 
	Case When Mes=10 Then Importe Else Null End, Case When Mes=11 Then Importe Else Null End, Case When Mes=12 Then Importe Else Null End
 FROM #Auxiliar1

CREATE TABLE #Auxiliar3 
			(
			 IdTipoComprobante INTEGER,
			 Año INTEGER,
			 PuntoVenta INTEGER,
			 Importe1 NUMERIC(18,2),
			 Importe2 NUMERIC(18,2),
			 Importe3 NUMERIC(18,2),
			 Importe4 NUMERIC(18,2),
			 Importe5 NUMERIC(18,2),
			 Importe6 NUMERIC(18,2),
			 Importe7 NUMERIC(18,2),
			 Importe8 NUMERIC(18,2),
			 Importe9 NUMERIC(18,2),
			 Importe10 NUMERIC(18,2),
			 Importe11 NUMERIC(18,2),
			 Importe12 NUMERIC(18,2)
			)
INSERT INTO #Auxiliar3 
 SELECT IdTipoComprobante, Año, PuntoVenta, Sum(IsNull(Importe1,0)), Sum(IsNull(Importe2,0)), Sum(IsNull(Importe3,0)), Sum(IsNull(Importe4,0)), 
	Sum(IsNull(Importe5,0)), Sum(IsNull(Importe6,0)), Sum(IsNull(Importe7,0)), Sum(IsNull(Importe8,0)), Sum(IsNull(Importe9,0)), 
	Sum(IsNull(Importe10,0)), Sum(IsNull(Importe11,0)), Sum(IsNull(Importe12,0))
 FROM #Auxiliar2
 GROUP BY IdTipoComprobante, Año, PuntoVenta

INSERT INTO #Auxiliar3 
 SELECT 0, Año, PuntoVenta, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM #Auxiliar3
 GROUP BY Año, PuntoVenta

UPDATE #Auxiliar3
SET Importe1=Round(IsNull((Select Top 1 A1.Importe1 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe1 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe1 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe2=Round(IsNull((Select Top 1 A1.Importe2 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe2 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe2 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe3=Round(IsNull((Select Top 1 A1.Importe3 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe3 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe3 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe4=Round(IsNull((Select Top 1 A1.Importe4 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe4 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe4 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe5=Round(IsNull((Select Top 1 A1.Importe5 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe5 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe5 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe6=Round(IsNull((Select Top 1 A1.Importe6 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe6 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe6 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe7=Round(IsNull((Select Top 1 A1.Importe7 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe7 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe7 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe8=Round(IsNull((Select Top 1 A1.Importe8 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe8 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe8 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe9=Round(IsNull((Select Top 1 A1.Importe9 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe9 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe9 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe10=Round(IsNull((Select Top 1 A1.Importe10 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe10 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe10 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe11=Round(IsNull((Select Top 1 A1.Importe11 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe11 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe11 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0
UPDATE #Auxiliar3
SET Importe12=Round(IsNull((Select Top 1 A1.Importe12 From #Auxiliar3 A1 Where A1.IdTipoComprobante=2 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) / 
		IsNull((Select Top 1 A1.Importe12 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0) * 100,2)
WHERE IdTipoComprobante=0 and IsNull((Select Top 1 A1.Importe12 From #Auxiliar3 A1 Where A1.IdTipoComprobante=1 and A1.Año=#Auxiliar3.Año and A1.PuntoVenta=#Auxiliar3.PuntoVenta),0)<>0

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='000000111166666666666633'
SET @vector_T='000000222233333333333300'

SELECT
 0 as [IdAux],
 Año as [A_Año],
 1 as [A_Orden],
 PuntoVenta as [A_PuntoVenta],
 IdTipoComprobante as [A_IdTipoComprobante],
 Fecha as [A_Fecha],
 Año as [Año],
 PuntoVenta as [P.Venta],
 Case When IdTipoComprobante=1 Then 'Facturado' 
	When IdTipoComprobante=2 Then 'Cobrado' 
	When IdTipoComprobante=0 Then '%' 
	Else Null
 End as [Operacion],
 Comprobante as [Comprobante],
 Importe1 as [Enero],
 Importe2 as [Febrero],
 Importe3 as [Marzo],
 Importe4 as [Abril],
 Importe5 as [Mayo],
 Importe6 as [Junio],
 Importe7 as [Julio],
 Importe8 as [Agosto],
 Importe9 as [Setiembre],
 Importe10 as [Octubre],
 Importe11 as [Noviembre],
 Importe12 as [Diciembre],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

UNION ALL

SELECT
 0 as [IdAux],
 Año as [A_Año],
 2 as [A_Orden],
 PuntoVenta as [A_PuntoVenta],
 IdTipoComprobante as [A_IdTipoComprobante],
 @Hasta as [A_Fecha],
 Año as [Año],
 PuntoVenta as [P.Venta],
 'TOTAL '+Case When IdTipoComprobante=1 Then 'FACTURADO' When IdTipoComprobante=2 Then 'COBRADO' When IdTipoComprobante=0 Then '%' Else Null End as [Operacion],
 Null as [Comprobante],
 Importe1 as [Enero],
 Importe2 as [Febrero],
 Importe3 as [Marzo],
 Importe4 as [Abril],
 Importe5 as [Mayo],
 Importe6 as [Junio],
 Importe7 as [Julio],
 Importe8 as [Agosto],
 Importe9 as [Setiembre],
 Importe10 as [Octubre],
 Importe11 as [Noviembre],
 Importe12 as [Diciembre],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3

UNION ALL

SELECT
 0 as [IdAux],
 Año as [A_Año],
 3 as [A_Orden],
 9999 as [A_PuntoVenta],
 Null as [A_IdTipoComprobante],
 @Hasta as [A_Fecha],
 Null as [Año],
 Null as [P.Venta],
 Null as [Operacion],
 Null as [Comprobante],
 Null as [Enero],
 Null as [Febrero],
 Null as [Marzo],
 Null as [Abril],
 Null as [Mayo],
 Null as [Junio],
 Null as [Julio],
 Null as [Agosto],
 Null as [Setiembre],
 Null as [Octubre],
 Null as [Noviembre],
 Null as [Diciembre],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
GROUP BY Año

ORDER BY [A_Año], [A_PuntoVenta], [A_IdTipoComprobante] Desc, [A_Orden], [A_Fecha]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3