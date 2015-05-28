
CREATE Procedure [dbo].[DetArticulosUnidades_T]

@IdDetalleArticuloUnidades int

AS 

SELECT *
FROM [DetalleArticulosUnidades]
WHERE (IdDetalleArticuloUnidades=@IdDetalleArticuloUnidades)
