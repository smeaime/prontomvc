


CREATE Procedure [dbo].[TiposOperaciones_T]

@IdTipoOperacion int

AS 

SELECT *
FROM TiposOperaciones
WHERE (IdTipoOperacion=@IdTipoOperacion)
