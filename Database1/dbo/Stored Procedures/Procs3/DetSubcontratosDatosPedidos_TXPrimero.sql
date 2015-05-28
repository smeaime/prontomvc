
CREATE PROCEDURE [dbo].[DetSubcontratosDatosPedidos_TXPrimero]

@IdPedido int = Null

AS

SET @IdPedido=IsNull(@IdPedido,-1)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111161111133'
SET @vector_T='0G994023E119900'

IF @IdPedido=-1
   BEGIN
	SELECT TOP 1
	 Det.IdDetalleSubcontratoDatosPedido,
	 Case 	When Pedidos.SubNumero is not null 
		Then str(Pedidos.NumeroPedido,8)+' / '+Convert(varchar,Pedidos.SubNumero)
		Else str(Pedidos.NumeroPedido,8)
	 End as [Pedido],
	 Det.IdDetalleSubcontratoDatosPedido as [IdAux1],
	 Pedidos.IdPedido as [IdAux2],
	 Pedidos.FechaPedido [Fecha],
	 Pedidos.Cumplido as [Cump.],
	 Proveedores.RazonSocial as [Proveedor],
	 IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
		IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
		IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0) as [Importe],
	 Monedas.Abreviatura as [Mon.],
	 E1.Nombre as [Comprador],
	 E2.Nombre as [Liberado por],
	 (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
		IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
		IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0)) * 
		IsNull(Pedidos.CotizacionMoneda,1) as [ImporteEnPesos],
	 (Select Top 1 o.NumeroObra From DetallePedidos dp
	  Left Outer Join DetalleRequerimientos dr On dr.IdDetalleRequerimiento=dp.IdDetalleRequerimiento
	  Left Outer Join Requerimientos r On r.IdRequerimiento=dr.IdRequerimiento
	  Left Outer Join Obras o On o.IdObra=r.IdObra
	  Where dp.IdPedido=Pedidos.IdPedido and o.NumeroObra is not null) as [NumeroObra],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM DetalleSubcontratosDatosPedidos Det
	LEFT OUTER JOIN Pedidos ON Det.IdPedido=Pedidos.IdPedido
	LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
	LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
	LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador=E1.IdEmpleado
	LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo=E2.IdEmpleado
   END
ELSE
   BEGIN
	SELECT TOP 1
	 0,
	 Case 	When Pedidos.SubNumero is not null 
		Then str(Pedidos.NumeroPedido,8)+' / '+Convert(varchar,Pedidos.SubNumero)
		Else str(Pedidos.NumeroPedido,8)
	 End as [Pedido],
	 0 as [IdAux1],
	 Pedidos.IdPedido as [IdAux2],
	 Pedidos.FechaPedido [Fecha],
	 Pedidos.Cumplido as [Cump.],
	 Proveedores.RazonSocial as [Proveedor],
	 IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
		IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
		IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0) as [Importe],
	 Monedas.Abreviatura as [Mon.],
	 E1.Nombre as [Comprador],
	 E2.Nombre as [Liberado por],
	 (IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
		IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
		IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0)) * 
		IsNull(Pedidos.CotizacionMoneda,1) as [ImporteEnPesos],
	 (Select Top 1 o.NumeroObra From DetallePedidos dp
	  Left Outer Join DetalleRequerimientos dr On dr.IdDetalleRequerimiento=dp.IdDetalleRequerimiento
	  Left Outer Join Requerimientos r On r.IdRequerimiento=dr.IdRequerimiento
	  Left Outer Join Obras o On o.IdObra=r.IdObra
	  Where dp.IdPedido=Pedidos.IdPedido and o.NumeroObra is not null) as [NumeroObra],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM Pedidos
	LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
	LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
	LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador=E1.IdEmpleado
	LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo=E2.IdEmpleado
	WHERE Pedidos.IdPedido=@IdPedido
   END
