CREATE Procedure [dbo].[CtasCtesD_TXPorMayor]

@IdCliente int,
@Todo int,
@FechaLimite datetime,
@FechaDesde datetime = Null,
@Consolidar int = Null

AS 

SET NOCOUNT ON

SET @FechaDesde=IsNull(@FechaDesde,Convert(datetime,'1/1/2000'))
SET @Consolidar=IsNull(@Consolidar,-1)

DECLARE @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int,@IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,@IdTipoComprobanteRecibo int, @SaldoInicial numeric(18,2)

IF @Todo=-1
	SET @SaldoInicial=0
ELSE
	SET @SaldoInicial=IsNull((Select Sum(IsNull(CtaCte.ImporteTotal,0) * IsNull(tc.Coeficiente,1))
				  From CuentasCorrientesDeudores CtaCte
				  Left Outer Join TiposComprobante tc On tc.IdTipoComprobante=CtaCte.IdTipoComp
				  Where CtaCte.IdCliente=@IdCliente and CtaCte.Fecha<@FechaDesde),0)

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1
			(
			 IdCtaCte INTEGER,
			 IdTipoComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdComprobante INTEGER,
			 NumeroComprobante INTEGER,
			 Fecha DATETIME,
			 FechaVencimiento DATETIME,
			 ImporteTotal NUMERIC(18,2),
			 IdMoneda INTEGER
			)
IF @Todo<>-1
	INSERT INTO #Auxiliar1 
	 SELECT 0, 0, 'INI', 0, 0, @FechaDesde, Null, @SaldoInicial, 1

INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  Case When CtaCte.IdTipoComp=16 
	Then Case When CtaCte.IdDetalleNotaCreditoImputaciones is not null Then @IdTipoComprobanteNotaCredito Else @IdTipoComprobanteRecibo End
	Else CtaCte.IdTipoComp 
  End,
  TiposComprobante.DescripcionAB,
  CtaCte.IdComprobante,
  IsNull(CtaCte.NumeroComprobante,0),
  CtaCte.Fecha,
  IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha),
  CtaCte.ImporteTotal * TiposComprobante.Coeficiente,
  CtaCte.IdMoneda
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE CtaCte.IdCliente=@IdCliente and (@Todo=-1 or CtaCte.Fecha between @FechaDesde and @FechaLimite)

CREATE TABLE #Auxiliar2
			(
			 IdCtaCte INTEGER,
			 IdTipoComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdComprobante INTEGER,
			 NumeroComprobante INTEGER,
			 Fecha DATETIME,
			 FechaVencimiento DATETIME,
			 ImporteTotal NUMERIC(18,2),
			 IdMoneda INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT 
  MAX(#Auxiliar1.IdCtaCte),
  #Auxiliar1.IdTipoComprobante,
  MAX(#Auxiliar1.TipoComprobante),
  #Auxiliar1.IdComprobante,
  #Auxiliar1.NumeroComprobante,
  #Auxiliar1.Fecha,
  #Auxiliar1.FechaVencimiento,
  SUM(#Auxiliar1.ImporteTotal),
  #Auxiliar1.IdMoneda
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.IdTipoComprobante, #Auxiliar1.IdComprobante, #Auxiliar1.NumeroComprobante, #Auxiliar1.Fecha, #Auxiliar1.FechaVencimiento, #Auxiliar1.IdMoneda

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)
SET @vector_X='0111111888811133'
SET @vector_T='0099E44555538900'
SET @vector_E='  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  '

SELECT 
 #Auxiliar2.IdCtaCte,
 Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then #Auxiliar2.TipoComprobante Else 'CV' End as [Comp.],
 #Auxiliar2.IdTipoComprobante,
 #Auxiliar2.IdComprobante,
 Case 	When Facturas.NumeroFactura is not null
	 Then Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.TipoABC Else IsNull(Facturas.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.PuntoVenta Else IsNull(Facturas.CuentaVentaPuntoVenta,0) End)))+Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.PuntoVenta Else IsNull(Facturas.CuentaVentaPuntoVenta,0) End)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.NumeroFactura Else IsNull(Facturas.CuentaVentaNumero,0) End)))+Convert(varchar,Case When IsNull(Facturas.CuentaVentaNumero,0)=0 Then Facturas.NumeroFactura Else IsNull(Facturas.CuentaVentaNumero,0) End)
	When Devoluciones.NumeroDevolucion is not null
	 Then Devoluciones.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
	When NotasDebito.NumeroNotaDebito is not null
	 Then NotasDebito.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,NotasDebito.PuntoVenta)))+Convert(varchar,NotasDebito.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,NotasDebito.NumeroNotaDebito)))+Convert(varchar,NotasDebito.NumeroNotaDebito)
	When NotasCredito.NumeroNotaCredito is not null
	 Then Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.TipoABC Else IsNull(NotasCredito.CuentaVentaLetra COLLATE SQL_Latin1_General_CP1_CI_AS,'') End+'-'+
		Substring('0000',1,4-Len(Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.PuntoVenta Else IsNull(NotasCredito.CuentaVentaPuntoVenta,0) End)))+Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.PuntoVenta Else IsNull(NotasCredito.CuentaVentaPuntoVenta,0) End)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.NumeroNotaCredito Else IsNull(NotasCredito.CuentaVentaNumero,0) End)))+Convert(varchar,Case When IsNull(NotasCredito.CuentaVentaNumero,0)=0 Then NotasCredito.NumeroNotaCredito Else IsNull(NotasCredito.CuentaVentaNumero,0) End)
	When Recibos.NumeroRecibo is not null
	 Then Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo)
	Else Substring('0000000000',1,10-Len(Convert(varchar,#Auxiliar2.NumeroComprobante)))+Convert(varchar,#Auxiliar2.NumeroComprobante)
 End as [Numero],
 #Auxiliar2.Fecha,
 #Auxiliar2.FechaVencimiento as [Fecha vto.],
 #Auxiliar2.ImporteTotal as [Imp.orig.],
 Case When #Auxiliar2.ImporteTotal>=0 Then #Auxiliar2.ImporteTotal Else Null End as [Debe],
 Case When #Auxiliar2.ImporteTotal<0 Then #Auxiliar2.ImporteTotal * -1 Else Null End as [Haber],
 #Auxiliar2.ImporteTotal as [Saldo],
 Monedas.Abreviatura as [Mon.origen],
 IsNull(Facturas.Observaciones,IsNull(NotasDebito.Observaciones,NotasCredito.Observaciones)) as [Observaciones],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=#Auxiliar2.IdComprobante and #Auxiliar2.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=#Auxiliar2.IdComprobante and #Auxiliar2.IdTipoComprobante=@IdTipoComprobanteDevoluciones
LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=#Auxiliar2.IdComprobante and #Auxiliar2.IdTipoComprobante=@IdTipoComprobanteNotaDebito
LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=#Auxiliar2.IdComprobante and #Auxiliar2.IdTipoComprobante=@IdTipoComprobanteNotaCredito
LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=#Auxiliar2.IdComprobante and #Auxiliar2.IdTipoComprobante=@IdTipoComprobanteRecibo
LEFT OUTER JOIN Monedas ON #Auxiliar2.IdMoneda=Monedas.IdMoneda
ORDER By #Auxiliar2.Fecha, #Auxiliar2.NumeroComprobante

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2