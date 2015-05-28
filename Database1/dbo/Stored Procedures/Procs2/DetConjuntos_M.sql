CREATE Procedure [dbo].[DetConjuntos_M]

@IdDetalleConjunto int,
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

UPDATE [DetalleConjuntos]
SET 
 IdConjunto=@IdConjunto,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 Observaciones=@Observaciones,
 FechaAlta=@FechaAlta,
 FechaModificacion=GetDate()
WHERE (IdDetalleConjunto=@IdDetalleConjunto)

RETURN(@IdDetalleConjunto)