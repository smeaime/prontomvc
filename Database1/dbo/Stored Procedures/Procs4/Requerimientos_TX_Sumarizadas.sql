






























CREATE  Procedure [dbo].[Requerimientos_TX_Sumarizadas]
@IdObra int
AS 
declare @Clave as int
set @clave=0
SELECT 
	@Clave,
	substring(Articulos.Descripcion,1,85) as [Articulo],
	SUM(DetReq.Cantidad) as [Cant.],
	DetReq.Cantidad1 as [Med.1],
	DetReq.Cantidad2 as [Med.2]
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos Req ON DetReq.IdRequerimiento = Req.IdRequerimiento
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
WHERE (Req.IdObra=@IdObra)
GROUP BY Articulos.Descripcion,DetReq.Cantidad1,DetReq.Cantidad2































