CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_DocumentosPorAutoriza]

@IdAutoriza int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111111133'
SET @vector_T='037414401313599999952900'

SELECT  
 Aut.IdComprobante as [IdComprobante],
 Aut.TipoComprobante as [Documento],
 Aut.Numero as [Numero],
 Aut.Fecha as [Fecha],
 Case When Aut.IdFormulario=4 Then (Select Top 1 Proveedores.RazonSocial From Proveedores Where (Select Top 1 Pedidos.IdProveedor From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)=Proveedores.IdProveedor)
		When Aut.IdFormulario=31 Then (Select Top 1 Proveedores.RazonSocial From Proveedores Where (Select Top 1 cp.IdProveedor From ComprobantesProveedores cp Where Aut.IdComprobante=cp.IdComprobanteProveedor)=Proveedores.IdProveedor)
		Else Null
 End as [Proveedor],
 Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoParaCompra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)
		When Aut.IdFormulario=4 Then (Select Top 1 Pedidos.TotalPedido From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)
		When Aut.IdFormulario=5 Then (Select Top 1 Comparativas.ImporteComparativaCalculado From Comparativas Where Aut.IdComprobante=Comparativas.IdComparativa)
		When Aut.IdFormulario=31 Then (Select Top 1 cp.TotalComprobante From ComprobantesProveedores cp Where Aut.IdComprobante=cp.IdComprobanteProveedor)
		Else Null
 End as [Monto p/compra],
 Case When Aut.IdFormulario=1 Then (Select Top 1 Acopios.MontoPrevisto From Acopios Where Aut.IdComprobante=Acopios.IdAcopio)
		When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoPrevisto From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)
		Else Null
 End as [Monto previsto],
 Aut.OrdenAutorizacion as [Orden],
 Case When Aut.IdFormulario=4 Then (Select Top 1 Monedas.Abreviatura From Monedas Where (Select Top 1 Pedidos.IdMoneda From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)=Monedas.IdMoneda)
		Else Null
 End as [Mon.],
 Case When Aut.IdFormulario=1 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select Acopios.IdObra From Acopios Where Aut.IdComprobante=Acopios.IdAcopio )=Obras.IdObra)
		When Aut.IdFormulario=2 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select LMateriales.IdObra From LMateriales Where Aut.IdComprobante=LMateriales.IdLMateriales )=Obras.IdObra)
		When Aut.IdFormulario=3 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=Obras.IdObra)
		When Aut.IdFormulario=4 Then (Select Top 1 Obras.NumeroObra From Obras
										Where (Select Top 1 Requerimientos.IdObra From Requerimientos
												Where Requerimientos.IdRequerimiento=
													(Select Top 1 DR.IdRequerimiento 
													 From DetalleRequerimientos DR 
													 Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento From DetallePedidos DP Where DP.IdPedido=Aut.IdComprobante and DP.IdDetalleRequerimiento is not null)))=Obras.IdObra)
		When Aut.IdFormulario=31 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select ComprobantesProveedores.IdObra From ComprobantesProveedores Where Aut.IdComprobante=ComprobantesProveedores.IdComprobanteProveedor)=Obras.IdObra)
		Else Null
 End as [Obra],
 Case When Aut.IdFormulario=3 Then ( Select Top 1 Sectores.Descripcion From Sectores Where Sectores.IdSector=(Select Top 1 Requerimientos.IdSector From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento))
		Else Null
 End as [Sector],
 Case When Aut.IdFormulario=3 Then (Select Top 1 CentrosCosto.Descripcion From CentrosCosto Where (Select Requerimientos.IdCentroCosto From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=CentrosCosto.IdCentroCosto)
		Else Null
 End as [Centro de costo],
 Case When Aut.IdFormulario=1 Then (Select Top 1 Clientes.RazonSocial From Clientes Where (Select Acopios.IdCliente From Acopios Where Aut.IdComprobante=Acopios.IdAcopio)=Clientes.IdCliente)
		When Aut.IdFormulario=2 Then (Select Top 1 Clientes.RazonSocial From Clientes Where (Select LMateriales.IdCliente From LMateriales Where Aut.IdComprobante=LMateriales.IdLMateriales)=Clientes.IdCliente)
		When Aut.IdFormulario=3 Then (Select Top 1 Clientes.RazonSocial From Clientes
										Where (Select Top 1 Obras.IdCliente From Obras Where (Select Top 1 Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=Obras.IdObra) = Clientes.IdCliente)
		Else Null
 End as [Cliente],
 Aut.IdFormulario as [IdFormulario],
 Aut.OrdenAutorizacion as [Nro.Orden],
 Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.IdSector From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)
		When Aut.IdFormulario=4 Then Aut.IdSector 
		Else 0
 End as [SectorEmisor],
 Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)
		When Aut.IdFormulario=4 Then (Select Top 1 Requerimientos.IdObra From Requerimientos
										Where Requerimientos.IdRequerimiento=(Select Top 1 DR.IdRequerimiento From DetalleRequerimientos DR Where DR.IdDetalleRequerimiento=(Select Top 1 DP.IdDetalleRequerimiento From DetallePedidos DP Where DP.IdPedido=Aut.IdComprobante and DP.IdDetalleRequerimiento is not null)))
		When Aut.IdFormulario=31 Then (Select Top 1 ComprobantesProveedores.IdObra From ComprobantesProveedores Where Aut.IdComprobante=ComprobantesProveedores.IdComprobanteProveedor)
		Else Null
 End as [IdObra],
 Aut.IdComprobante as [IdAux],
 Case When Aut.IdFormulario=4 Then (Select Pedidos.CotizacionMoneda From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido) 
		When Aut.IdFormulario=31 Then (Select Top 1 ComprobantesProveedores.CotizacionMoneda From ComprobantesProveedores Where Aut.IdComprobante=ComprobantesProveedores.IdComprobanteProveedor)
		Else Null 
 End as [Cotizacion],
 Empleados.Nombre as [Liberado por],
 Case When Aut.IdFormulario=4 Then (Select Top 1 Pedidos.TotalIva1 From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido) Else Null End as [Importe Iva],
 Aut.IdAutoriza as [IdAutoriza],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM _TempAutorizaciones Aut
LEFT OUTER JOIN Empleados ON Aut.IdLibero=Empleados.IdEmpleado
WHERE Aut.IdAutoriza is not null and Aut.IdAutoriza=@IdAutoriza
ORDER BY Aut.TipoComprobante,Aut.Numero,Aut.OrdenAutorizacion