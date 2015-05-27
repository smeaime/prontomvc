CREATE PROCEDURE [dbo].[Remitos_TX_FacturasPorIdRemito]

@IdRemito int

AS

SELECT DISTINCT 
 'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura) as [Factura],
 dfr.IdFactura as [IdFactura]
FROM DetalleFacturasRemitos dfr
LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=dfr.IdFactura
LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=dfr.IdDetalleRemito
LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
WHERE Remitos.IdRemito=@IdRemito and (Fac.Anulada is null or Fac.Anulada<>'SI')