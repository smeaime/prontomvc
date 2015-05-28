
CREATE Procedure [dbo].[DetArticulosImagenes_E]

@IdDetalleArticuloImagenes int  

AS 

DELETE [DetalleArticulosImagenes]
WHERE (IdDetalleArticuloImagenes=@IdDetalleArticuloImagenes)
