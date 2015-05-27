CREATE Procedure [dbo].[Facturas_ActualizarIdReciboContado]

@IdFactura int,
@IdReciboContado int

AS

UPDATE Facturas
SET IdReciboContado=@IdReciboContado
WHERE IdFactura=@IdFactura