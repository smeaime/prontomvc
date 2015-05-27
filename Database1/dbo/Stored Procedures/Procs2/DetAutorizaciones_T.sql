
CREATE Procedure [dbo].[DetAutorizaciones_T]

@IdDetalleAutorizacion int

AS 

SELECT *
FROM [DetalleAutorizaciones]
WHERE (IdDetalleAutorizacion=@IdDetalleAutorizacion)
