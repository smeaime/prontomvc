
CREATE Procedure [dbo].[DetArticulosDocumentos_E]

@IdDetalleArticuloDocumentos int  

AS

DELETE [DetalleArticulosDocumentos]
WHERE (IdDetalleArticuloDocumentos=@IdDetalleArticuloDocumentos)
