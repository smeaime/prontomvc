CREATE Procedure [dbo].[Cargos_TT]

AS 

SELECT 
 IdCargo,
 Descripcion as [Cargo]
FROM Cargos
ORDER BY Descripcion