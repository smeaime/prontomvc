CREATE Procedure [dbo].[Facturas_TX_PorNumeroDesdeHasta]

@TipoABC varchar(1),
@PuntoVenta smallint,
@NumeroInicial int,
@NumeroFinal int

AS 

SELECT *
FROM Facturas
WHERE TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and (NumeroFactura>=@NumeroInicial and NumeroFactura<=@NumeroFinal)