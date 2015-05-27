CREATE Procedure [dbo].[wAutorizacionesPorComprobante_TX_DocumentosPorAutoriza]

@IdAutoriza int = Null

AS

SET NOCOUNT ON
SET @IdAutoriza=IsNull(@IdAutoriza,-1)
EXEC AutorizacionesPorComprobante_Generar
SET NOCOUNT OFF

SELECT  
 Aut.IdComprobante,
 Case When Aut.IdFormulario=1 Then 101 
	When Aut.IdFormulario=2 Then 102
	When Aut.IdFormulario=3 Then 103
	When Aut.IdFormulario=4 Then 51
	When Aut.IdFormulario=5 Then 105 
	When Aut.IdFormulario=6 Then 106 
	When Aut.IdFormulario=31 Then 11 
	When Aut.IdFormulario=55 Then 107 
	Else 0 
 End as [IdTipoComprobante],
 Aut.TipoComprobante as [Documento],
 Aut.Numero as [Numero],
 Aut.Fecha as [Fecha],
 Case When Aut.IdFormulario=4 Then (Select Top 1 Proveedores.RazonSocial From Proveedores
					Where (Select Top 1 Pedidos.IdProveedor From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)=Proveedores.IdProveedor)
	When Aut.IdFormulario=31 Then (Select Top 1 Proveedores.RazonSocial From Proveedores
					Where (Select Top 1 cp.IdProveedor From ComprobantesProveedores cp Where Aut.IdComprobante=cp.IdComprobanteProveedor)=Proveedores.IdProveedor)
	Else Null
 End as [Proveedor],
 Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoParaCompra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)
	When Aut.IdFormulario=4 Then (Select Top 1 Pedidos.TotalPedido From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)
	When Aut.IdFormulario=31 Then (Select Top 1 cp.TotalComprobante From ComprobantesProveedores cp Where Aut.IdComprobante=cp.IdComprobanteProveedor)
	Else Null
 End as [Monto p/compra],
 Case When Aut.IdFormulario=1 Then (Select Top 1 Acopios.MontoPrevisto From Acopios Where Aut.IdComprobante=Acopios.IdAcopio)
	When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.MontoPrevisto From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)
	Else Null
 End as [Monto previsto],
 Aut.OrdenAutorizacion as [Orden],
 Case When Aut.IdFormulario=4 Then (Select Top 1 Monedas.Abreviatura From Monedas 
					Where (Select Top 1 Pedidos.IdMoneda From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)=Monedas.IdMoneda)
	Else Null
 End as [Moneda],
 Case When Aut.IdFormulario=1 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select Acopios.IdObra From Acopios Where Aut.IdComprobante=Acopios.IdAcopio )=Obras.IdObra)
	When Aut.IdFormulario=2 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select LMateriales.IdObra From LMateriales Where Aut.IdComprobante=LMateriales.IdLMateriales )=Obras.IdObra)
	When Aut.IdFormulario=3 Then (Select Top 1 Obras.NumeroObra From Obras
					Where (Select Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=Obras.IdObra)
	When Aut.IdFormulario=4 Then (Select Top 1 Obras.NumeroObra From Obras
					Where (Select Top 1 Requerimientos.IdObra From Requerimientos
						Where Requerimientos.IdRequerimiento=
							(Select Top 1 DR.IdRequerimiento 
							 From DetalleRequerimientos DR 
							 Where DR.IdDetalleRequerimiento=
								(Select Top 1 DP.IdDetalleRequerimiento
								 From DetallePedidos DP 
								 Where DP.IdPedido=Aut.IdComprobante and 
									DP.IdDetalleRequerimiento is not null)))=Obras.IdObra)
	When Aut.IdFormulario=31 Then (Select Top 1 Obras.NumeroObra From Obras Where (Select ComprobantesProveedores.IdObra From ComprobantesProveedores Where Aut.IdComprobante=ComprobantesProveedores.IdComprobanteProveedor)=Obras.IdObra)
	Else Null
 End as [Obra],
 Case When Aut.IdFormulario=3 Then ( Select Top 1 Sectores.Descripcion 
					   From Sectores 
					   Where Sectores.IdSector=(Select Top 1 Requerimientos.IdSector From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento))
	Else Null
 End as [SectorRM],
 Case When Aut.IdFormulario=3 Then (Select Top 1 CentrosCosto.Descripcion From CentrosCosto
					Where (Select Requerimientos.IdCentroCosto From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=CentrosCosto.IdCentroCosto)
	Else Null
 End as [Centro de costo],
 Case When Aut.IdFormulario=1 Then (Select Top 1 Clientes.RazonSocial From Clientes 
					Where (Select Acopios.IdCliente From Acopios Where Aut.IdComprobante=Acopios.IdAcopio)=Clientes.IdCliente)
	When Aut.IdFormulario=2 Then (Select Top 1 Clientes.RazonSocial From Clientes
					Where (Select LMateriales.IdCliente From LMateriales Where Aut.IdComprobante=LMateriales.IdLMateriales)=Clientes.IdCliente)
	When Aut.IdFormulario=3 Then (Select Top 1 Clientes.RazonSocial From Clientes
					Where (Select Top 1 Obras.IdCliente From Obras
						Where (Select Top 1 Requerimientos.IdObra From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)=Obras.IdObra) = Clientes.IdCliente)
	Else Null
 End as [Cliente],
 Aut.IdFormulario,
 Aut.OrdenAutorizacion as [Nro.Orden],
 Case When Aut.IdFormulario=3 Then (Select Top 1 Requerimientos.IdSector From Requerimientos Where Aut.IdComprobante=Requerimientos.IdRequerimiento)
	When Aut.IdFormulario=4 Then Aut.IdSector 
	Else 0
 End as [SectorEmisor],
 Case When Aut.IdFormulario=4 Then (Select Pedidos.CotizacionMoneda From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)
	Else Null
 End as [Cotizacion],
 E1.Nombre as [Libero],
 IsNull(E2.Nombre,'_A Designar') as [Autoriza],
 Case When Aut.IdFormulario=4 Then (Select Top 1 Pedidos.TotalIva1 From Pedidos Where Aut.IdComprobante=Pedidos.IdPedido)
	Else Null
 End as [ImporteIva],
 Case When IsNull(Aut.IdAutoriza,0) = -1 Then '_A Designar' Else Sectores.Descripcion End as [Sector]
FROM _TempAutorizaciones Aut
LEFT OUTER JOIN Empleados E1 ON Aut.IdLibero=E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Aut.IdAutoriza=E2.IdEmpleado
LEFT OUTER JOIN Sectores ON Aut.IdSector=Sectores.IdSector
WHERE Aut.IdAutoriza is not null and (@IdAutoriza=-1 or Aut.IdAutoriza=@IdAutoriza)
ORDER BY [Autoriza], [Sector], [Documento], [Numero], [Orden]