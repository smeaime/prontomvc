




CREATE Procedure [dbo].[DefinicionesFlujoCaja_TX_PorCodigo]
@Codigo int
AS 
SELECT *
FROM DefinicionesFlujoCaja 
WHERE Codigo=@Codigo




