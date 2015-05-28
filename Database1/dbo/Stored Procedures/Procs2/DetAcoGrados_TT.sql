





























CREATE Procedure [dbo].[DetAcoGrados_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoGrados.IdDetalleAcoGrado,
DetalleAcoGrados.IdGrado,
Grados.Descripcion as Grado,
DetalleAcoGrados.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoGrados
INNER JOIN Grados ON DetalleAcoGrados.IdGrado = Grados.IdGrado






























