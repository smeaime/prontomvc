CREATE Procedure [dbo].[wCtasCtesA_TX_SaldosAFechaDetallado]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteOrdenPago int

SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar0	(IdProveedor INTEGER, SaldoPesos NUMERIC(18, 2))
INSERT INTO #Auxiliar0 
 SELECT CtaCte.IdProveedor, Sum(IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente*-1)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 WHERE CtaCte.Fecha<=@FechaHasta 
 GROUP BY CtaCte.IdProveedor

CREATE TABLE #Auxiliar1	(IdProveedor INTEGER, SaldoPesos NUMERIC(18, 2))
INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdProveedor, Sum(IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente*-1)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 WHERE CtaCte.Fecha<@FechaDesde 
 GROUP BY CtaCte.IdProveedor

SET NOCOUNT OFF

SELECT  
 0 as [K_Orden],
 Proveedores.RazonSocial+' ['+Proveedores.CodigoEmpresa COLLATE SQL_Latin1_General_CP1_CI_AS+']' as [Proveedor],
 @FechaDesde as [Fecha],
 Null as [IdTipoComprobante],
 Null as [IdComprobante],
 'SALDO INICIAL AL '+Convert(varchar,@FechaDesde,103) as [Comprobante],
 Null as [Detalle],
 #Auxiliar1.SaldoPesos as [Importe]
FROM #Auxiliar1
LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdProveedor=#Auxiliar1.IdProveedor
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar1.IdProveedor
WHERE IsNull(#Auxiliar0.SaldoPesos,0)<>0

UNION ALL

SELECT  
 1 as [K_Orden],
 Proveedores.RazonSocial+' ['+Proveedores.CodigoEmpresa COLLATE SQL_Latin1_General_CP1_CI_AS+']' as [Proveedor],
 CtaCte.Fecha as [Fecha],
 CtaCte.IdTipoComp as [IdTipoComprobante],
 CtaCte.IdComprobante as [IdComprobante],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16
	Then 'OP '+Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
	Else TiposComprobante.DescripcionAb+' '+IsNull(cp.Letra,'?')+'-'+
		Substring('0000',1,4-Len(Convert(varchar,IsNull(cp.NumeroComprobante1,0))))+Convert(varchar,IsNull(cp.NumeroComprobante1,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,IsNull(cp.NumeroComprobante2,CtaCte.NumeroComprobante))))+Convert(varchar,IsNull(cp.NumeroComprobante2,CtaCte.NumeroComprobante))+' '+
		'[ Ref. : '+Convert(varchar,IsNull(cp.NumeroReferencia,0))+' ]'
 End as [Comprobante],
 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16
	Then op.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS
	Else cp.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS
 End as [Detalle],
 CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1 as [Importe]
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdProveedor=CtaCte.IdProveedor
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante and Not (CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16)
LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=CtaCte.IdComprobante and (CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16)
WHERE IsNull(#Auxiliar0.SaldoPesos,0)<>0 and CtaCte.Fecha>=@FechaDesde and CtaCte.Fecha<=@FechaHasta 

ORDER BY [Proveedor], [K_Orden], [Fecha]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1