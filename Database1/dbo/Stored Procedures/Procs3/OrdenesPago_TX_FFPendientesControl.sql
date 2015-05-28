




CREATE PROCEDURE [dbo].[OrdenesPago_TX_FFPendientesControl]

AS

SET NOCOUNT ON

Declare @IdMonedaPesos int
Set @IdMonedaPesos=(Select Top 1 Parametros.IdMoneda From Parametros 
			Where Parametros.IdParametro=1)

CREATE TABLE #Auxiliar1
			(
			 IdOrdenPago INTEGER,
			 IdOPComplementariaFF INTEGER,
			 K_Orden INTEGER,
			 K_NumeroOrdenPago INTEGER,
			 K_FechaOrdenPago DATETIME,
			 NumeroOrdenPago INTEGER,
			 FechaOrdenPago DATETIME,
			 Codigo INTEGER,
			 Cuenta VARCHAR(50),
			 Moneda VARCHAR(15),
			 TotalOrdenPago NUMERIC(18, 2),
			 CambioAPesos NUMERIC(18, 2),
			 TotalOrdenPagoPesos NUMERIC(18, 2),
			 NumeroOrdenPagoComplementaria INTEGER,
			 FechaOrdenPagoComplementaria DATETIME,
			 TotalOrdenPagoComplementaria NUMERIC(18, 2),
			 CambioAPesosComplementaria NUMERIC(18, 2),
			 TotalOrdenPagoPesosComplementaria NUMERIC(18, 2),
			 Comprobante VARCHAR(25),
			 FechaComprobante DATETIME,
			 Obra VARCHAR(13),
			 TotalComprobante NUMERIC(18, 2),
			 CambioAPesosComprobante NUMERIC(18, 2),
			 TotalComprobantePesos NUMERIC(18, 2),
			 DiferenciaCambio NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  op.IdOrdenPago, 
  op.IdOPComplementariaFF,
  1,
  op.NumeroOrdenPago, 
  op.FechaOrdenPago,
  op.NumeroOrdenPago, 
  op.FechaOrdenPago,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  Monedas.Abreviatura,
  op.Valores,
  op.CotizacionMoneda,
  op.Valores*op.CotizacionMoneda,
  Case When op.IdOPComplementariaFF is not null 
	Then (Select Top 1 OrdenesPago.NumeroOrdenPago From OrdenesPago
		Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF)
	Else Null 
  End,
  Case When op.IdOPComplementariaFF is not null 
	Then (Select Top 1 OrdenesPago.FechaOrdenPago From OrdenesPago
		Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF)
	Else Null 
  End,
  Case When op.IdOPComplementariaFF is not null 
	Then (Select Top 1 OrdenesPago.Valores From OrdenesPago
		Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF)
	Else Null 
  End,
  Case When op.IdOPComplementariaFF is not null 
	Then (Select Top 1 OrdenesPago.CotizacionMoneda From OrdenesPago
		Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF)
	Else Null 
  End,
  Case When op.IdOPComplementariaFF is not null 
	Then (Select Top 1 OrdenesPago.Valores*OrdenesPago.CotizacionMoneda 
		From OrdenesPago Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF)
	Else Null 
  End,
  Null,
  Null,
  Null,
  Null,
  Null,
  0,
  0
 FROM OrdenesPago op
 LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
 LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
 WHERE op.Tipo='FF'and op.IdMoneda<>@IdMonedaPesos and 
	(op.Anulada is null or op.Anulada<>'SI') and 
	(op.IdOPComplementariaFF is null or op.IdOrdenPago-op.IdOPComplementariaFF<0) and
	(op.Confirmado is null or op.Confirmado<>'NO')
 ORDER By op.FechaOrdenPago,op.NumeroOrdenPago
 

UPDATE #Auxiliar1
SET TotalOrdenPagoPesos=0 
WHERE TotalOrdenPagoPesos IS NULL

UPDATE #Auxiliar1
SET TotalOrdenPagoPesosComplementaria=0 
WHERE TotalOrdenPagoPesosComplementaria IS NULL


CREATE TABLE #Auxiliar2	(
			 IdOrdenPago INTEGER,
			 IdOPComplementariaFF INTEGER,
			 K_Orden INTEGER,
			 K_NumeroOrdenPago INTEGER,
			 K_FechaOrdenPago DATETIME,
			 NumeroOrdenPago INTEGER,
			 FechaOrdenPago DATETIME,
			 Codigo INTEGER,
			 Cuenta VARCHAR(50),
			 Moneda VARCHAR(15),
			 TotalOrdenPago NUMERIC(18, 2),
			 CambioAPesos NUMERIC(18, 2),
			 TotalOrdenPagoPesos NUMERIC(18, 2),
			 NumeroOrdenPagoComplementaria INTEGER,
			 FechaOrdenPagoComplementaria DATETIME,
			 TotalOrdenPagoComplementaria NUMERIC(18, 2),
			 CambioAPesosComplementaria NUMERIC(18, 2),
			 TotalOrdenPagoPesosComplementaria NUMERIC(18, 2),
			 Comprobante VARCHAR(25),
			 FechaComprobante DATETIME,
			 Obra VARCHAR(13),
			 TotalComprobante NUMERIC(18, 2),
			 CambioAPesosComprobante NUMERIC(18, 2),
			 TotalComprobantePesos NUMERIC(18, 2),
			 DiferenciaCambio NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  cp.IdOrdenPago,
  Null,
  2,
  #Auxiliar1.NumeroOrdenPago,
  #Auxiliar1.FechaOrdenPago,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  0,
  Null,
  Null,
  Null,
  Null,
  0,
  Substring(
	tc.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2),1,25),
  cp.FechaComprobante,
  Obras.NumeroObra,
  Case When cp.CotizacionDolar<>0 
	Then cp.TotalComprobante*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)
	Else 0
  End,
  Case When cp.CotizacionDolar<>0 Then cp.CotizacionMoneda Else 0 End,
  cp.TotalComprobante*cp.CotizacionMoneda*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente),
  0
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Obras ON cp.IdObra = Obras.IdObra
 LEFT OUTER JOIN #Auxiliar1 ON cp.IdOrdenPago = #Auxiliar1.IdOrdenPago
 WHERE cp.IdProveedor is null and #Auxiliar1.IdOrdenPago is not null

 UNION ALL

 SELECT 
  #Auxiliar1.IdOrdenPago,
  Null,
  2,
  #Auxiliar1.NumeroOrdenPago,
  #Auxiliar1.FechaOrdenPago,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  Null,
  0,
  Null,
  Null,
  Null,
  Null,
  0,
  Substring(
	tc.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2),1,25),
  cp.FechaComprobante,
  Obras.NumeroObra,
  Case When cp.CotizacionDolar<>0 
	Then cp.TotalComprobante*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente)
	Else 0
  End,
  Case When cp.CotizacionDolar<>0 Then cp.CotizacionMoneda Else 0 End,
  cp.TotalComprobante*cp.CotizacionMoneda*Isnull(tc.CoeficienteParaFondoFijo,tc.Coeficiente),
  0
 FROM ComprobantesProveedores cp
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 LEFT OUTER JOIN Obras ON cp.IdObra = Obras.IdObra
 LEFT OUTER JOIN #Auxiliar1 ON cp.IdOrdenPago = #Auxiliar1.IdOPComplementariaFF
 WHERE cp.IdProveedor is null and #Auxiliar1.IdOPComplementariaFF is not null 

