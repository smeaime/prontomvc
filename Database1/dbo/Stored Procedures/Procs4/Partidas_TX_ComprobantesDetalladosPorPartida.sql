
CREATE PROCEDURE [dbo].[Partidas_TX_ComprobantesDetalladosPorPartida]

@Partida varchar(20)

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111133'
SET @vector_T='06E12E410F00'

SELECT 
 Det.IdArticulo as [IdArticulo],
 Articulos.Codigo as [Cod.Art.],
 Articulos.Descripcion as [Articulo],
 Clientes.RazonSocial as [Cliente],
 'Remito' as [Tipo],
 Substring('0000',1,4-Len(Convert(varchar,Remitos.PuntoVenta)))+Convert(varchar,Remitos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Numero],
 Remitos.FechaRemito as [Fecha],
 Det.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 Null as [Referencia],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRemitos Det 
LEFT OUTER JOIN Remitos ON Remitos.IdRemito=Det.IdRemito
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Remitos.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=Det.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
WHERE IsNull(Remitos.Anulado,'')<>'NO' and IsNull(Det.Partida,'')=@Partida

UNION ALL

SELECT 
 DetalleFacturas.IdArticulo as [IdArticulo],
 Articulos.Codigo as [Cod.Art.],
 Articulos.Descripcion as [Articulo],
 Clientes.RazonSocial as [Cliente],
 'Factura' as [Tipo],
 Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura) as [Numero],
 Facturas.FechaFactura as [Fecha],
 DetalleFacturas.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 'Rem '+Substring('0000',1,4-Len(Convert(varchar,Remitos.PuntoVenta)))+Convert(varchar,Remitos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Referencia],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFacturasRemitos Det 
LEFT OUTER JOIN DetalleFacturas ON DetalleFacturas.IdDetalleFactura=Det.IdDetalleFactura
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Det.IdFactura
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Facturas.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetalleFacturas.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=DetalleFacturas.IdUnidad
LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=Det.IdDetalleRemito
LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
WHERE IsNull(Facturas.Anulada,'')<>'NO' and IsNull(DetalleRemitos.Partida,'')=@Partida

UNION ALL

SELECT 
 Det.IdArticulo as [IdArticulo],
 Articulos.Codigo as [Cod.Art.],
 Articulos.Descripcion as [Articulo],
 Clientes.RazonSocial as [Cliente],
 'Devolucion' as [Tipo],
 Devoluciones.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion) as [Numero],
 Devoluciones.FechaDevolucion as [Fecha],
 Det.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 'Fac '+Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura) as [Referencia],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDevoluciones Det 
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Det.IdDevolucion
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Devoluciones.IdCliente
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=Det.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Devoluciones.IdFactura
WHERE IsNull(Devoluciones.Anulada,'')<>'NO' and IsNull(Det.Partida,'')=@Partida

ORDER BY [Fecha], [Numero]
