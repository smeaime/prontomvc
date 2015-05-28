





























CREATE Procedure [dbo].[Cotizaciones_TT]
AS 
Select 
 IdCotizacion,
 Fecha,
 Monedas.Nombre as [Moneda],
 Cotizacion,
 CotizacionLibre [Cotizacion libre]
FROM Cotizaciones
LEFT OUTER JOIN Monedas ON Cotizaciones.IdMoneda=Monedas.IdMoneda
ORDER BY Monedas.Nombre,Fecha






























