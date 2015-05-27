
CREATE PROCEDURE [dbo].[Pedidos_TX_RegistroDePedidos]

@Desde datetime,
@Hasta datetime,
@IdObra int

AS

SELECT Distinct
 DetPed.IdPedido,
 Ped.NumeroPedido as [Nro.Pedido],
 Ped.FechaPedido [Fecha],
 Case	WHEN Requerimientos.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Obras.IdObra=Requerimientos.IdObra)
	WHEN Acopios.IdObra is not null Then (Select Obras.NumeroObra From Obras Where Obras.IdObra=Acopios.IdObra)
	ELSE null
 End as [Obra],
 Case	WHEN DetalleRequerimientos.IdCentroCosto is not null Then (Select CentrosCosto.Descripcion From CentrosCosto Where CentrosCosto.IdCentroCosto=DetalleRequerimientos.IdCentroCosto)
	ELSE null
 End as [C.Costo],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When Ped.TotalIva1 is null and Ped.TotalIva2 is null Then Ped.TotalPedido 
 	When Ped.TotalIva1 is not null and Ped.TotalIva2 is null Then Ped.TotalPedido-Ped.TotalIva1 
 	When Ped.TotalIva1 is not null and Ped.TotalIva2 is not null Then Ped.TotalPedido-Ped.TotalIva1-Ped.TotalIva2
	Else Null
 End as [Total pedido],
 Empleados.Nombre as [Comprador],
 Convert(Varchar(2000),Ped.FormaPago) as [Forma de pago],
 Ped.NumeroComparativa as [Comparativa]
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos Ped ON DetPed.IdPedido=Ped.IdPedido
LEFT OUTER JOIN Proveedores ON Ped.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Empleados ON Ped.IdComprador=Empleados.IdEmpleado
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (Ped.FechaPedido Between @Desde and @Hasta) and 
	 ((Requerimientos.IdObra is not null and @IdObra=Requerimientos.IdObra) or 
	  (Acopios.IdObra is not null and @IdObra=Acopios.IdObra) or 
	  @IdObra=-1)
ORDER BY Ped.NumeroPedido
