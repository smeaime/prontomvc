
CREATE Procedure [dbo].[Conjuntos_A]

@IdConjunto int  output,
@IdArticulo int,
@Observaciones ntext,
@IdRealizo int,
@FechaRegistro datetime,
@CodigoConjunto varchar(10),
@IdObra int,
@Version int

AS 

INSERT INTO Conjuntos
(
 IdArticulo,
 Observaciones,
 IdRealizo,
 FechaRegistro,
 CodigoConjunto,
 IdObra,
 Version
)
VALUES
(
 @IdArticulo,
 @Observaciones,
 @IdRealizo,
 @FechaRegistro,
 @CodigoConjunto,
 @IdObra,
 @Version
)

SELECT @IdConjunto=@@identity

RETURN(@IdConjunto)
