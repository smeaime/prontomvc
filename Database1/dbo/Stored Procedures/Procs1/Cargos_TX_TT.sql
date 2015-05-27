CREATE Procedure [dbo].[Cargos_TX_TT]

@IdCargo int

AS 

SELECT 
 IdCargo,
 Descripcion as [Cargo]
FROM Cargos
WHERE (IdCargo=@IdCargo)