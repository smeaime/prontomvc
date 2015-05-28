





























CREATE Procedure [dbo].[DetAcoMarcas_TXDetMarca]
@IdAcoMarca int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoMarcas.IdDetalleAcoMarca,
DetalleAcoMarcas.IdMarca,
Marcas.Descripcion as Marca,
DetalleAcoMarcas.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoMarcas
INNER JOIN Marcas ON DetalleAcoMarcas.IdMarca = Marcas.IdMarca
WHERE (DetalleAcoMarcas.IdAcoMarca = @IdAcoMarca)






























