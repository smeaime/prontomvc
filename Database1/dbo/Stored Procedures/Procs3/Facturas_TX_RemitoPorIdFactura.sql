CREATE PROCEDURE [dbo].[Facturas_TX_RemitoPorIdFactura]

@IdFactura int

AS

SELECT TOP 1 dr.IdRemito, Remitos.NumeroRemito
FROM DetalleFacturasRemitos dfr
LEFT OUTER JOIN DetalleRemitos dr ON dr.IdDetalleRemito = dfr.IdDetalleRemito
LEFT OUTER JOIN Remitos ON Remitos.IdRemito = dr.IdRemito
WHERE dfr.IdFactura=@IdFactura