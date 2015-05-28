
CREATE Procedure [dbo].[DetArticulosUnidades_M]

@IdDetalleArticuloUnidades int,
@IdArticulo int,
@IdUnidad int,
@Equivalencia numeric(18,6),
@EnviarEmail tinyint,
@IdArticuloOriginal int,
@IdDetalleArticuloUnidadesOriginal int,
@IdOrigenTransmision int

AS

UPDATE [DetalleArticulosUnidades]
SET 
 IdArticulo=@IdArticulo,
 IdUnidad=@IdUnidad,
 Equivalencia=@Equivalencia,
 EnviarEmail=@EnviarEmail,
 IdArticuloOriginal=@IdArticuloOriginal,
 IdDetalleArticuloUnidadesOriginal=@IdDetalleArticuloUnidadesOriginal,
 IdOrigenTransmision=@IdOrigenTransmision
WHERE (IdDetalleArticuloUnidades=@IdDetalleArticuloUnidades)

RETURN(@IdDetalleArticuloUnidades)
