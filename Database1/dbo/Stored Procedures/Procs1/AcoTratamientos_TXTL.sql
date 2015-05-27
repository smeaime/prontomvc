































CREATE Procedure [dbo].[AcoTratamientos_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoTratamientos.IdTratamiento, 
TratamientosTermicos.Descripcion as Titulo
FROM DetalleAcoTratamientos 
INNER JOIN AcoTratamientos ON DetalleAcoTratamientos.IdAcoTratamiento = AcoTratamientos.IdAcoTratamiento 
INNER JOIN TratamientosTermicos ON DetalleAcoTratamientos.IdTratamiento = TratamientosTermicos.IdTratamiento
WHERE AcoTratamientos.IdRubro = @Rubro AND AcoTratamientos.IdSubRubro = @Subrubro
































