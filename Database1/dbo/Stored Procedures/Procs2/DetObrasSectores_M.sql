
CREATE Procedure [dbo].[DetObrasSectores_M]

@IdDetalleObraSector int,
@IdObra int,
@Descripcion varchar(50)

AS

UPDATE [DetalleObrasSectores]
SET 
 IdObra=@IdObra,
 Descripcion=@Descripcion
WHERE (IdDetalleObraSector=@IdDetalleObraSector)

RETURN(@IdDetalleObraSector)
