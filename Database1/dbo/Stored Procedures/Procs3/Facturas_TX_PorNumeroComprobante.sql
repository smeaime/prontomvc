CREATE Procedure [dbo].[Facturas_TX_PorNumeroComprobante]

@TipoABC varchar(1),
@PuntoVenta smallint,
@NumeroFactura int

AS 

SELECT *
FROM Facturas
WHERE TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and NumeroFactura=@NumeroFactura