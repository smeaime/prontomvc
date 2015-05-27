


CREATE Procedure [dbo].[DefinicionesFlujoCaja_T]
@IdDefinicionFlujoCaja int
AS 
SELECT * 
FROM DefinicionesFlujoCaja
WHERE (IdDefinicionFlujoCaja=@IdDefinicionFlujoCaja)


