



















CREATE Procedure [dbo].[Acopios_TX_TodosLosDetalles]

@IdAcopio int

As 

Select
 DetAco.*,
 Acopios.NumeroAcopio,
 (Select Sum(DetalleRecepciones.Cantidad) 
	From DetalleRecepciones 
	Where DetalleRecepciones.IdDetalleAcopios=DetAco.IdDetalleAcopios) as [Entregado],
 Case	
	When	(Select Sum(DetalleRecepciones.Cantidad) 
		From DetalleRecepciones 
		Where DetalleRecepciones.IdDetalleAcopios=DetAco.IdDetalleAcopios) is not null
	Then	(DetAco.Cantidad - (Select Sum(DetalleRecepciones.Cantidad) 
					From DetalleRecepciones 
					Where DetalleRecepciones.IdDetalleAcopios=DetAco.IdDetalleAcopios))
	Else	DetAco.Cantidad
 End as [Pendiente],
 Acopios.IdObra as [IdObra],
 Obras.NumeroObra as [Obra],
 Articulos.Descripcion as [DescripcionArt],
 Articulos.Codigo
From DetalleAcopios DetAco
Left Outer Join Acopios On Acopios.IdAcopio=DetAco.IdAcopio
Left Outer Join Obras On Acopios.IdObra = Obras.IdObra
Left Outer Join Articulos On DetAco.IdArticulo = Articulos.IdArticulo
Where DetAco.IdAcopio=@IdAcopio
Order By DetAco.NumeroItem




















