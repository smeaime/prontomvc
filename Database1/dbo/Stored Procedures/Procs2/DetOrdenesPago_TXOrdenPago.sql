CREATE PROCEDURE [dbo].[DetOrdenesPago_TXOrdenPago]

@IdOrdenPago int

AS

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int, @Fecha datetime

SET @IdTipoCuentaGrupoIVA=IsNull((Select Parametros.IdTipoCuentaGrupoIVA From Parametros Where Parametros.IdParametro=1),0)
SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar0 (IdComprobanteProveedor INTEGER)
INSERT INTO #Auxiliar0 
 SELECT cp.IdComprobanteProveedor
 FROM DetalleOrdenesPago DetOP
 LEFT OUTER JOIN CuentasCorrientesAcreedores ON CuentasCorrientesAcreedores.IdCtaCte=DetOP.IdImputacion
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesAcreedores.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CuentasCorrientesAcreedores.IdComprobante
 WHERE DetOP.IdOrdenPago = @IdOrdenPago and IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' and cp.IdComprobanteProveedor is not null

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 GravadoIVA NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
SELECT
 dcp.IdComprobanteProveedor,
 SUM(
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then 	Case 	When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and 
					dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and dcp.ImporteIVA6=0 and 
					dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and 
					dcp.ImporteIVA10=0
				 Then 0
				 Else dcp.Importe*cp.CotizacionMoneda  
			End
		Else 0
	 End)
FROM DetalleComprobantesProveedores dcp 
LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
WHERE dcp.IdComprobanteProveedor In (Select #Auxiliar0.IdComprobanteProveedor From #Auxiliar0)
GROUP BY dcp.IdComprobanteProveedor

IF Exists(Select OrdenesPago.FechaOrdenPago From OrdenesPago Where OrdenesPago.IdOrdenPago=@IdOrdenPago)
  SET @Fecha=(Select OrdenesPago.FechaOrdenPago From OrdenesPago Where OrdenesPago.IdOrdenPago=@IdOrdenPago)
ELSE
  SET @Fecha=GETDATE()

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000111111111111111111111111111133'
SET @vector_T='000074111312025999993939999993500'

SELECT
 DetOP.IdDetalleOrdenPago,
 DetOP.IdOrdenPago,
 DetOP.IdImputacion,
 Case When DetOP.IdImputacion=-1 Then 'PA' When DetOP.IdImputacion=-2 Then 'CO' Else TiposComprobante.DescripcionAB End as [Comp.],
 Case When IsNull(cp.IdComprobanteProveedor,0)>0 
			Then cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
					Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
		When IsNull(OrdenesPago.IdOrdenPago,0)>0 
			Then Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)
		Else Substring('00000000',1,8-Len(Convert(varchar,cc.NumeroComprobante)))+Convert(varchar,cc.NumeroComprobante)
 End as [Numero],
 cc.Fecha as [Fecha],
 cc.ImporteTotal*TiposComprobante.Coeficiente as [Imp.],
 cc.Saldo*TiposComprobante.Coeficiente as [Saldo],
 DetOP.Importe,
 Case When DetOP.IdImputacion=-1 Then Round(DetOP.ImportePagadoSinImpuestos,2) When cc.ImporteTotal<>0 Then Round((DetOP.Importe*cp.TotalBruto/cc.ImporteTotal),2) Else 0 End as [s/impuesto],
 cp.TotalIva1*TiposComprobante.Coeficiente as [IVA],
 cp.TotalComprobante*TiposComprobante.Coeficiente as [Tot.Comp.],
 Case When cp.BienesOServicios is not null Then cp.BienesOServicios Else Case When Proveedores.BienesOServicios is not null Then Proveedores.BienesOServicios Else Null End End as [B/S],
 DetOP.ImporteRetencionIVA as [Ret.Iva],
 Case When cp.IdDetalleOrdenPagoRetencionIVAAplicada is not null
			Then (Select Top 1 op1.NumeroOrdenPago From OrdenesPago op1
					Where op1.IdOrdenPago=(Select Top 1 DetOP1.IdOrdenPago From DetalleOrdenesPago DetOP1 Where DetOP1.IdDetalleOrdenPago=cp.IdDetalleOrdenPagoRetencionIVAAplicada))
		When cp.IdOrdenPagoRetencionIva is not null	Then (Select Top 1 op1.NumeroOrdenPago From OrdenesPago op1 Where op1.IdOrdenPago=cp.IdOrdenPagoRetencionIva)
	 Else Null
 End as [Ret.Iva en OP],
 IsNull(cp.IdTipoRetencionGanancia,DetOP.IdTipoRetencionGanancia) as [IdTipoRetencionGanancia],
 IsNull(cp.IdIBCondicion,DetOP.IdIBCondicion) as [IdIBCondicion],
 Case When ib1.BaseCalculo is null or ib1.BaseCalculo='SIN IMPUESTOS' Then 'SIN IMPUESTOS' Else 'CON IMPUESTOS' End as [BaseCalculoIIBB],
 cc.FechaVencimiento,
 cp.FechaComprobante,
 Case When DetOP.IdImputacion=-1 Then DetOP.ImportePagadoSinImpuestos When cc.ImporteTotal<>0 Then (DetOP.Importe*IsNull(#Auxiliar1.GravadoIVA,0)/cc.ImporteTotal) Else 0 End as [Gravado IVA],
 cp.CotizacionMoneda,
 cp.PorcentajeIVAParaMonotributistas as [%IVA Mono],
 cc.IdTipoComp as [IdTipoComp],
 cc.IdComprobante as [IdComprobante],
 Polizas.Certificado as [Certif.Poliza],
 Polizas.NumeroEndoso as [Nro.Endoso],
 ib2.Descripcion as [CategoriaIIBB],
 TiposRetencionGanancia.Descripcion as [CategoriaGanancias],
 DetOP.ImporteRetencionSUSS as [Ret.SUSS],
 DetOP.SaldoAFondoDeReparo as [A fondo de reparo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPago DetOP
LEFT OUTER JOIN CuentasCorrientesAcreedores cc ON cc.IdCtaCte=DetOP.IdImputacion
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cc.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=cc.IdComprobante and cc.IdTipoComp<>17 and cc.IdTipoComp<>16
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=cc.IdComprobante and (cc.IdTipoComp=17 or cc.IdTipoComp=16)
LEFT OUTER JOIN Proveedores ON cp.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN #Auxiliar1 ON cp.IdComprobanteProveedor=#Auxiliar1.IdComprobanteProveedor
LEFT OUTER JOIN Polizas ON cp.IdPoliza=Polizas.IdPoliza
LEFT OUTER JOIN IBCondiciones ib1 ON ib1.IdIBCondicion=cp.IdIBCondicion
LEFT OUTER JOIN IBCondiciones ib2 ON ib2.IdIBCondicion=DetOP.IdIBCondicion
LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=DetOP.IdTipoRetencionGanancia
WHERE (DetOP.IdOrdenPago = @IdOrdenPago)

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1