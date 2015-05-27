
CREATE PROCEDURE [dbo].[InformesContables_TX_SubdiarioProveedores]

@FechaDesde datetime,
@FechaHasta datetime,
@IdCuentasAdicionalesImpuestosInternos varchar(1000)

AS

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdCuentaImpuestosInternos int, @IdCtaAdicCol1 int,
	@IdCtaAdicCol2 int,@IdCtaAdicCol3 int,@IdCtaAdicCol4 int,@IdCtaAdicCol5 int

SET @IdCtaAdicCol1=IsNull((Select Parametros.IdCuentaAdicionalIVACompras1
			   From Parametros Where Parametros.IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select Parametros.IdCuentaAdicionalIVACompras2
			   From Parametros Where Parametros.IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select Parametros.IdCuentaAdicionalIVACompras3
			   From Parametros Where Parametros.IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select Parametros.IdCuentaAdicionalIVACompras4
			   From Parametros Where Parametros.IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select Parametros.IdCuentaAdicionalIVACompras5
			   From Parametros Where Parametros.IdParametro=1),0)
SET @IdTipoCuentaGrupoIVA=IsNull((Select Parametros.IdTipoCuentaGrupoIVA
				  From Parametros Where Parametros.IdParametro=1),0)
SET @IdCuentaImpuestosInternos=IsNull((Select Parametros.IdCuentaImpuestosInternos
					From Parametros Where Parametros.IdParametro=1),0)

CREATE TABLE #Auxiliar0	(IdCuenta INTEGER, IdCuentaMadre INTEGER)
INSERT INTO #Auxiliar0 
 SELECT Cuentas.IdCuenta, Null
 FROM Cuentas 
 WHERE Cuentas.IdCuenta=@IdCuentaImpuestosInternos or 
	Patindex('%('+Convert(varchar,Cuentas.IdCuenta)+')%', @IdCuentasAdicionalesImpuestosInternos)<>0
INSERT INTO #Auxiliar0 
 SELECT Cuentas.IdCuenta, IsNull(CuentasGastos.IdCuentaMadre,-1)
 FROM Cuentas 
 LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto
 WHERE IsNull(CuentasGastos.IdCuentaMadre,-1)=@IdCuentaImpuestosInternos or 
	Patindex('%('+Convert(varchar,IsNull(CuentasGastos.IdCuentaMadre,-1))+')%', 
			@IdCuentasAdicionalesImpuestosInternos)<>0


