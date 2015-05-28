

CREATE Procedure [dbo].[TiposOperaciones_E]

@IdTipoOperacion int

AS 

DELETE TiposOperaciones
WHERE (IdTipoOperacion=@IdTipoOperacion)
