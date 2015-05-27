
CREATE Procedure [dbo].[_TempSAP_TX_Partidas]

AS 

DECLARE @IdTipoComprobanteOrdenPago int
SET @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago
					From Parametros Where Parametros.IdParametro=1)

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (IdProveedor INTEGER, Saldo NUMERIC(12,2))
INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdProveedor, Sum(CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 GROUP By CtaCte.IdProveedor

CREATE TABLE #Auxiliar2 (IdProveedor INTEGER, IdImputacion INTEGER, Saldo NUMERIC(12,2))
INSERT INTO #Auxiliar2 
 SELECT CtaCte.IdProveedor, IsNull(CtaCte.IdImputacion,0), Sum(CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 GROUP By CtaCte.IdProveedor, IsNull(CtaCte.IdImputacion,0)

SET NOCOUNT OFF

SELECT 
 IsNull(Proveedores.CodigoEmpresa,'') as [LIFNR],
 Case When Len(IsNull(Proveedores.Cuit,''))>0 
	Then Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1)
	Else ''
 End as [lfa1-stcd1],
 Case When cta.IdTipoComp=11 Then 'KF'
	When cta.IdTipoComp=10 Then 'KC'
	When cta.IdTipoComp=13 Then 'K2'
	When cta.IdTipoComp=16 Then 'KO'
	When cta.IdTipoComp=17 Then 'KA'
	When cta.IdTipoComp=18 Then 'KD'
	When cta.IdTipoComp=19 Then 'KO'
	Else '  '
 End as [TipoComprobante],
 Case When cta.IdTipoComp=@IdTipoComprobanteOrdenPago or cta.IdTipoComp=16 or 
		cp.IdComprobanteProveedor is null
	Then '0001A'+Substring('00000000',1,8-Len(Convert(varchar,cta.NumeroComprobante)))+
			Convert(varchar,cta.NumeroComprobante)
	Else Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+cp.Letra+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2)
 End as [NumeroComprobante],
 Replace(Convert(varchar,cta.Fecha,103),'/','.') as [FechaComprobante],
 'ARS' as [Moneda],
 '1,000' as [TipoCambio],
 Case When cta.IdTipoComp=@IdTipoComprobanteOrdenPago or cta.IdTipoComp=16 or 
		cp.IdComprobanteProveedor is null
	Then '0,00'
	Else Replace(Convert(varchar,cta.ImporteTotal-Convert(numeric(18,2),cp.TotalIva1*cp.CotizacionMoneda)),'.',',')
 End as [Neto],
 Case When cta.IdTipoComp=@IdTipoComprobanteOrdenPago or cta.IdTipoComp=16 or 
		cp.IdComprobanteProveedor is null
	Then '0,00'
	Else Replace(Convert(varchar,Convert(numeric(18,2),cp.TotalIva1*cp.CotizacionMoneda)),'.',',')
 End as [Iva],
 Replace(Convert(varchar,cta.Saldo),'.',',') as [Total],
 Replace(Convert(varchar,cta.FechaVencimiento,103),'/','.') as [FechaVencimiento]
FROM CuentasCorrientesAcreedores cta
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cta.IdProveedor
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=cta.IdComprobante
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdProveedor=cta.IdProveedor
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdProveedor=cta.IdProveedor and #Auxiliar2.IdImputacion=IsNull(cta.IdImputacion,0)
WHERE IsNull(Proveedores.Confirmado,'SI')<>'NO' and IsNull(Proveedores.IdEstado,1)=1 and 
	IsNull(cta.Saldo,0)<>0 and IsNull(#Auxiliar1.Saldo,0)<>0 and IsNull(#Auxiliar2.Saldo,0)<>0

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
