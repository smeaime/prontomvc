




CREATE Procedure [dbo].[Obras_GenerarActivacionCompraMateriales]

@IdObra int,
@IdEquipo int

AS

TRUNCATE TABLE _TempActivacionCompraMateriales

INSERT INTO _TempActivacionCompraMateriales
 SELECT 
	DetReq.IdEquipo,
	Requerimientos.IdObra,
	'RM',
	10,
	DetReq.IdDetalleRequerimiento,
	Null,
	DetReq.IdDetalleLMateriales,
	Requerimientos.NumeroRequerimiento,
	DetReq.NumeroItem,
	DetReq.FechaEntrega,
	DetReq.IdArticulo,
	DetReq.Observaciones,
	Case 	When DetReq.Cantidad is not null
		 Then DetReq.Cantidad
		Else 0
	End,
	DetReq.Cantidad1,
	DetReq.Cantidad2,
	DetReq.IdUnidad,
	Null,
	Case 	When DetReq.IdProveedor is not null
		 Then 'Telefonico'
		Else Null
	End,
	Null,
	Null,
	Null,
	DetReq.FechaEntrega_Tel,
	Null,
	Case 	When (Select Sum(DetalleReservas.CantidadUnidades) 
			From DetalleReservas 
			Where DetalleReservas.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento)  is not null
		 Then (Select Sum(DetalleReservas.CantidadUnidades) 
			From DetalleReservas 
			Where DetalleReservas.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento)
		Else 0
	End,
	Case 	When (Select Sum(DetalleRecepciones.Cantidad) 
			From DetalleRecepciones
			Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) is not null 
		 Then (Select Sum(DetalleRecepciones.Cantidad) 
			From DetalleRecepciones
			Where DetalleRecepciones.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento)
		Else 0
	End,
	Null
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE Requerimientos.IdObra is not null and 
	(Requerimientos.Confirmado is null or Requerimientos.Confirmado<>'NO') and 
	(Requerimientos.Cumplido is null or Requerimientos.Cumplido<>'AN')  and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@IdEquipo=-1 or DetReq.IdEquipo=@IdEquipo) 

 UNION ALL 

 SELECT 
	DetalleRequerimientos.IdEquipo,
	Requerimientos.IdObra,
	'RM',
	20,
	DetalleRequerimientos.IdDetalleRequerimiento,
	Null,
	Null,
	Requerimientos.NumeroRequerimiento,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	DetPed.IdDetallePedido,
	'Nota de pedido',
	Convert(Varchar,Pedidos.NumeroPedido)+' / '+Convert(Varchar,Pedidos.SubNumero),
	DetPed.Cantidad,
	DetPed.FechaNecesidad,
	DetPed.FechaEntrega,
	Empleados.Nombre,
	Null,
	Null,
	Null
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento = DetPed.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN Empleados ON Pedidos.IdComprador = Empleados.IdEmpleado
 WHERE DetPed.IdDetalleRequerimiento is not null and Requerimientos.IdObra is not null and 
	(Pedidos.Cumplido is null or Pedidos.Cumplido<>'AN') and 
	(DetPed.Cumplido is null or DetPed.Cumplido<>'AN') and 
	(@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@IdEquipo=-1 or DetalleRequerimientos.IdEquipo=@IdEquipo) 

 UNION ALL 

 SELECT 
	DetAco.IdEquipo,
	Acopios.IdObra,
	'LA',
	30,
	Null,
	DetAco.IdDetalleAcopios,
	Null,
	Acopios.NumeroAcopio,
	DetAco.NumeroItem,
	DetAco.FechaNecesidad,
	DetAco.IdArticulo,
	DetAco.Observaciones,
	Case 	When DetAco.Cantidad is not null
		 Then DetAco.Cantidad
		Else 0
	End,
	DetAco.Cantidad1,
	DetAco.Cantidad2,
	DetAco.IdUnidad,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Case 	When (Select Sum(DetalleReservas.CantidadUnidades) 
			From DetalleReservas 
			Where DetalleReservas.IdDetalleAcopios=DetAco.IdDetalleAcopios)  is not null
		 Then (Select Sum(DetalleReservas.CantidadUnidades) 
			From DetalleReservas 
			Where DetalleReservas.IdDetalleAcopios=DetAco.IdDetalleAcopios)
		Else 0
	End,
	Case 	When (Select Sum(DetalleRecepciones.Cantidad) 
			From DetalleRecepciones
			Where DetalleRecepciones.IdDetalleAcopios=DetAco.IdDetalleAcopios) is not null 
		 Then (Select Sum(DetalleRecepciones.Cantidad) 
			From DetalleRecepciones
			Where DetalleRecepciones.IdDetalleAcopios=DetAco.IdDetalleAcopios)
		Else 0
	End,
	Null
 FROM DetalleAcopios DetAco
 LEFT OUTER JOIN Acopios ON DetAco.IdAcopio = Acopios.IdAcopio WHERE Acopios.IdObra is not null And 
	(@IdObra=-1 or Acopios.IdObra=@IdObra) And 
	(@IdEquipo=-1 or DetAco.IdEquipo=@IdEquipo) 

 UNION ALL 

 SELECT 
	DetalleAcopios.IdEquipo,
	Acopios.IdObra,
	'LA',
	40,
	Null,
	DetalleAcopios.IdDetalleAcopios,
	Null,
	Acopios.NumeroAcopio,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	DetPed.IdDetallePedido,
	'Nota de pedido',
	Convert(Varchar,Pedidos.NumeroPedido)+' / '+Convert(Varchar,Pedidos.SubNumero),
	DetPed.Cantidad,
	DetPed.FechaNecesidad,
	DetPed.FechaEntrega,
	Empleados.Nombre,
	Null,
	Null,
	Null
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN DetalleAcopios ON DetalleAcopios.IdDetalleAcopios = DetPed.IdDetalleAcopios
 LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN Empleados ON Pedidos.IdComprador = Empleados.IdEmpleado
 WHERE DetPed.IdDetalleAcopios is not null And Acopios.IdObra is not null And 
	(@IdObra=-1 or Acopios.IdObra=@IdObra) And 
	(@IdEquipo=-1 or DetalleAcopios.IdEquipo=@IdEquipo)




