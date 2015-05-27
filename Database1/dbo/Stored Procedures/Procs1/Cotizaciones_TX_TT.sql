





























CREATE Procedure [dbo].[Cotizaciones_TX_TT]
@IdCotizacion int
AS 
Select 
 IdCotizacion,
 Fecha,
 Monedas.Nombre as [Moneda],
 Cotizacion,
 CotizacionLibre [Cotizacion libre]
FROM Cotizaciones
LEFT OUTER JOIN Monedas ON Cotizaciones.IdMoneda=Monedas.IdMoneda
WHERE (IdCotizacion=@IdCotizacion)






























