CREATE PROCEDURE [dbo].[Polizas_TX_Pagos]

@IdPoliza int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111133'
SET @vector_T='009435444200'

SELECT 
 DetOP.IdDetalleOrdenPago, 
 op.NumeroOrdenPago as [Numero], 
 DetOP.IdDetalleOrdenPago as [IdAux ], 
 op.FechaOrdenPago as [Fecha Pago], 
 cp.NumeroReferencia as [Nro.interno],
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha recep.],
 cp.FechaVencimiento as [Fecha vto.],
 DetOP.Importe as [Pagado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPago DetOP
LEFT OUTER JOIN CuentasCorrientesAcreedores cc ON cc.IdCtaCte=DetOP.IdImputacion
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cc.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=cc.IdComprobante and cc.IdTipoComp<>17 and cc.IdTipoComp<>16
LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
WHERE IsNull(cp.IdPoliza,0)=@IdPoliza and IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' 
ORDER BY op.FechaOrdenPago, op.NumeroOrdenPago