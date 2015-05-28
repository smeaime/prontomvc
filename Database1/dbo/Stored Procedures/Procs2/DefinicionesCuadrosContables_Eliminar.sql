





CREATE Procedure [dbo].[DefinicionesCuadrosContables_Eliminar]
@IdCuenta int
AS 
DELETE FROM DefinicionesCuadrosContables
WHERE DefinicionesCuadrosContables.IdCuenta=@IdCuenta





