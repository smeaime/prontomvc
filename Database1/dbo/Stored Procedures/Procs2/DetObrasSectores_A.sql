
CREATE Procedure [dbo].[DetObrasSectores_A]

@IdDetalleObraSector int  output,
@IdObra int,
@Descripcion varchar(50)

AS 

INSERT INTO [DetalleObrasSectores]
(
 IdObra,
 Descripcion
)
VALUES
(
 @IdObra,
 @Descripcion
)

SELECT @IdDetalleObraSector=@@identity
RETURN(@IdDetalleObraSector)