INSERT INTO #Auxiliar1 
 SELECT *
 FROM #Auxiliar2

UPDATE #Auxiliar1
SET DiferenciaCambio=(TotalOrdenPagoPesos+TotalOrdenPagoPesosComplementaria)-TotalComprobantePesos


SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='000001111111111111111111133'
Set @vector_T='000005555555555555555555500'

SELECT 
 IdOrdenPago as [IdAux],
 IdOPComplementariaFF as [IdAuxComp],
 K_Orden as [K_Orden],
 K_FechaOrdenPago as [K_FechaOrdenPago],
 K_NumeroOrdenPago as [K_NumeroOrdenPago],
 NumeroOrdenPago as [O.Pago],
 FechaOrdenPago as [Fecha OP],
 Codigo as [Cod.Cta.],
 Cuenta as [Cuenta],
 Moneda as [Mon.],
 TotalOrdenPago as [Total O.Pago],
 CambioAPesos as [Cambio],
 Case When TotalOrdenPagoPesos<>0
	Then TotalOrdenPagoPesos
	Else Null 
 End as [Total O.Pago $],
 NumeroOrdenPagoComplementaria as [O.Pago (Comp.)],
 FechaOrdenPagoComplementaria as [Fecha OP (Comp.)],
 TotalOrdenPagoComplementaria as [Total OP (Comp.)],
 CambioAPesosComplementaria as [Cambio (Comp.)],
 Case When TotalOrdenPagoPesosComplementaria<>0
	Then TotalOrdenPagoPesosComplementaria
	Else Null 
 End as [Total OP (Comp.) $],
 Comprobante as [Comprobante],
 FechaComprobante as [Fecha Comp.],
 Obra as [Obra],
 TotalComprobante as [Total Comp.],
 CambioAPesosComprobante as [Cambio],
 Case When TotalComprobantePesos<>0
	Then TotalComprobantePesos
	Else Null 
 End as [Total Comp. $],
 Null as [Dif.Cambio],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1

