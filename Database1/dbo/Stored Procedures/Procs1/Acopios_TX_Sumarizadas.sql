































CREATE  Procedure [dbo].[Acopios_TX_Sumarizadas]
@IdObra int
AS 
declare @Clave as int
set @clave=0
SELECT 
	@Clave,
	substring(Articulos.Descripcion,1,85) as [Articulo],
	SUM(DetAco.Cantidad) as [Cant.],
	DetAco.Cantidad1 as [Med.1],
	DetAco.Cantidad2 as [Med.2]
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Acopios Aco ON DetAco.IdAcopio = Aco.IdAcopio
LEFT OUTER JOIN Articulos ON DetAco.IdArticulo = Articulos.IdArticulo
WHERE (Aco.IdObra=@IdObra)
GROUP BY Articulos.Descripcion,DetAco.Cantidad1,DetAco.Cantidad2
































