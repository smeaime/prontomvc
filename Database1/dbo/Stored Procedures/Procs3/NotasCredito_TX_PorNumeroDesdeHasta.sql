CREATE Procedure [dbo].[NotasCredito_TX_PorNumeroDesdeHasta]

@TipoABC varchar(1),
@PuntoVenta smallint,
@NumeroInicial int,
@NumeroFinal int

AS 

SELECT *
FROM NotasCredito
WHERE TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and (NumeroNotaCredito>=@NumeroInicial and NumeroNotaCredito<=@NumeroFinal)