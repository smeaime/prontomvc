CREATE Procedure [dbo].[FletesValoresPromedio_E]

@IdFleteValorPromedio int 

AS 

DELETE FletesValoresPromedio
WHERE (IdFleteValorPromedio=@IdFleteValorPromedio)