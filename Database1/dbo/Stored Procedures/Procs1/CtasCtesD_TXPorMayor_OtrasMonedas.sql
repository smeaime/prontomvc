
CREATE Procedure [dbo].[CtasCtesD_TXPorMayor_OtrasMonedas]

@IdCliente int,
@Todo int,
@FechaLimite datetime,
@IdMoneda int,
@FechaDesde datetime = Null

AS

SET NOCOUNT ON

SET @FechaDesde=IsNull(@FechaDesde,Convert(datetime,'1/1/2000'))

DECLARE @IdTipoComprobanteFacturaVenta int,@IdTipoComprobanteDevoluciones int,
	@IdTipoComprobanteNotaDebito int,@IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int, @SaldoInicial numeric(18,2)

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
			 ImporteTotal NUMERIC(18,2)
			)
IF @Todo<>-1
	INSERT INTO #Auxiliar1 
	 SELECT 0, 0, 'INI', 0, 0, @FechaDesde, Null, @SaldoInicial

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
  CtaCte.ImporteTotal * TiposComprobante.Coeficiente
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante
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
			 ImporteTotal NUMERIC(18,2)
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
  SUM(#Auxiliar1.ImporteTotal)
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.IdTipoComprobante, #Auxiliar1.IdComprobante, #Auxiliar1.NumeroComprobante, 
	#Auxiliar1.Fecha, #Auxiliar1.FechaVencimiento

CREATE TABLE #Auxiliar3
			(
			   A_IdCtaCte INTEGER,
			   A_CotizacionMoneda NUMERIC(18, 4),
			   A_Cotizacion NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.IdCtaCte,
  Case When CtaCte.CotizacionMoneda is Null Then 1 Else CtaCte.CotizacionMoneda End,
  (Select Top 1 Cotizaciones.CotizacionLibre From Cotizaciones
   Where Cotizaciones.Fecha=#Auxiliar2.Fecha And Cotizaciones.IdMoneda=@IdMoneda)
 FROM #Auxiliar2
 LEFT OUTER JOIN CuentasCorrientesDeudores CtaCte ON CtaCte.IdCtaCte=#Auxiliar2.IdCtaCte

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)
SET @vector_X='011111188881133'
SET @vector_T='009934455559900'
SET @vector_E='  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 '

SELECT 
 #Auxiliar2.IdCtaCte,
 #Auxiliar2.TipoComprobante as [Comp.],
 #Auxiliar2.IdTipoComprobante,
 #Auxiliar2.IdComprobante,
 #Auxiliar2.NumeroComprobante as [Numero],
 #Auxiliar2.Fecha,
 #Auxiliar2.FechaVencimiento as [Fecha vto.],
 Case When #Auxiliar3.A_Cotizacion is not null and #Auxiliar3.A_Cotizacion<>0 
	Then Convert(Numeric(18, 2),#Auxiliar2.ImporteTotal / #Auxiliar3.A_Cotizacion)
	Else Null
 End as [Imp.orig.],
 Case When #Auxiliar2.ImporteTotal>=0 and 
		#Auxiliar3.A_Cotizacion is not null and #Auxiliar3.A_Cotizacion<>0 
	Then Convert(Numeric(18, 2),#Auxiliar2.ImporteTotal / #Auxiliar3.A_Cotizacion)
	Else Null
 End as [Debe],
 Case When #Auxiliar2.ImporteTotal<0 and 
		#Auxiliar3.A_Cotizacion is not null and #Auxiliar3.A_Cotizacion<>0 
	Then Convert(Numeric(18, 2),#Auxiliar2.ImporteTotal * -1 / #Auxiliar3.A_Cotizacion)
	Else Null
 End as [Haber],
 #Auxiliar2.ImporteTotal as [Saldo],
 #Auxiliar3.A_Cotizacion as [CotizacionOtrasMonedas],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.A_IdCtaCte=#Auxiliar2.IdCtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=#Auxiliar2.IdTipoComprobante
ORDER By #Auxiliar2.Fecha, #Auxiliar2.NumeroComprobante

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
