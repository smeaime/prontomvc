


CREATE PROCEDURE [dbo].[DetPedidos_TX_Simplificados]

@IdPedido int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111118811133'
set @vector_T='0091H1D121IF00'

SELECT
 DetPed.IdDetallePedido,
 DetPed.NumeroItem as [Item],
 DetPed.IdDetallePedido as [IdAux1],
 DetPed.Cantidad as [Cant.],
 (Select IsNull(Unidades.Abreviatura,Unidades.Descripcion)
	From Unidades
	Where Unidades.IdUnidad=DetPed.IdUnidad) as  [Un.],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPed.Precio,
 DetPed.ImporteTotalItem as [Imp.Total],
 Requerimientos.NumeroRequerimiento as [Nro.RM],
 DetalleRequerimientos.NumeroItem as [It.RM],
 (Select top 1 Empleados.Nombre From Empleados
	Where Empleados.IdEmpleado=Requerimientos.IdSolicito) as [RM solicitada por],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePedidos DetPed
LEFT OUTER JOIN Articulos ON DetPed.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE (DetPed.IdPedido = @IdPedido)
ORDER by DetPed.NumeroItem


