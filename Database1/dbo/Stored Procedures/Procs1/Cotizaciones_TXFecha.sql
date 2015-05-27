





























CREATE PROCEDURE [dbo].[Cotizaciones_TXFecha]
	@Desde datetime,
	@Hasta datetime
AS
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111133'
set @vector_T='0555800'
SELECT 
 IdCotizacion,
 Fecha,
 Monedas.Nombre as [Moneda],
 Cotizacion,
 CotizacionLibre [Cotizacion libre],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Cotizaciones
LEFT OUTER JOIN Monedas ON Cotizaciones.IdMoneda=Monedas.IdMoneda
WHERE Fecha between @Desde and @hasta
ORDER BY Monedas.Nombre,Fecha






























