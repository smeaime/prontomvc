CREATE PROCEDURE [dbo].[Requerimientos_TX_DatosObra]

@IdDetalleRequerimiento int

AS

SELECT
 Obras.NumeroObra as [Obra],
 Clientes.RazonSocial as [Cliente],
 Equipos.Descripcion as [Equipo],
 Requerimientos.IdObra,
 DetReq.Cumplido,
 DetReq.NumeroItem,
 Requerimientos.NumeroRequerimiento,
 TiposCompra.Modalidad as [TipoCompra]
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
WHERE DetReq.IdDetalleRequerimiento=@IdDetalleRequerimiento