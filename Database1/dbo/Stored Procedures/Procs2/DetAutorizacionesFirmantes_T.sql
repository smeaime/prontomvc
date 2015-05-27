
CREATE Procedure [dbo].[DetAutorizacionesFirmantes_T]

@IdDetalleAutorizacionFirmantes int

AS 

SELECT *
FROM [DetalleAutorizacionesFirmantes]
WHERE (IdDetalleAutorizacionFirmantes=@IdDetalleAutorizacionFirmantes)
