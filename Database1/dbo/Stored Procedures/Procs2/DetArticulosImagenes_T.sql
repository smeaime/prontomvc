
CREATE Procedure [dbo].[DetArticulosImagenes_T]

@IdDetalleArticuloImagenes int

AS 

SELECT *
FROM [DetalleArticulosImagenes]
WHERE (IdDetalleArticuloImagenes=@IdDetalleArticuloImagenes)
