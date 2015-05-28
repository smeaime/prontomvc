CREATE Procedure [dbo].[Conjuntos_M]

@IdConjunto int,
@IdArticulo int,
@Observaciones ntext,
@IdRealizo int,
@FechaRegistro datetime,
@CodigoConjunto varchar(10),
@IdObra int,
@Version int

AS

UPDATE Conjuntos
SET 
 IdArticulo=@IdArticulo,
 Observaciones=@Observaciones,
 IdRealizo=@IdRealizo,
 FechaRegistro=@FechaRegistro,
 CodigoConjunto=@CodigoConjunto,
 IdObra=@IdObra,
 Version=@Version
WHERE (IdConjunto=@IdConjunto)

RETURN(@IdConjunto)
