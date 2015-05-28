CREATE Procedure [dbo].[FletesValoresPromedio_T]

@IdFleteValorPromedio int

AS 

SELECT*
FROM FletesValoresPromedio
WHERE (IdFleteValorPromedio=@IdFleteValorPromedio)