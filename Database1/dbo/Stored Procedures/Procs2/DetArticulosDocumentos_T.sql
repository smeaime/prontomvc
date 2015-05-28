
CREATE Procedure [dbo].[DetArticulosDocumentos_T]

@IdDetalleArticuloDocumentos int

AS 

SELECT *
FROM [DetalleArticulosDocumentos]
WHERE (IdDetalleArticuloDocumentos=@IdDetalleArticuloDocumentos)
