CREATE Procedure [dbo].[Recibos_ActualizarDetalles]

@IdReciboOriginal int,
@IdOrigenTransmision int

AS

DECLARE @Cuit varchar(13)
SET @Cuit=IsNull((Select Top 1 Rec.CuitClienteTransmision From Recibos Rec 
			Where Rec.IdReciboOriginal=@IdReciboOriginal and 
				Rec.IdOrigenTransmision=@IdOrigenTransmision),'')
IF Len(@Cuit)>0
	UPDATE Recibos
	SET IdCliente=IsNull((Select Top 1 Clientes.IdCliente From Clientes 
				Where Clientes.Cuit=@Cuit),0)
	WHERE IdReciboOriginal=@IdReciboOriginal and 
		IdOrigenTransmision=@IdOrigenTransmision and 
		IsNull(IdCliente,0)=0

UPDATE DetalleRecibos
SET IdRecibo=(Select Top 1 Rec.IdRecibo From Recibos Rec 
		 Where 	Rec.IdReciboOriginal=@IdReciboOriginal and 
			Rec.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdReciboOriginal=@IdReciboOriginal and IdOrigenTransmision=@IdOrigenTransmision

UPDATE DetalleRecibosCuentas
SET IdRecibo=(Select Top 1 Rec.IdRecibo From Recibos Rec 
		 Where 	Rec.IdReciboOriginal=@IdReciboOriginal and 
			Rec.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdReciboOriginal=@IdReciboOriginal and IdOrigenTransmision=@IdOrigenTransmision

UPDATE DetalleRecibosRubrosContables
SET IdRecibo=(Select Top 1 Rec.IdRecibo From Recibos Rec 
		 Where 	Rec.IdReciboOriginal=@IdReciboOriginal and 
			Rec.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdReciboOriginal=@IdReciboOriginal and IdOrigenTransmision=@IdOrigenTransmision

UPDATE DetalleRecibosValores
SET IdRecibo=(Select Top 1 Rec.IdRecibo From Recibos Rec 
		 Where 	Rec.IdReciboOriginal=@IdReciboOriginal and 
			Rec.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdReciboOriginal=@IdReciboOriginal and IdOrigenTransmision=@IdOrigenTransmision

UPDATE Facturas
SET IdReciboContado=(Select Top 1 Rec.IdRecibo From Recibos Rec 
			Where Rec.IdReciboOriginal=Facturas.IdReciboContadoOriginal and 
				Rec.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdReciboContado=0 and IdOrigenTransmision=@IdOrigenTransmision