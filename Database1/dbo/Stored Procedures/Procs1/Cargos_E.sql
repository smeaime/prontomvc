CREATE Procedure [dbo].[Cargos_E]

@IdCargo int  

AS 

DELETE Cargos
WHERE (IdCargo=@IdCargo)