


CREATE Procedure [dbo].[Subdiarios_ActualizarComprobantes]

@IdOrigenTransmision int

AS

UPDATE Subdiarios
SET IdComprobante=(Select Top 1 Fac.IdFactura From Facturas Fac 
		   Where Fac.IdFacturaOriginal=Subdiarios.IdComprobanteOriginal and 
			Fac.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdOrigenTransmision=@IdOrigenTransmision and IdTipoComprobante=1 and 
	IsNull(IdComprobante,0)=0

UPDATE Subdiarios
SET IdComprobante=(Select Top 1 Rec.IdRecibo From Recibos Rec 
		   Where Rec.IdReciboOriginal=Subdiarios.IdComprobanteOriginal and 
			Rec.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdOrigenTransmision=@IdOrigenTransmision and IdTipoComprobante=2 and 
	IsNull(IdComprobante,0)=0



