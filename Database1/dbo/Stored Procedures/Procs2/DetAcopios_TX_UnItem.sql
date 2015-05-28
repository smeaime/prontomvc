



















CREATE Procedure [dbo].[DetAcopios_TX_UnItem]
@IdDetalleAcopios int
AS 
SELECT 
 DetAco.*,
 (Select Top 1 
  DetalleLMateriales.IdDetalleLMateriales
  From DetalleLMateriales 
  Where DetAco.IdDetalleAcopios=DetalleLMateriales.IdDetalleAcopios) as IdDetalleLMateriales,
 Acopios.NumeroAcopio,
 Obras.NumeroObra as [Obra],
 Clientes.RazonSocial as [Cliente]
FROM DetalleAcopios DetAco
LEFT OUTER JOIN Acopios ON DetAco.IdAcopio=Acopios.IdAcopio
LEFT OUTER JOIN Obras ON Acopios.IdObra = Obras.IdObra
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
WHERE (DetAco.IdDetalleAcopios=@IdDetalleAcopios)



















