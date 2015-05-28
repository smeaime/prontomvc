CREATE PROCEDURE [dbo].[CtasCtesA_TX_PorIdConDatos]

@IdCtaCte int

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
 FROM CuentasCorrientesAcreedores cca 
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cca.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=cca.IdComprobante
 WHERE cca.IdCtaCte = @IdCtaCte and IsNull(TiposComprobante.Agrupacion1,'')='PROVEEDORES' and cp.IdComprobanteProveedor is not null

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 GravadoIVA NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
SELECT
 dcp.IdComprobanteProveedor,
 Sum(
	Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
				dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
				dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and dcp.IdCuenta<>@IdCtaAdicCol5 
		Then Case When dcp.ImporteIVA1=0 and dcp.ImporteIVA2=0 and dcp.ImporteIVA3=0 and dcp.ImporteIVA4=0 and dcp.ImporteIVA5=0 and 
						dcp.ImporteIVA6=0 and dcp.ImporteIVA7=0 and dcp.ImporteIVA8=0 and dcp.ImporteIVA9=0 and dcp.ImporteIVA10=0
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

SET NOCOUNT OFF

SELECT
 cca.IdCtaCte as [IdCtaCte],
 cca.IdImputacion as [IdImputacion],
 TiposComprobante.DescripcionAb as [Tipo],
 Case When IsNull(cp.IdComprobanteProveedor,0)>0 
	Then cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
	When IsNull(OrdenesPago.IdOrdenPago,0)>0 
	Then Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)
	Else Substring('00000000',1,8-Len(Convert(varchar,cca.NumeroComprobante)))+Convert(varchar,cca.NumeroComprobante)
 End as [Numero],
 cca.Fecha as [Fecha],
 cca.ImporteTotal*TiposComprobante.Coeficiente as [ImporteTotal],
 cca.Saldo*TiposComprobante.Coeficiente as [Saldo],
 Case When IsNull(cp.IdComprobanteProveedor,0)>0 and cca.ImporteTotal<>0 Then ((cca.Saldo*TiposComprobante.Coeficiente)*cp.TotalBruto/(cca.ImporteTotal*TiposComprobante.Coeficiente)) Else 0 End as [SinImpuestos],
 cp.TotalIva1*TiposComprobante.Coeficiente as [TotalIva],
 cp.TotalComprobante*TiposComprobante.Coeficiente as [TotalComprobante],
 Case When cp.BienesOServicios is not null Then cp.BienesOServicios Else Case When Proveedores.BienesOServicios is not null Then Proveedores.BienesOServicios Else Null End End as [BoS],
 Case When cp.IdDetalleOrdenPagoRetencionIVAAplicada is not null
	 Then (Select Top 1 op1.NumeroOrdenPago From OrdenesPago op1
			Where op1.IdOrdenPago=(Select Top 1 DetOP1.IdOrdenPago From DetalleOrdenesPago DetOP1 Where DetOP1.IdDetalleOrdenPago=cp.IdDetalleOrdenPagoRetencionIVAAplicada))
	When cp.IdOrdenPagoRetencionIva is not null
	 Then (Select Top 1 op1.NumeroOrdenPago From OrdenesPago op1 Where op1.IdOrdenPago=cp.IdOrdenPagoRetencionIva)
	 Else Null
 End as [NumeroOrdenPagoRetencionIVA],
 cp.IdTipoRetencionGanancia as [IdTipoRetencionGanancia],
 cp.IdIBCondicion as [IdIBCondicion],
 Case When IBCondiciones.BaseCalculo is null or IBCondiciones.BaseCalculo='SIN IMPUESTOS' Then 'SIN IMPUESTOS' Else 'CON IMPUESTOS' End as [BaseCalculoIIBB],
 cca.FechaVencimiento as [FechaVencimiento],
 cp.FechaComprobante as [FechaComprobante],
 Case When IsNull(cp.IdComprobanteProveedor,0)>0 and cca.ImporteTotal<>0 Then ((cca.Saldo*TiposComprobante.Coeficiente)*IsNull(#Auxiliar1.GravadoIVA,0)/(cca.ImporteTotal*TiposComprobante.Coeficiente)) Else 0 End as [GravadoIva],
 cp.CotizacionMoneda as [CotizacionMoneda],
 cp.PorcentajeIVAParaMonotributistas as [PorcentajeIVAParaMonotributistas],
 cca.IdTipoComp as [IdTipoComp],
 cca.IdComprobante as [IdComprobante],
 Polizas.Certificado as [CertificadoPoliza],
 Polizas.NumeroEndoso as [NumeroEndosoPoliza]
FROM CuentasCorrientesAcreedores cca
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cca.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=cca.IdComprobante and cca.IdTipoComp<>17 and cca.IdTipoComp<>16
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=cca.IdComprobante and (cca.IdTipoComp=17 or cca.IdTipoComp=16)
LEFT OUTER JOIN Proveedores ON cp.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN IBCondiciones ON cp.IdIBCondicion=IBCondiciones.IdIBCondicion
LEFT OUTER JOIN #Auxiliar1 ON cp.IdComprobanteProveedor=#Auxiliar1.IdComprobanteProveedor
LEFT OUTER JOIN Polizas ON cp.IdPoliza=Polizas.IdPoliza
WHERE cca.IdCtaCte = @IdCtaCte

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1