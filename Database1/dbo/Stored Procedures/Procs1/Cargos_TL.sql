CREATE Procedure [dbo].[Cargos_TL]

AS 

SELECT IdCargo,Descripcion as [Titulo]
FROM Cargos
ORDER BY Descripcion