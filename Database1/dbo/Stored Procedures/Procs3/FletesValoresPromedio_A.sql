CREATE Procedure [dbo].[FletesValoresPromedio_A]

@IdFleteValorPromedio int  output,
@IdArticulo int,
@IdUnidad int,
@Año int,
@Mes int,
@Valor numeric(18,2)

AS 

INSERT INTO [FletesValoresPromedio]
(
 IdArticulo,
 IdUnidad,
 Año,
 Mes,
 Valor
)
VALUES
(
 @IdArticulo,
 @IdUnidad,
 @Año,
 @Mes,
 @Valor
)

SELECT @IdFleteValorPromedio=@@identity

RETURN(@IdFleteValorPromedio)