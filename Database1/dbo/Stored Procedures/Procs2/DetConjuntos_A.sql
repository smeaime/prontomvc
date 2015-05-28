CREATE Procedure [dbo].[DetConjuntos_A]

@IdDetalleConjunto int  output,
@IdConjunto int,
@IdArticulo int,
@Cantidad numeric(18,3),
@IdUnidad int,
@Cantidad1 numeric(18,2),
@Cantidad2 numeric(18,2),
@Observaciones ntext,
@FechaAlta datetime,
@FechaModificacion datetime

AS

INSERT INTO [DetalleConjuntos]
(
 IdConjunto,
 IdArticulo,
 Cantidad,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 Observaciones,
 FechaAlta,
 FechaModificacion
)
VALUES
(
 @IdConjunto,
 @IdArticulo,
 @Cantidad,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @Observaciones,
 GetDate(),
 Null
)

SELECT @IdDetalleConjunto=@@identity

RETURN(@IdDetalleConjunto)