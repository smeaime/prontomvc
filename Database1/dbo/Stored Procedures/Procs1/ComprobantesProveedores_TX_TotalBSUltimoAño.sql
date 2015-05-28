CREATE Procedure [dbo].[ComprobantesProveedores_TX_TotalBSUltimoAño]

@IdProveedor int, 
@Hasta datetime, 
@IdCodigoIva int = Null

AS 

SET NOCOUNT ON

DECLARE @IdTipoCuentaGrupoIVA int, @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int, @Desde datetime
SET @Desde=Dateadd(yy,-1,@Hasta)
SET @IdCodigoIva=IsNull(@IdCodigoIva,-1)

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol1=IsNull((Select IdCuentaAdicionalIVACompras1 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol2=IsNull((Select IdCuentaAdicionalIVACompras2 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol3=IsNull((Select IdCuentaAdicionalIVACompras3 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol4=IsNull((Select IdCuentaAdicionalIVACompras4 From Parametros Where IdParametro=1),0)
SET @IdCtaAdicCol5=IsNull((Select IdCuentaAdicionalIVACompras5 From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar 
			(
			 IdComprobanteProveedor INTEGER,
			 BienesOServicios VARCHAR(2),
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar 
SELECT
 dcp.IdComprobanteProveedor,
 IsNull(cp.BienesOServicios,'B'),
 Case When (Cuentas.IdTipoCuentaGrupo is null or Cuentas.IdTipoCuentaGrupo<>@IdTipoCuentaGrupoIVA) and 
			dcp.IdCuenta<>@IdCtaAdicCol1 and dcp.IdCuenta<>@IdCtaAdicCol2 and 
			dcp.IdCuenta<>@IdCtaAdicCol3 and dcp.IdCuenta<>@IdCtaAdicCol4 and 
			dcp.IdCuenta<>@IdCtaAdicCol5 
	Then dcp.Importe*cp.CotizacionMoneda  
	Else 0
 End * TiposComprobante.Coeficiente
FROM DetalleComprobantesProveedores dcp 
LEFT OUTER JOIN ComprobantesProveedores cp ON dcp.IdComprobanteProveedor = cp.IdComprobanteProveedor
LEFT OUTER JOIN Cuentas ON dcp.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = cp.IdTipoComprobante
WHERE (cp.FechaRecepcion Between @Desde And @Hasta) and 
	(@IdProveedor=-1 or cp.IdProveedor=@IdProveedor) and 
	(@IdCodigoIva=-1 or cp.IdCodigoIva=@IdCodigoIva)

SET NOCOUNT OFF

SELECT 
 Sum(Case When BienesOServicios='B' Then IsNull(Importe,0) Else 0 End) as [Importe_Bienes],
 Sum(Case When BienesOServicios<>'B' Then IsNull(Importe,0) Else 0 End) as [Importe_Servicios]
FROM #Auxiliar

DROP TABLE #Auxiliar
