


CREATE Procedure [dbo].[Facturas_ActualizarDetalles]

@IdFacturaOriginal int,
@IdOrigenTransmision int

AS

DECLARE @Cuit varchar(13)
SET @Cuit=IsNull((Select Top 1 Fac.CuitClienteTransmision From Facturas Fac 
			Where Fac.IdFacturaOriginal=@IdFacturaOriginal and 
				Fac.IdOrigenTransmision=@IdOrigenTransmision),'')
IF Len(@Cuit)>0
	UPDATE Facturas
	SET IdCliente=IsNull((Select Top 1 Clientes.IdCliente From Clientes 
				Where Clientes.Cuit=@Cuit),0)
	WHERE IdFacturaOriginal=@IdFacturaOriginal and 
		IdOrigenTransmision=@IdOrigenTransmision and 
		IsNull(IdCliente,0)=0

UPDATE DetalleFacturas
SET IdFactura=(Select Top 1 Fac.IdFactura From Facturas Fac 
		 Where 	Fac.IdFacturaOriginal=@IdFacturaOriginal and 
			Fac.IdOrigenTransmision=@IdOrigenTransmision)
WHERE IdFacturaOriginal=@IdFacturaOriginal and 
	IdOrigenTransmision=@IdOrigenTransmision


