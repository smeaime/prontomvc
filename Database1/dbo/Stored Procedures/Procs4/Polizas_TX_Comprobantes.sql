CREATE PROCEDURE [dbo].[Polizas_TX_Comprobantes]

@IdPoliza int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111133'
SET @vector_T='0093544410001100'

SELECT 
 cp.IdComprobanteProveedor, 
 TiposComprobante.Descripcion as [Tipo comp.],
 cp.IdComprobanteProveedor as [IdAux ], 
 cp.NumeroReferencia as [Nro.interno],
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha recep.],
 cp.FechaVencimiento as [Fecha vto.],
 cp.TotalBruto as [Subtotal],
 cp.TotalIva1 as [IVA 1],
 cp.AjusteIVA as [Aj.IVA],
 cp.TotalBonificacion as [Bonif.],
 cp.TotalComprobante as [Total],
 Monedas.Abreviatura as [Mon.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ComprobantesProveedores cp
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Monedas ON cp.IdMoneda = Monedas.IdMoneda
WHERE IsNull(cp.IdPoliza,0)=@IdPoliza
ORDER BY cp.FechaRecepcion,cp.NumeroReferencia