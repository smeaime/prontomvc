
CREATE Procedure [dbo].[PuntosVenta_TX_PorIdTipoComprobantePuntoVenta]

@IdTipoComprobante int,
@PuntoVenta int

AS 

SELECT *
FROM PuntosVenta
WHERE IdTipoComprobante=@IdTipoComprobante and PuntoVenta=@PuntoVenta
