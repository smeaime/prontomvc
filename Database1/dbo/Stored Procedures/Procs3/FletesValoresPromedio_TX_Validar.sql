CREATE Procedure [dbo].[FletesValoresPromedio_TX_Validar]

@IdFleteValorPromedio int,
@IdArticulo int,
@Mes int,
@Año int

AS 

SELECT * 
FROM FletesValoresPromedio
WHERE IdArticulo=@IdArticulo and Mes=@Mes and Año=@Año and IdFleteValorPromedio<>@IdFleteValorPromedio