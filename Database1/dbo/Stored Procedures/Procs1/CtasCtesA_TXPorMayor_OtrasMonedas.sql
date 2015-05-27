
CREATE Procedure [dbo].[CtasCtesA_TXPorMayor_OtrasMonedas]

@IdProveedor int,
@Todo int,
@FechaLimite datetime,
@IdMoneda int,
@FechaDesde datetime = Null

AS

SET NOCOUNT ON

SET @FechaDesde=IsNull(@FechaDesde,Convert(datetime,'1/1/2000'))

DECLARE @IdTipoComprobanteOrdenPago int, @SaldoInicial numeric(18,2)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago
					From Parametros Where Parametros.IdParametro=1)
IF @Todo=-1
	SET @SaldoInicial=0
ELSE
	SET @SaldoInicial=IsNull((Select Sum(IsNull(CtaCte.ImporteTotal,0) * IsNull(tc.Coeficiente,1))
				  From CuentasCorrientesAcreedores CtaCte
				  Left Outer Join TiposComprobante tc On tc.IdTipoComprobante=CtaCte.IdTipoComp
				  Where CtaCte.IdProveedor=@IdProveedor and CtaCte.Fecha<@FechaDesde),0)

CREATE TABLE #Auxiliar1
			(
			 IdCtaCte INTEGER,
			 IdProveedor INTEGER,
			 IdTipoComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdComprobante INTEGER,
			 NumeroComprobante VARCHAR(15),
			 Referencia INTEGER,
			 Fecha DATETIME,
			 ImporteTotal NUMERIC(18,2)
			)
IF @Todo<>-1
	INSERT INTO #Auxiliar1 
	 SELECT 0, @IdProveedor, 0, 'INI', 0, ' AL '+Convert(varchar,@FechaDesde,103), 
		0, @FechaDesde, @SaldoInicial

INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  Case When CtaCte.IdTipoComp=16 Then @IdTipoComprobanteOrdenPago Else CtaCte.IdTipoComp End,
  TiposComprobante.DescripcionAB,
  CtaCte.IdComprobante,
  Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16 or 
		cp.IdComprobanteProveedor is null
	Then Substring(Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+
		Convert(varchar,CtaCte.NumeroComprobante),1,15)
	Else Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2),1,15)
  End,
  CtaCte.NumeroComprobante,
  CtaCte.Fecha,
  CtaCte.ImporteTotal * TiposComprobante.Coeficiente
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante
 WHERE CtaCte.IdProveedor=@IdProveedor and (@Todo=-1 or CtaCte.Fecha<=@FechaLimite)

UPDATE #Auxiliar1
SET NumeroComprobante='00000000'
WHERE NumeroComprobante IS NULL

CREATE TABLE #Auxiliar2
			(
			 IdCtaCte INTEGER,
			 IdTipoComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdComprobante INTEGER,
			 NumeroComprobante VARCHAR(15),
			 Referencia INTEGER,
			 Fecha DATETIME,
			 ImporteTotal NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  MAX(#Auxiliar1.IdCtaCte),
  #Auxiliar1.IdTipoComprobante,
  MAX(#Auxiliar1.TipoComprobante),
  #Auxiliar1.IdComprobante,
  #Auxiliar1.NumeroComprobante,
  MAX(#Auxiliar1.Referencia),
  MAX(#Auxiliar1.Fecha),
  SUM(#Auxiliar1.ImporteTotal)
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.IdTipoComprobante,#Auxiliar1.IdComprobante,#Auxiliar1.NumeroComprobante

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
 LEFT OUTER JOIN CuentasCorrientesAcreedores CtaCte ON CtaCte.IdCtaCte=#Auxiliar2.IdCtaCte

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(1000)
Set @vector_X='01111118888151133'
Set @vector_T='00997144444455900'
Set @vector_E='  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  '

SELECT 
 #Auxiliar2.IdCtaCte,
 #Auxiliar2.TipoComprobante as [Comp.],
 #Auxiliar2.IdTipoComprobante,
 #Auxiliar2.IdComprobante,
 #Auxiliar2.NumeroComprobante as [Numero],
 #Auxiliar2.Referencia as [Ref.],
 #Auxiliar2.Fecha,
 Case When #Auxiliar3.A_Cotizacion is not null and #Auxiliar3.A_Cotizacion<>0 
	Then Convert(Numeric(18, 2),#Auxiliar2.ImporteTotal * -1 / #Auxiliar3.A_Cotizacion)
	Else Null
 End as [Imp.orig.],
 Case When #Auxiliar2.ImporteTotal<0 and 
		#Auxiliar3.A_Cotizacion is not null and #Auxiliar3.A_Cotizacion<>0 
	Then Convert(Numeric(18, 2),#Auxiliar2.ImporteTotal * -1 / #Auxiliar3.A_Cotizacion)
	Else Null
 End as [Debe],
 Case When #Auxiliar2.ImporteTotal>=0 and 
		#Auxiliar3.A_Cotizacion is not null and #Auxiliar3.A_Cotizacion<>0 
	Then Convert(Numeric(18, 2),#Auxiliar2.ImporteTotal / #Auxiliar3.A_Cotizacion)
	Else Null
 End as [Haber],
 #Auxiliar2.ImporteTotal as [Sdo],
 Case When #Auxiliar2.IdTipoComprobante=@IdTipoComprobanteOrdenPago or #Auxiliar2.IdTipoComprobante=16
	Then Null
	Else cp.FechaComprobante 
 End as [Fecha cmp.],
 Case When #Auxiliar2.IdTipoComprobante=@IdTipoComprobanteOrdenPago 
	Then IsNull(Convert(varchar(1000),OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS),'')
	Else IsNull(Convert(varchar(1000),cp.Observaciones),'')
 End as [Observaciones],
 #Auxiliar3.A_Cotizacion as [CotizacionOtrasMonedas],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.A_IdCtaCte=#Auxiliar2.IdCtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=#Auxiliar2.IdTipoComprobante
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.IdComprobante and 
			#Auxiliar2.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and #Auxiliar2.IdTipoComprobante<>16
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar2.IdComprobante and 
			(#Auxiliar2.IdTipoComprobante=@IdTipoComprobanteOrdenPago or #Auxiliar2.IdTipoComprobante=16)
ORDER By #Auxiliar2.Fecha, #Auxiliar2.NumeroComprobante

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
