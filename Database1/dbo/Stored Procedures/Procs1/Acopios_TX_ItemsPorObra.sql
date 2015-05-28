































CREATE  Procedure [dbo].[Acopios_TX_ItemsPorObra]
@IdObra int
AS 
declare @vector_X varchar(30),@vector_T varchar(30),@Cargado numeric(12,2),@Faltante numeric(12,2)
set @vector_X='0111111111114133'
set @vector_T='0115100113135900'
set @Cargado=0
set @Faltante=0
SELECT 
DetAco.IdDetalleAcopios,
Aco.NumeroAcopio as [Nro.Aco],
DetAco.NumeroItem as [Item],
Aco.Fecha as [Fecha],
Equipos.Tag as [Tag],
Articulos.Descripcion as [Articulo],
DetAco.Cantidad as [Cant.],
DetAco.Cantidad1 as [Med.1],
DetAco.Cantidad2 as [Med.2],
CASE 
	WHEN DetAco.Cantidad1 IS NOT NULL AND DetAco.Cantidad2 IS NOT NULL THEN  DetAco.Cantidad*DetAco.Cantidad1*DetAco.Cantidad2
	WHEN DetAco.Cantidad1 IS NOT NULL THEN  DetAco.Cantidad*DetAco.Cantidad1
	ELSE DetAco.Cantidad
END as [Total],
@Cargado as [Cargado],
@Faltante as [Faltante],
DetAco.Observaciones,
DetAco.IdDetalleAcopios as [IdDetAco],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Acopios Aco ON DetAco.IdAcopio = Aco.IdAcopio
LEFT OUTER JOIN Articulos ON DetAco.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Equipos ON DetAco.IdEquipo = Equipos.IdEquipo
WHERE (Aco.IdObra=@IdObra)
ORDER BY Aco.NumeroAcopio,DetAco.NumeroItem
































