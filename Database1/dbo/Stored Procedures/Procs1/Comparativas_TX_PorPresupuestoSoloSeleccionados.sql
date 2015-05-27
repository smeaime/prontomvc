



CREATE  Procedure [dbo].[Comparativas_TX_PorPresupuestoSoloSeleccionados]
@IdComparativa int,
@IdPresupuesto int
AS 
Select 
 dc.*,
 Articulos.Descripcion
From DetalleComparativas dc
Left Outer Join Articulos On Articulos.IdArticulo=dc.IdArticulo
Where   dc.IdComparativa=@IdComparativa And dc.IdPresupuesto=@IdPresupuesto And 
	dc.Estado='MR'



