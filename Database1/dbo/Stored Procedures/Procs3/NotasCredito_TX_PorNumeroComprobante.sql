CREATE Procedure [dbo].[NotasCredito_TX_PorNumeroComprobante]

@TipoABC varchar(1),
@PuntoVenta smallint,
@NumeroNotaCredito int

AS 

SELECT *
FROM NotasCredito
WHERE TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and NumeroNotaCredito=@NumeroNotaCredito