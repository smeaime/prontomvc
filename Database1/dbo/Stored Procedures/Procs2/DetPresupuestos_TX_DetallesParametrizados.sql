



CREATE PROCEDURE [dbo].[DetPresupuestos_TX_DetallesParametrizados]

@IdPresupuesto int,
@NivelParametrizacion int

AS

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='00110111111111111110000133'
	Set @vector_T='00190201099132232220000900'
   END
ELSE
   BEGIN
	Set @vector_X='00110111111111111110000133'
	Set @vector_T='00190201022132232220000900'
   END

SELECT
 DetPre.IdDetallePresupuesto,
 DetPre.IdPresupuesto,
 DetPre.NumeroItem as [Item],
 DetPre.IdDetallePresupuesto as [IdAux],
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