CREATE TABLE #Auxiliar1
			(
			 A_IdComprobante INTEGER,
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	dcp.IdComprobanteProveedor,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			not dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0) 
			--and IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva)=1
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3)
				 Else 0 
			End
		Else 0
	End,
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta In (Select #Auxiliar0.IdCuenta From #Auxiliar0) 
			--and IsNull(cp.IdCodigoIva,Proveedores.IdCodigoIva)=1 
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then Round(dcp.Importe*cp.CotizacionMoneda,3) 
				 Else 0 
			End
		Else 0
	End,
	0,
	0,
	0
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and IsNull(cp.Confirmado,'SI')='SI'

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje1,
	Round(dcp.ImporteIVA1*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA1<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje2,
	Round(dcp.ImporteIVA2*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA2<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje3,
	Round(dcp.ImporteIVA3*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA3<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje4,
	Round(dcp.ImporteIVA4*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA4<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje5,
	Round(dcp.ImporteIVA5*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA5<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje6,
	Round(dcp.ImporteIVA6*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA6<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje7,
	Round(dcp.ImporteIVA7*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA7<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje8,
	Round(dcp.ImporteIVA8*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA8<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje9,
	Round(dcp.ImporteIVA9*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA9<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	Round(dcp.Importe*cp.CotizacionMoneda,3),
	dcp.IVAComprasPorcentaje10,
	Round(dcp.ImporteIVA10*cp.CotizacionMoneda,4)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	dcp.ImporteIVA10<>0

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	0,
	Case When dcp.IVAComprasPorcentajeDirecto is not null 
		Then dcp.IVAComprasPorcentajeDirecto
		Else 0
	End,
	Round(dcp.Importe*cp.CotizacionMoneda,3)
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	(Cuentas.IdTipoCuentaGrupo is not null and Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA)

 UNION ALL

 SELECT 
	dcp.IdComprobanteProveedor,
	0,
	0,
	0,
	IsNull(dcp.IVAComprasPorcentajeDirecto,0),
	0
 FROM DetalleComprobantesProveedores dcp 
 LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
 LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	(Cuentas.IdTipoCuentaGrupo is not null and Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupoIVA) and 
	IsNull(dcp.IVAComprasPorcentajeDirecto,0)<>0 

 UNION ALL

 SELECT 
	cp.IdComprobanteProveedor,
	0,
	0,
	0,
	Case When cp.PorcentajeIVAAplicacionAjuste is not null 
		Then cp.PorcentajeIVAAplicacionAjuste
		Else 0
	End,
	Round(cp.AjusteIVA*cp.CotizacionMoneda,3)
 FROM ComprobantesProveedores cp 
 WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and IsNull(cp.Confirmado,'SI')='SI' and 
	IsNull(cp.AjusteIVA,0)<>0 


CREATE TABLE #Auxiliar2
			(
			 A_IdComprobante INTEGER,
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_Tasa NUMERIC(6, 2),
			 A_IVA NUMERIC(18, 4),
			 A_IdValor INTEGER,
			 A_IdOrdenPago INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT A_IdComprobante, Sum(IsNull(A_NetoNoGravado,0)), Sum(IsNull(A_NetoNoGravadoImpInt,0)), 
	Sum(IsNull(A_NetoGravado,0)), A_Tasa, Sum(IsNull(A_IVA,0)), 0, 0
 FROM #Auxiliar1
 WHERE IsNull(A_NetoNoGravado,0)<>0 or IsNull(A_NetoNoGravadoImpInt,0)<>0 or 
	IsNull(A_NetoGravado,0)<>0 or IsNull(A_IVA,0)<>0 
 GROUP BY A_IdComprobante, A_Tasa
UNION ALL
 SELECT 0, 0, 0, (V.Importe-V.Iva) * tc.Coeficiente * IsNull(V.CotizacionMoneda,1) * -1, 
	IsNull(V.PorcentajeIva,0), V.Iva * tc.Coeficiente * IsNull(V.CotizacionMoneda,1) * -1, V.IdValor, 0
 FROM Valores V
 LEFT OUTER JOIN TiposComprobante tc ON V.IdTipoComprobante=tc.IdTipoComprobante
 WHERE (V.FechaComprobante between @FechaDesde and @FechaHasta) and IsNull(V.Anulado,'NO')<>'SI' and 
	((V.IdTipoComprobante=28 or V.IdTipoComprobante=29 or 
	  V.IdTipoComprobante=44 or V.IdTipoComprobante=45) and IsNull(V.Iva,0)<>0)  
UNION ALL
 SELECT 0, 0, 0, 0, 0, (IsNull(dopc.Debe,0)-IsNull(dopc.Haber,0)) * IsNull(OrdenesPago.CotizacionMoneda,1), 
	0, dopc.IdOrdenPago
 FROM DetalleOrdenesPagoCuentas dopc 
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopc.IdOrdenPago
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=OrdenesPago.IdProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=dopc.IdCuenta
 WHERE OrdenesPago.FechaOrdenPago between @FechaDesde and DATEADD(n,1439,@FechaHasta) and 
	(IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol1 or IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol2 or 
	 IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol3 or IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol4 or 
	 IsNull(dopc.IdCuenta,-1)=@IdCtaAdicCol5 ) and 
	IsNull(dopc.Haber,0)<>0

CREATE TABLE #Auxiliar3 
			(
			 A_IdComprobante INTEGER,  
			 A_NetoNoGravado NUMERIC(18, 3),
			 A_NetoNoGravadoImpInt NUMERIC(18, 3),
			 A_NetoGravado NUMERIC(18, 3),
			 A_IVA NUMERIC(18, 4),
			 A_IdValor INTEGER,
			 A_IdOrdenPago INTEGER
			)
INSERT INTO #Auxiliar3 
 SELECT A_IdComprobante, Sum(IsNull(A_NetoNoGravado,0)), Sum(IsNull(A_NetoNoGravadoImpInt,0)), 
	Sum(IsNull(A_NetoGravado,0)), Sum(IsNull(A_IVA,0)), A_IdValor, A_IdOrdenPago
 FROM #Auxiliar2
 GROUP BY A_IdComprobante, A_IdValor, A_IdOrdenPago

SET NOCOUNT OFF

Declare @vector_X varchar(40),@vector_T varchar(40),@vector_E varchar(500)
Set @vector_X='000000111116166133'
Set @vector_T='00000041F030033900'
Set @vector_E='  '

SELECT DISTINCT 
 0 as [IdAux1],
 0 as [IdAux2],
 IsNull(cp.FechaRecepcion,IsNull(Valores.FechaComprobante,OrdenesPago.FechaOrdenPago)) as [IdAux3],
 '' as [IdAux4],
 1 as [IdAux5],
 0 as [IdAux6],
 IsNull(cp.FechaRecepcion,IsNull(Valores.FechaComprobante,OrdenesPago.FechaOrdenPago)) as [Fecha],
 Null as [Cod.Com.],
 Null as [N.Comprobante],
 Null as [Proveed],
 Null as [Razon Social],
 Null as [Tasa IVA],
 Null as [Nro.CUIT], 
 Null as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 ' FEC |  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar3.A_IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar3.A_IdOrdenPago
LEFT OUTER JOIN Valores ON Valores.IdValor=#Auxiliar3.A_IdValor
GROUP BY cp.FechaRecepcion, Valores.FechaComprobante, OrdenesPago.FechaOrdenPago

UNION ALL

SELECT 
 Case When IsNull(#Auxiliar3.A_IdComprobante,0)>0 Then #Auxiliar3.A_IdComprobante
	When IsNull(#Auxiliar3.A_IdValor,0)>0 Then #Auxiliar3.A_IdValor
	Else #Auxiliar3.A_IdOrdenPago
 End as [IdAux1],
 0 as [IdAux2],
 IsNull(cp.FechaRecepcion,IsNull(Valores.FechaComprobante,OrdenesPago.FechaOrdenPago)) as [IdAux3],
 Case When IsNull(#Auxiliar3.A_IdValor,0)>0 
	Then tc.DescripcionAb+' '+Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+
					Convert(varchar,Valores.NumeroComprobante)
	When IsNull(#Auxiliar3.A_IdOrdenPago,0)>0 
	Then 'OP '+Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
			Convert(varchar,OrdenesPago.NumeroOrdenPago)
	Else tc.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
			Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
			Convert(varchar,cp.NumeroComprobante2) 
 End as [IdAux4],
 2 as [IdAux5],
 IsNull(P1.IdProveedor,P2.IdProveedor) as [IdAux6],
 Null as [Fecha],
 tc.DescripcionAb as [Cod.Com.],
 Case When IsNull(#Auxiliar3.A_IdValor,0)>0 
	Then Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+
		Convert(varchar,Valores.NumeroComprobante)
	When IsNull(#Auxiliar3.A_IdOrdenPago,0)>0 
	Then Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
		Convert(varchar,OrdenesPago.NumeroOrdenPago)
	Else cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
				Convert(varchar,cp.NumeroComprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
				Convert(varchar,cp.NumeroComprobante2) 
 End as [N.Comprobante],
 IsNull(P1.CodigoEmpresa,P2.CodigoEmpresa) as [Proveed],
 Case When IsNull(cp.IdTipoComprobante,0)=43 Then IsNull(C1.Descripcion,P2.RazonSocial)
	Else IsNull(P1.RazonSocial,IsNull(P2.RazonSocial,IsNull(C1.Descripcion,Bancos.Nombre))) 
 End as [Razon Social],
 Null as [Tasa IVA],
 IsNull(P1.Cuit,P2.Cuit) as [Nro.CUIT], 
 Null as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 ' FEC |  |  |  |  |  |  |  |  |  ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar3.A_IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar3.A_IdOrdenPago
LEFT OUTER JOIN Proveedores P1 ON IsNull(cp.IdProveedor,OrdenesPago.IdProveedor)=P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor
LEFT OUTER JOIN Cuentas C1 ON IsNull(cp.IdCuenta,cp.IdCuentaOtros) = C1.IdCuenta
LEFT OUTER JOIN Valores ON Valores.IdValor=#Auxiliar3.A_IdValor
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TiposComprobante tc ON IsNull(cp.IdTipoComprobante,IsNull(Valores.IdTipoComprobante,0))=tc.IdTipoComprobante

UNION ALL

SELECT 
 Case When IsNull(#Auxiliar2.A_IdComprobante,0)>0 Then #Auxiliar2.A_IdComprobante
	When IsNull(#Auxiliar2.A_IdValor,0)>0 Then #Auxiliar2.A_IdValor
	Else #Auxiliar2.A_IdOrdenPago
 End as [IdAux1],
 0 as [IdAux2],
 IsNull(cp.FechaRecepcion,IsNull(Valores.FechaComprobante,OrdenesPago.FechaOrdenPago)) as [IdAux3],
 Case When IsNull(#Auxiliar2.A_IdValor,0)>0 
	Then tc.DescripcionAb+' '+Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+
					Convert(varchar,Valores.NumeroComprobante)
	When IsNull(#Auxiliar2.A_IdOrdenPago,0)>0 
	Then 'OP '+Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
			Convert(varchar,OrdenesPago.NumeroOrdenPago)
	Else tc.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
			Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
			Convert(varchar,cp.NumeroComprobante2) 
 End as [IdAux4],
 3 as [IdAux5],
 IsNull(P1.IdProveedor,P2.IdProveedor) as [IdAux6],
 Null as [Fecha],
 Null as [Cod.Com.],
 Null as [N.Comprobante],
 Null as [Proveed],
 Convert(varchar,#Auxiliar2.A_NetoGravado * IsNull(tc.Coeficiente,1)) as [Razon Social],
 #Auxiliar2.A_Tasa as [Tasa IVA],
 Convert(varchar,#Auxiliar2.A_IVA * IsNull(tc.Coeficiente,1)) as [Nro.CUIT], 
 #Auxiliar2.A_NetoNoGravado * IsNull(tc.Coeficiente,1) as [Imp.Exentos],
 #Auxiliar2.A_NetoNoGravadoImpInt * IsNull(tc.Coeficiente,1) as [Imp.mp.Int.],
 '  |  |  |  | RIG,NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 |'+
	' NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.A_IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar2.A_IdOrdenPago
LEFT OUTER JOIN Valores ON Valores.IdValor=#Auxiliar2.A_IdValor
LEFT OUTER JOIN TiposComprobante tc ON IsNull(cp.IdTipoComprobante,IsNull(Valores.IdTipoComprobante,0))=tc.IdTipoComprobante
LEFT OUTER JOIN Proveedores P1 ON IsNull(cp.IdProveedor,OrdenesPago.IdProveedor)=P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor

UNION ALL

SELECT 
 Case When IsNull(#Auxiliar3.A_IdComprobante,0)>0 Then #Auxiliar3.A_IdComprobante
	When IsNull(#Auxiliar3.A_IdValor,0)>0 Then #Auxiliar3.A_IdValor
	Else #Auxiliar3.A_IdOrdenPago
 End as [IdAux1],
 0 as [IdAux2],
 IsNull(cp.FechaRecepcion,IsNull(Valores.FechaComprobante,OrdenesPago.FechaOrdenPago)) as [IdAux3],
 Case When IsNull(#Auxiliar3.A_IdValor,0)>0 
	Then tc.DescripcionAb+' '+Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+
					Convert(varchar,Valores.NumeroComprobante)
	When IsNull(#Auxiliar3.A_IdOrdenPago,0)>0 
	Then 'OP '+Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
			Convert(varchar,OrdenesPago.NumeroOrdenPago)
	Else tc.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
			Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
			Convert(varchar,cp.NumeroComprobante2) 
 End as [IdAux4],
 4 as [IdAux5],
 IsNull(P1.IdProveedor,P2.IdProveedor) as [IdAux6],
 Null as [Fecha],
 Null as [Cod.Com.],
 'Tot.Comp.' as [N.Comprobante],
 Convert(varchar,(#Auxiliar3.A_NetoGravado + #Auxiliar3.A_IVA + #Auxiliar3.A_NetoNoGravado + 
		  #Auxiliar3.A_NetoNoGravadoImpInt) * IsNull(tc.Coeficiente,1)) as [Proveed],
 Convert(varchar,#Auxiliar3.A_NetoGravado * IsNull(tc.Coeficiente,1)) as [Razon Social],
 Null as [Tasa IVA],
 Convert(varchar,#Auxiliar3.A_IVA * IsNull(tc.Coeficiente,1)) as [Nro.CUIT], 
 #Auxiliar3.A_NetoNoGravado * IsNull(tc.Coeficiente,1) as [Imp.Exentos],
 #Auxiliar3.A_NetoNoGravadoImpInt * IsNull(tc.Coeficiente,1) as [Imp.mp.Int.],
 '  |  |  | RIG,NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 |'+
	' NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar3.A_IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar3.A_IdOrdenPago
LEFT OUTER JOIN Valores ON Valores.IdValor=#Auxiliar3.A_IdValor
LEFT OUTER JOIN TiposComprobante tc ON IsNull(cp.IdTipoComprobante,IsNull(Valores.IdTipoComprobante,0))=tc.IdTipoComprobante
LEFT OUTER JOIN Proveedores P1 ON IsNull(cp.IdProveedor,OrdenesPago.IdProveedor)=P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor

UNION ALL

SELECT 
 Case When IsNull(#Auxiliar2.A_IdComprobante,0)>0 Then #Auxiliar2.A_IdComprobante
	When IsNull(#Auxiliar2.A_IdValor,0)>0 Then #Auxiliar2.A_IdValor
	Else #Auxiliar2.A_IdOrdenPago
 End as [IdAux1],
 0 as [IdAux2],
 IsNull(cp.FechaRecepcion,IsNull(Valores.FechaComprobante,OrdenesPago.FechaOrdenPago)) as [IdAux3],
 Case When IsNull(#Auxiliar2.A_IdValor,0)>0 
	Then tc.DescripcionAb+' '+Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+
					Convert(varchar,Valores.NumeroComprobante)
	When IsNull(#Auxiliar2.A_IdOrdenPago,0)>0 
	Then 'OP '+Substring('0000000000',1,10-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+
			Convert(varchar,OrdenesPago.NumeroOrdenPago)
	Else tc.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
			Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
			Convert(varchar,cp.NumeroComprobante2) 
 End as [IdAux4],
 5 as [IdAux5],
 IsNull(P1.IdProveedor,P2.IdProveedor) as [IdAux6],
 Null as [Fecha],
 Null as [Cod.Com.],
 Null as [N.Comprobante],
 Null as [Proveed],
 Null as [Razon Social],
 Null as [Tasa IVA],
 Null as [Nro.CUIT], 
 Null as [Imp.Exentos],
 Null as [Imp.mp.Int.],
 @vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.A_IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar2.A_IdOrdenPago
LEFT OUTER JOIN Valores ON Valores.IdValor=#Auxiliar2.A_IdValor
LEFT OUTER JOIN TiposComprobante tc ON IsNull(cp.IdTipoComprobante,IsNull(Valores.IdTipoComprobante,17))=tc.IdTipoComprobante
LEFT OUTER JOIN Proveedores P1 ON IsNull(cp.IdProveedor,OrdenesPago.IdProveedor)=P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor
GROUP BY #Auxiliar2.A_IdComprobante, cp.FechaRecepcion, cp.Letra, cp.NumeroComprobante1, 
	cp.NumeroComprobante2, tc.DescripcionAb, #Auxiliar2.A_IdValor, Valores.FechaComprobante, 
	Valores.NumeroComprobante, #Auxiliar2.A_IdOrdenPago, OrdenesPago.FechaOrdenPago, 
	OrdenesPago.NumeroOrdenPago, P1.IdProveedor, P2.IdProveedor

UNION ALL

SELECT 
 0 as [IdAux1],
 1 as [IdAux2],
 Null as [IdAux3],
 Null as [IdAux4],
 6 as [IdAux5],
 0 as [IdAux6],
 Null as [Fecha],
 Null as [Cod.Com.],
 'Totales :' as [N.Comprobante],
 Convert(varchar,Sum((#Auxiliar3.A_NetoGravado + #Auxiliar3.A_IVA + #Auxiliar3.A_NetoNoGravado + 
			#Auxiliar3.A_NetoNoGravadoImpInt) * IsNull(tc.Coeficiente,1))) as [Proveed],
 Convert(varchar,Sum(#Auxiliar3.A_NetoGravado * IsNull(tc.Coeficiente,1))) as [Razon Social],
 Null as [Tasa IVA],
 Convert(varchar,Sum(#Auxiliar3.A_IVA * IsNull(tc.Coeficiente,1))) as [Nro.CUIT], 
 Sum(#Auxiliar3.A_NetoNoGravado * IsNull(tc.Coeficiente,1)) as [Imp.Exentos],
 Sum(#Auxiliar3.A_NetoNoGravadoImpInt * IsNull(tc.Coeficiente,1)) as [Imp.mp.Int.],
 ' EBH, CO2, AN2:5;40, AN2:6;13, AN2:9;11, AV2:1;1, AV2:2;1, AV2:3;1, AV2:4;1, AV2:6;3, AV2:8;3, AV2:9;3, AH2:5;1, '+
	'VAL:1;5;Razon Social;                                   Importe;                                   Neto Grav., '+
	'VAL:1;6;Tasa C Cta;IVA  I Con, VAL:1;7;Nro.CUIT.;Importe;Impuestos, '+
	'VAL:1;8;Importes;Exentos, VAL:1;9;Importe;Impto.Int.'+
	'  |  | BOL | RIG,NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | RIG,NUM:#COMMA##0.00 |'+
	' NUM:#COMMA##0.00 | NUM:#COMMA##0.00 ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar3
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar3.A_IdComprobante
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=#Auxiliar3.A_IdOrdenPago
LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante

ORDER BY [IdAux2], [IdAux3], [IdAux4], [IdAux6], [IdAux5], [Tasa IVA]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