UNION ALL

SELECT 
 IdOrdenPago as [IdAux],
 Null as [IdAuxComp],
 3 as [K_Orden],
 K_FechaOrdenPago as [K_FechaOrdenPago],
 K_NumeroOrdenPago as [K_NumeroOrdenPago],
 Null as [O.Pago],
 Null as [Fecha OP],
 Null as [Cod.Cta.],
 'TOTAL FONDO FIJO '+Convert(varchar,K_NumeroOrdenPago) as [Cuenta],
 Null as [Mon.],
 Null as [Total O.Pago],
 Null as [Cambio],
 Sum(TotalOrdenPagoPesos) as [Total O.Pago $],
 Null as [O.Pago (Comp.)],
 Null as [Fecha OP (Comp.)],
 Null as [Total OP (Comp.)],
 Null as [Cambio (Comp.)],
 Sum(TotalOrdenPagoPesosComplementaria) as [Total OP (Comp.) $],
 Null as [Comprobante],
 Null as [Fecha Comp.],
 Null as [Obra],
 Null as [Total Comp.],
 Null as [Cambio],
 Sum(TotalComprobantePesos) as [Total Comp. $],
 Sum(DiferenciaCambio) as [Dif.Cambio],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdOrdenPago,K_FechaOrdenPago,K_NumeroOrdenPago

UNION ALL

SELECT 
 IdOrdenPago as [IdAux],
 Null as [IdAuxComp],
 4 as [K_Orden],
 K_FechaOrdenPago as [K_FechaOrdenPago],
 K_NumeroOrdenPago as [K_NumeroOrdenPago],
 Null as [O.Pago],
 Null as [Fecha OP],
 Null as [Cod.Cta.],
 Null as [Cuenta],
 Null as [Mon.],
 Null as [Total O.Pago],
 Null as [Cambio],
 Null as [Total O.Pago $],
 Null as [O.Pago (Comp.)],
 Null as [Fecha OP (Comp.)],
 Null as [Total OP (Comp.)],
 Null as [Cambio (Comp.)],
 Null as [Total OP (Comp.) $],
 Null as [Comprobante],
 Null as [Fecha Comp.],
 Null as [Obra],
 Null as [Total Comp.],
 Null as [Cambio],
 Null as [Total Comp. $],
 Null as [Dif.Cambio],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
GROUP BY IdOrdenPago,K_FechaOrdenPago,K_NumeroOrdenPago

ORDER BY [K_FechaOrdenPago],[K_NumeroOrdenPago],[K_Orden]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2




