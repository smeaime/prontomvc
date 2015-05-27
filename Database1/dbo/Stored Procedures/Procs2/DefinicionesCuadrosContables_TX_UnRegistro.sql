





CREATE Procedure [dbo].[DefinicionesCuadrosContables_TX_UnRegistro]
@IdCuenta int
AS 
SELECT TOP 1 *
FROM DefinicionesCuadrosContables dcc 
WHERE dcc.IdCuenta=@IdCuenta





