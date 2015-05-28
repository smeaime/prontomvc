CREATE Procedure [dbo].[NotasDebito_TX_PorNumeroComprobante]

@TipoABC varchar(1),
@PuntoVenta smallint,
@NumeroNotaDebito int

AS 

SELECT *
FROM NotasDebito
WHERE TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and NumeroNotaDebito=@NumeroNotaDebito