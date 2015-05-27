


CREATE Procedure [dbo].[DefinicionAnulaciones_T]
@IdDefinicionAnulacion int
AS 
SELECT * 
FROM DefinicionAnulaciones
WHERE (IdDefinicionAnulacion=@IdDefinicionAnulacion)


