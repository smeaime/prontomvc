CREATE  Procedure [dbo].[FletesValoresPromedio_M]

@IdFleteValorPromedio int ,
@IdArticulo int,
@IdUnidad int,
@Año int,
@Mes int,
@Valor numeric(18,2)

AS

UPDATE FletesValoresPromedio
SET
 IdArticulo=@IdArticulo,
 IdUnidad=@IdUnidad,
 Año=@Año,
 Mes=@Mes,
 Valor=@Valor
WHERE (IdFleteValorPromedio=@IdFleteValorPromedio)

RETURN(@IdFleteValorPromedio)