
CREATE PROCEDURE [dbo].[DetPedidosSAT_TXPed]

@IdPedido int

AS

declare @vector_X varchar(70),@vector_T varchar(70)
set @vector_X='00100111011011111111111101000111110000000000001111161133'
set @vector_T='00000011000020444333333400000531310000000000003992930600'

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
 Requerimientos.IdObra as [IdObra],
 DetPed.Adjunto,
 DetPed.ArchivoAdjunto,
 DetPed.Observaciones,
 Null as [Nro.Acopio],
 Null as [It.LA],
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
 Obras.NumeroObra as [Obra],
 (Select top 1 Equipos.Descripcion From Equipos
	Where Equipos.IdEquipo=DetalleRequerimientos.IdEquipo) as [Equipo],
 (Select top 1 Clientes.RazonSocial From Clientes
	Where Clientes.IdCliente=(Select Top 1 Obras.IdCliente From Obras
					Where Obras.IdObra=Requerimientos.IdObra)) as [Cliente],
 DetPed.Costo,
 DetPed.IdDetallePedido as [IdAux],
 DetPed.CostoAsignado as [Costo Asig.],
 (Select Top 1 Empleados.Nombre 
	From Empleados
	Where Empleados.IdEmpleado=DetPed.IdUsuarioAsignoCosto) as [Costo asignado por],
 DetPed.FechaAsignacionCosto as [Fecha asig.costo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidosSAT DetPed
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN ControlesCalidad ON DetPed.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
WHERE (DetPed.IdPedido = @IdPedido)
ORDER by DetPed.NumeroItem
