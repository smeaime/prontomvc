CREATE Procedure [dbo].[Cargos_T]

@IdCargo int

AS 

SELECT *
FROM Cargos
WHERE (IdCargo=@IdCargo)