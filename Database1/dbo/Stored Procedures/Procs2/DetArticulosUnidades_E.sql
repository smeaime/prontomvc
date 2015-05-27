
CREATE Procedure [dbo].[DetArticulosUnidades_E]

@IdDetalleArticuloUnidades int  

AS 

DELETE [DetalleArticulosUnidades]
WHERE (IdDetalleArticuloUnidades=@IdDetalleArticuloUnidades)
