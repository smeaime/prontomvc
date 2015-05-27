



CREATE PROCEDURE [dbo].[Presupuestos_TX_DetallesPorIdPresupuesto]

@IdPresupuesto int

AS

SELECT
 DetPre.IdDetallePresupuesto,
 DetPre.IdPresupuesto,
 DetPre.NumeroItem as [Item],
 DetPre.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPre.Cantidad,
 DetPre.IdUnidad,
 Unidades.Descripcion as [Unidad],
 DetPre.Cantidad1 as [Med1],
 DetPre.Cantidad2 as [Med2],
 DetPre.Precio as [Prec.Unit.],
 (DetPre.Cantidad*DetPre.Precio) as [Subtotal],
 DetPre.PorcentajeBonificacion as [% Bon],
 DetPre.ImporteBonificacion as [Bonif.],
 Case 	When DetPre.ImporteBonificacion is null 
	 Then (DetPre.Cantidad*DetPre.Precio) 
	Else (DetPre.Cantidad*DetPre.Precio)-DetPre.ImporteBonificacion
 End as [Subtotal grav.],
 DetPre.PorcentajeIVA as [% IVA],
 DetPre.ImporteIVA as [IVA],
 DetPre.ImporteTotalItem as [Importe],
 DetPre.Adjunto,
 DetPre.Observaciones,
 DetPre.OrigenDescripcion,
 Case 	When DetPre.IdDetalleAcopios is not null Then 'LA'
 	When DetPre.IdDetalleRequerimiento is not null Then 'RM'
	Else Null
 End as [Tipo],
 Case 	When DetPre.IdDetalleAcopios is not null Then Acopios.NumeroAcopio
 	When DetPre.IdDetalleRequerimiento is not null Then Requerimientos.NumeroRequerimiento
	Else Null
 End as [Numero],
 Case 	When DetPre.IdDetalleAcopios is not null 
	 Then (Select Obras.NumeroObra From Obras Where Obras.IdObra=Acopios.IdObra)
 	When DetPre.IdDetalleRequerimiento is not null 
	 Then (Select Obras.NumeroObra From Obras Where Obras.IdObra=Requerimientos.IdObra)
	Else Null
 End as [NumeroObra],
 Case 	When DetPre.IdDetalleAcopios is not null 
	 Then (Select Obras.Descripcion From Obras Where Obras.IdObra=Acopios.IdObra)
 	When DetPre.IdDetalleRequerimiento is not null 
	 Then (Select Obras.Descripcion From Obras Where Obras.IdObra=Requerimientos.IdObra)
	Else Null
 End as [Obra]
FROM DetallePresupuestos DetPre
LEFT OUTER JOIN Articulos ON DetPre.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetPre.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN DetalleAcopios ON DetalleAcopios.IdDetalleAcopios=DetPre.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON Acopios.IdAcopio=DetalleAcopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetalleRequerimientos.IdDetalleRequerimiento=DetPre.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetalleRequerimientos.IdRequerimiento
WHERE (DetPre.IdPresupuesto = @IdPresupuesto)
ORDER BY DetPre.NumeroItem



