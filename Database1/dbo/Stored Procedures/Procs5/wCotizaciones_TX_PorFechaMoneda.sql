
CREATE Procedure [dbo].[wCotizaciones_TX_PorFechaMoneda]

@Fecha datetime,
@IdMoneda int

AS 

SELECT TOP 1 *
FROM Cotizaciones
WHERE Fecha=@Fecha And IdMoneda=@IdMoneda

