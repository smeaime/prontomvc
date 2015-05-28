
CREATE Procedure [dbo].[DetArticulosUnidades_A]
@IdDetalleArticuloUnidades int output,
@IdArticulo int,
@IdUnidad int,
@Equivalencia numeric(18,6),
@EnviarEmail tinyint,
@IdArticuloOriginal int,
@IdDetalleArticuloUnidadesOriginal int,
@IdOrigenTransmision int

AS 

INSERT INTO [DetalleArticulosUnidades]
(
 IdArticulo,
 IdUnidad,
 Equivalencia,
 EnviarEmail,
 IdArticuloOriginal,
 IdDetalleArticuloUnidadesOriginal,
 IdOrigenTransmision
)
VALUES
(
 @IdArticulo,
 @IdUnidad,
 @Equivalencia,
 @EnviarEmail,
 @IdArticuloOriginal,
 @IdDetalleArticuloUnidadesOriginal,
 @IdOrigenTransmision
)

SELECT @IdDetalleArticuloUnidades=@@identity
RETURN(@IdDetalleArticuloUnidades)
