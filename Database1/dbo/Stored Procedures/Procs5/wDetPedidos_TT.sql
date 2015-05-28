
CREATE PROCEDURE [dbo].[wDetPedidos_TT]

@IdPedido int

AS

SELECT
 DetPed.*,
 Unidades.Abreviatura as  [Unidad],
 ControlesCalidad.Descripcion as [ControlCalidad],
 A1.Codigo as [Codigo],
 A1.Descripcion as [Articulo],
 IsNull(Acopios.IdObra,Requerimientos.IdObra) as [IdObra],
 Obras.NumeroObra,
 Acopios.NumeroAcopio as [NumeroAcopio],
 DetalleAcopios.NumeroItem as [ItemAcopio],
 Requerimientos.NumeroRequerimiento as [NumeroRequerimiento],
 DetalleRequerimientos.NumeroItem as [ItemRequerimiento],
 Clientes.RazonSocial as [Cliente],
 E1.Nombre as [CostoAsignadoPor],
 E1.Nombre as [RMSolicitadaPor],
 A2.Codigo as [CodigoEquipoDestino],
 A2.Descripcion as [EquipoDestino]
FROM DetallePedidos DetPed
LEFT OUTER JOIN ControlesCalidad ON DetPed.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Articulos A1 ON DetPed.IdArticulo = A1.IdArticulo
LEFT OUTER JOIN Articulos A2 ON DetalleRequerimientos.IdEquipoDestino = A2.IdArticulo
LEFT OUTER JOIN Empleados E1 ON DetPed.IdUsuarioAsignoCosto = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
LEFT OUTER JOIN Unidades ON DetPed.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON IsNull(Acopios.IdObra,Requerimientos.IdObra)= Obras.IdObra
LEFT OUTER JOIN Clientes ON Obras.IdCliente= Clientes.IdCliente
WHERE (DetPed.IdPedido = @IdPedido)
ORDER by DetPed.NumeroItem

