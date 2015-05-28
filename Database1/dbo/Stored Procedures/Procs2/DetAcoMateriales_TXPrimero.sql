





























CREATE Procedure [dbo].[DetAcoMateriales_TXPrimero]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select TOP 1
DetalleAcoMateriales.IdDetalleAcoMaterial,
DetalleAcoMateriales.IdMaterial,
Materiales.Descripcion as Material,
DetalleAcoMateriales.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoMateriales
INNER JOIN Materiales ON DetalleAcoMateriales.IdMaterial = Materiales.IdMaterial






























