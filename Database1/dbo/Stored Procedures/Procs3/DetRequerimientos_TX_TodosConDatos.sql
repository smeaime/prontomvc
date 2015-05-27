CREATE Procedure [dbo].[DetRequerimientos_TX_TodosConDatos]

@IdRequerimiento int

AS 

SELECT
 DetReq.*,
 Requerimientos.NumeroRequerimiento,
 Requerimientos.FechaRequerimiento,
 Requerimientos.Aprobo,
 Requerimientos.IdObra as [IdObra],
 Articulos.Descripcion as [DescripcionArt],
 Articulos.Codigo,
 Unidades.Descripcion as [Unidad en],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad],
 (Select Sum(DetRec.Cantidad)
  From DetalleRecepciones DetRec
  Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
  Where DetReq.IdDetalleRequerimiento=DetRec.IdDetalleRequerimiento and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')) as [Entregado],
 DetReq.Cantidad - Isnull((Select Sum(DetRec.Cantidad)
 				From DetalleRecepciones DetRec 
				Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
				Where DetRec.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (Recepciones.Anulada is null or Recepciones.Anulada<>'SI')),0)
 as [Pendiente],
 IsNull((Select Sum(DetallePedidos.Cantidad) 
	From DetallePedidos 
	Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')),0)  as [Pedido],
 IsNull((Select Sum(DetalleValesSalida.Cantidad) 
	From DetalleValesSalida 
	Where DetalleValesSalida.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetalleValesSalida.Estado is null or DetalleValesSalida.Estado<>'AN')),0)  as [SalidaPorVales],
 0 as [Reservado],
 Obras.NumeroObra as [Obra],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra1],
 Clientes.RazonSocial as [Cliente],
 Equipos.Descripcion as [Equipo],
 Rubros.Descripcion as [Rubro],
 IsNull(ControlesCalidad.Abreviatura,ControlesCalidad.Descripcion) as [CC],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.Aprobo=Empleados.IdEmpleado) as [Liberada por],
 (Select Top 1 Empleados.Nombre from Empleados Where Requerimientos.IdSolicito=Empleados.IdEmpleado) as [Solicitada por],
 IsNull((Select Top 1 drls.Situacion From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento Order By Fecha Desc),'A') as [Situacion]
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
WHERE DetReq.IdRequerimiento=@IdRequerimiento