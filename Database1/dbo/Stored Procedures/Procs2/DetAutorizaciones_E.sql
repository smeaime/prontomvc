
CREATE Procedure [dbo].[DetAutorizaciones_E]

@IdDetalleAutorizacion int  

AS 

DELETE [DetalleAutorizaciones]
WHERE (IdDetalleAutorizacion=@IdDetalleAutorizacion)
