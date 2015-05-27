


CREATE PROCEDURE [dbo].[DetPresupuestos_TXPre]

@IdPresupuesto int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='00110111111111111110000133'
Set @vector_T='00190201022132232220000900'

SELECT
 DetPre.IdDetallePresupuesto,
 DetPre.IdPresupuesto,
 DetPre.NumeroItem as [Item],
 DetPre.IdDetallePresupuesto as [IdAux1],
 DetPre.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetPre.Cantidad,
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
 DetPre.IdUnidad,
 Rubros.Descripcion as [Rubro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePresupuestos DetPre
LEFT OUTER JOIN Articulos ON DetPre.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetPre.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
WHERE (DetPre.IdPresupuesto = @IdPresupuesto)
ORDER BY DetPre.NumeroItem


