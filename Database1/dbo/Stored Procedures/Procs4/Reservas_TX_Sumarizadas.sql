





























CREATE  Procedure [dbo].[Reservas_TX_Sumarizadas]
@IdObra int
AS 
declare @Clave as int
set @clave=0
SELECT 
	@Clave,
	substring(Articulos.Descripcion,1,85) as [Articulo],
	SUM(DetRes.CantidadUnidades) as [Cant.],
	DetRes.Cantidad1 as [Med.1],
	DetRes.Cantidad2 as [Med.2]
FROM DetalleReservas DetRes
LEFT OUTER JOIN Reservas Res ON DetRes.IdReserva = Res.IdReserva
LEFT OUTER JOIN Articulos ON DetRes.IdArticulo = Articulos.IdArticulo
WHERE (DetRes.IdObra=@IdObra)
GROUP BY Articulos.Descripcion,DetRes.Cantidad1,DetRes.Cantidad2






























