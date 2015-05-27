CREATE Procedure [dbo].[PuntosVenta_TX_PorIdTipoComprobante]

@IdTipoComprobante int

AS 

SELECT 
 IdPuntoVenta,
 Letra as [Titulo],
 PuntoVenta,
 ProximoNumero
FROM PuntosVenta
WHERE IdTipoComprobante=@IdTipoComprobante
ORDER by Letra, PuntoVenta