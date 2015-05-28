
CREATE Procedure [dbo].[DetAutorizacionesFirmantes_E]

@IdDetalleAutorizacionFirmantes int  

AS 

DELETE [DetalleAutorizacionesFirmantes]
WHERE (IdDetalleAutorizacionFirmantes=@IdDetalleAutorizacionFirmantes)
