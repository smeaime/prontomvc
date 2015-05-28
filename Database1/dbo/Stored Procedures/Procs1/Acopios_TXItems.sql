































CREATE Procedure [dbo].[Acopios_TXItems]
@IdAcopio int
AS 
SELECT 
DetalleAcopios.NumeroItem as Itm,
"Item "+convert(varchar,DetalleAcopios.NumeroItem)+" - "+Articulos.Descripcion as Titulo
FROM DetalleAcopios
LEFT OUTER JOIN Articulos ON DetalleAcopios.IdArticulo = Articulos.IdArticulo
where (IdAcopio=@IdAcopio)
































