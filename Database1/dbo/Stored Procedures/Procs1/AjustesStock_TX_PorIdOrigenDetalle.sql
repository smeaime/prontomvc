






CREATE Procedure [dbo].[AjustesStock_TX_PorIdOrigenDetalle]
@IdDetalleAjusteStockOriginal int,
@IdOrigenTransmision int
AS 
SELECT Top 1 
 das.IdDetalleAjusteStock,
 das.IdArticulo,
 das.Partida,
 das.CantidadUnidades,
 das.IdUnidad,
 das.IdUbicacion,
 das.IdObra,
 AjustesStock.IdAjusteStock
FROM DetalleAjustesStock das
LEFT OUTER JOIN AjustesStock ON das.IdAjusteStock=AjustesStock.IdAjusteStock
WHERE das.IdDetalleAjusteStockOriginal=@IdDetalleAjusteStockOriginal and 
	das.IdOrigenTransmision=@IdOrigenTransmision






