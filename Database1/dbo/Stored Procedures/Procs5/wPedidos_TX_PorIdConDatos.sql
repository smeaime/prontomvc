CREATE PROCEDURE [dbo].[wPedidos_TX_PorIdConDatos]

@IdPedido int

AS

SELECT 
 Pedidos.*,
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
	IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
	IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0) as [SubTotal],
 IsNull(Pedidos.ImpuestosInternos,0)+IsNull(Pedidos.OtrosConceptos1,0)+IsNull(Pedidos.OtrosConceptos2,0)+
	IsNull(Pedidos.OtrosConceptos3,0)+IsNull(Pedidos.OtrosConceptos4,0)+IsNull(Pedidos.OtrosConceptos5,0) as [OtrosConceptos],
 Case When Pedidos.TipoCompra=1 Then 'Gestion por compras' When Pedidos.TipoCompra=2 Then 'Gestion por terceros' Else Null End as [TipoCompra1],
 dbo.Pedidos_Requerimientos(Pedidos.IdPedido) as [RM's],
 dbo.Pedidos_Obras(Pedidos.IdPedido) as [Obras],
 Proveedores.RazonSocial as [Proveedor],
 Proveedores.Direccion as [Direccion], 
 Localidades.Nombre as [Localidad], 
 Proveedores.CodigoPostal as [CodigoPostal], 
 Provincias.Nombre as [Provincia], 
 Paises.Descripcion as [Pais], 
 Proveedores.Telefono1 as [Telefono], 
 Proveedores.Fax as [Fax], 
 Proveedores.Email as [Email], 
 Proveedores.Cuit as [Cuit], 
 DescripcionIva.Descripcion as [CondicionIVA],
 Monedas.Abreviatura as [Moneda],
 E1.Nombre as [Comprador],
 E2.Nombre as [Libero],
 cc.Descripcion as [DescripcionCondicionPago],
 (Select Top 1 A.Descripcion From Articulos A 
	Where A.IdArticulo=(Select Top 1 Requerimientos.IdEquipoDestino 
				From DetalleRequerimientos DR
				Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=DR.IdRequerimiento
				Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento 
								 From DetallePedidos DP 
								 Where DP.IdPedido=Pedidos.IdPedido and 
									DP.IdDetalleRequerimiento is not null))) as [EquipoDestino]
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador=E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo=E2.IdEmpleado
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
LEFT OUTER JOIN [Condiciones Compra] cc ON cc.IdCondicionCompra = Pedidos.IdCondicionCompra
WHERE Pedidos.IdPedido=@IdPedido