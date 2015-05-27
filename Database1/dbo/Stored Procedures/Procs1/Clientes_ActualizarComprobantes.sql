


CREATE Procedure [dbo].[Clientes_ActualizarComprobantes]

AS

UPDATE Facturas
SET IdCliente=IsNull((Select Top 1 Clientes.IdCliente From Clientes 
			Where Clientes.Cuit=
			IsNull(Facturas.CuitClienteTransmision COLLATE SQL_Latin1_General_CP1_CI_AS,'')),0)
WHERE IdOrigenTransmision is not null and IsNull(IdCliente,0)=0

UPDATE Recibos
SET IdCliente=IsNull((Select Top 1 Clientes.IdCliente From Clientes 
			Where Clientes.Cuit=
			IsNull(Recibos.CuitClienteTransmision COLLATE SQL_Latin1_General_CP1_CI_AS,'')),0)
WHERE IdOrigenTransmision is not null and IsNull(IdCliente,0)=0


