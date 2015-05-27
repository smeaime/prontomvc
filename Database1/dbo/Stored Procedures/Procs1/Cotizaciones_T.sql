
CREATE Procedure [dbo].[Cotizaciones_T]
@IdCotizacion int
AS 
SELECT *
FROM Cotizaciones
WHERE (IdCotizacion=@IdCotizacion)
