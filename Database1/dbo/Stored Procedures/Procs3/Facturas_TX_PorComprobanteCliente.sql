CREATE Procedure [dbo].[Facturas_TX_PorComprobanteCliente]

@IdCliente int,
@TipoABC varchar(1),
@PuntoVenta smallint,
@NumeroFactura int

AS 

SELECT *
FROM Facturas
WHERE IdCliente=@IdCliente and 
	TipoABC=@TipoABC and 
	PuntoVenta=@PuntoVenta and 
	NumeroFactura=@NumeroFactura