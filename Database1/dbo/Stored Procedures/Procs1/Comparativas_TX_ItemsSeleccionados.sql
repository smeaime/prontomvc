





























CREATE  Procedure [dbo].[Comparativas_TX_ItemsSeleccionados]
@IdComparativa int
AS 
declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='011111111433'
set @vector_T='024040522900'
Select 
dc.IdPresupuesto,
Proveedores.RazonSocial as [Proveedor],
dc.NumeroPresupuesto as [Presupuesto],
dc.SubNumero as [Orden],
dc.FechaPresupuesto as [Fecha],
Articulos.Descripcion,
dc.Observaciones,
dc.Cantidad,
dc.Precio,
@Vector_T as Vector_T,
@Vector_X as Vector_X
From DetalleComparativas dc
Left Outer Join Articulos On Articulos.IdArticulo=dc.IdArticulo
Left Outer Join Presupuestos On Presupuestos.IdPresupuesto=dc.IdPresupuesto
Left Outer Join Proveedores On Proveedores.IdProveedor=Presupuestos.IdProveedor
Where dc.IdComparativa=@IdComparativa And dc.Estado='MR'
Order By dc.NumeroPresupuesto,dc.SubNumero,Articulos.Descripcion






























