





























CREATE Procedure [dbo].[DetAcoTratamientos_TT]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011133'
set @vector_T='004400'
Select 
DetalleAcoTratamientos.IdDetalleAcoTratamiento,
DetalleAcoTratamientos.IdTratamiento,
TratamientosTermicos.Descripcion as Tratamiento,
DetalleAcoTratamientos.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DetalleAcoTratamientos
INNER JOIN TratamientosTermicos ON DetalleAcoTratamientos.IdTratamiento = TratamientosTermicos.IdTratamiento






























