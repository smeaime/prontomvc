



CREATE PROCEDURE [dbo].[DetPedidos_TX_DetallesParametrizados]

@IdPedido int,
@NivelParametrizacion int

AS

Declare @vector_X varchar(100),@vector_T varchar(100)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='001001110110111111111111010001111100000000000011111661111133'
	Set @vector_T='000000990090204443333334000005993100000000000039929999911900'
   END
ELSE
   BEGIN
	Set @vector_X='001001110110111111111111010001111100000000000011111661111133'
	Set @vector_T='000000110000204443333334000005313100000000000039929340611900'
   END

SELECT
 DetPed.IdDetallePedido,
 DetPed.IdPedido,
 DetPed.NumeroItem as [Item],
 DetPed.IdDetalleAcopios,
 DetPed.IdDetalleRequerimiento,
 DetPed.Cantidad as [Cant.],
 DetPed.Cantidad1 as [Med.1],
 DetPed.Cantidad2 as [Med.2],
 DetPed.IdUnidad,
 (Select Unidades.Descripcion
	From Unidades
	Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Unidad en],
 Substring(ControlesCalidad.Descripcion,1,10) as [Control de Calidad],
 DetPed.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPed.FechaEntrega as [F.entrega],
 DetPed.FechaNecesidad as [F.necesidad],
 DetPed.Precio,
 (DetPed.Cantidad*DetPed.Precio) as [Subtotal],
 DetPed.PorcentajeBonificacion as [% Bon],
 DetPed.ImporteBonificacion as [Bonif.],
 Case 	When DetPed.ImporteBonificacion is null 
	 Then (DetPed.Cantidad*DetPed.Precio) 
	Else (DetPed.Cantidad*DetPed.Precio)-DetPed.ImporteBonificacion
 End as [Subtotal grav.],
 DetPed.PorcentajeIVA as [% IVA],
 DetPed.ImporteIVA as [IVA],
 DetPed.ImporteTotalItem as [Importe],
 DetPed.IdControlCalidad,
 DetPed.Cumplido as [Cum],
 Case 	When Acopios.IdObra IS NOT NULL Then  Acopios.IdObra
	When Requerimientos.IdObra IS NOT NULL Then Requerimientos.IdObra
	Else null
 End as [IdObra],
 DetPed.Adjunto,
 DetPed.ArchivoAdjunto,
 DetPed.Observaciones,
 Acopios.NumeroAcopio as [Nro.Acopio],
 DetalleAcopios.NumeroItem as [It.LA],
 Requerimientos.NumeroRequerimiento as [Nro.RM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 DetPed.IdCuenta,
 DetPed.OrigenDescripcion,
 DetPed.ArchivoAdjunto1,
 DetPed.ArchivoAdjunto2,
 DetPed.ArchivoAdjunto3,
 DetPed.ArchivoAdjunto4,
 DetPed.ArchivoAdjunto5,
 DetPed.ArchivoAdjunto6,
 DetPed.ArchivoAdjunto7,
 DetPed.ArchivoAdjunto8,
 DetPed.ArchivoAdjunto9,
 DetPed.ArchivoAdjunto10,
 Case 	When Acopios.IdObra IS NOT NULL 
	 Then (Select top 1 Obras.NumeroObra From Obras
		Where Obras.IdObra=Acopios.IdObra)
	When Requerimientos.IdObra IS NOT NULL 
	 Then (Select top 1 Obras.NumeroObra From Obras
		Where Obras.IdObra=Requerimientos.IdObra)
	Else null
 End as [Obra],
 Case 	When DetalleAcopios.IdEquipo IS NOT NULL 
	 Then (Select top 1 Equipos.Descripcion From Equipos
		Where Equipos.IdEquipo=DetalleAcopios.IdEquipo)
	When DetalleRequerimientos.IdEquipo IS NOT NULL 
	 Then (Select top 1 Equipos.Descripcion From Equipos
		Where Equipos.IdEquipo=DetalleRequerimientos.IdEquipo)
	Else null
 End as [Equipo],
 Case 	When Acopios.IdObra IS NOT NULL 
	 Then (Select top 1 Clientes.RazonSocial From Clientes
		Where Clientes.IdCliente=
			(Select Top 1 Obras.IdCliente From Obras
			 Where Obras.IdObra=Acopios.IdObra))
	When Requerimientos.IdObra IS NOT NULL 
	 Then (Select top 1 Clientes.RazonSocial From Clientes
		Where Clientes.IdCliente=
			(Select Top 1 Obras.IdCliente From Obras
			 Where Obras.IdObra=Requerimientos.IdObra))
	Else null
 End as [Cliente],
 DetPed.Costo,
 DetPed.IdDetallePedido as [IdAux],
 DetPed.CostoAsignado as [Costo Asig.],
 DetPed.CostoAsignadoDolar as [Costo Asig.u$s],
 (Select Top 1 Empleados.Nombre 
	From Empleados
	Where Empleados.IdEmpleado=DetPed.IdUsuarioAsignoCosto) as [Costo asignado por],
 DetPed.FechaAsignacionCosto as [Fecha asig.costo],
 Case 	When Acopios.IdObra IS NOT NULL 
	 Then (Select top 1 Empleados.Nombre From Empleados
		Where Empleados.IdEmpleado=Acopios.Realizo)
	When Requerimientos.IdObra IS NOT NULL 
	 Then (Select top 1 Empleados.Nombre From Empleados
		Where Empleados.IdEmpleado=Requerimientos.IdSolicito)
	Else null
 End as [RM solicitada por],
 DetPed.PlazoEntrega as [Plazo entrega],
 0 as [Reservado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetPed.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (DetPed.IdPedido = @IdPedido)
ORDER by DetPed.NumeroItem



