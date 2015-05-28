CREATE Procedure [dbo].[Remitos_TX_DetallesPorIdRemito]

@IdRemito int

AS 

SELECT 
 DetalleRemitos.*,
 Articulos.Codigo as [CodigoArticulo],
 Articulos.Descripcion as [Articulo],
 Articulos.CostoPPP,
 Articulos.AlicuotaIVA,
 Unidades.Descripcion as [Unidad],
 (Select Top 1 doc.Precio From DetalleOrdenesCompra doc Where doc.IdDetalleOrdenCompra = DetalleRemitos.IdDetalleOrdenCompra) as [PrecioOrdenCompra],
 (Select Top 1 OrdenesCompra.IdMoneda  From DetalleOrdenesCompra doc
  Left Outer Join OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
  Where doc.IdDetalleOrdenCompra = DetalleRemitos.IdDetalleOrdenCompra) as [IdMoneda],
 (Select Top 1 OrdenesCompra.PorcentajeBonificacion 
  From DetalleOrdenesCompra doc
  Left Outer Join OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
  Where doc.IdDetalleOrdenCompra = DetalleRemitos.IdDetalleOrdenCompra) as [PorcentajeBonificacionOC],
 (Select Top 1 doc.PorcentajeBonificacion 
  From DetalleOrdenesCompra doc
  Where doc.IdDetalleOrdenCompra = DetalleRemitos.IdDetalleOrdenCompra) as [PorcentajeBonificacion],
 (Select Top 1 Colores.Descripcion
  From DetalleOrdenesCompra doc
  Left Outer Join Colores ON doc.IdColor = Colores.IdColor
  Where doc.IdDetalleOrdenCompra = DetalleRemitos.IdDetalleOrdenCompra) as [Color],
 Case When IsNull(DetalleRemitos.TipoCancelacion,1)=1
	Then DetalleRemitos.Cantidad-
		Isnull((Select Sum(df.Cantidad) From DetalleFacturasRemitos dfr
			Left Outer Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
			Left Outer Join Facturas On Facturas.IdFactura=dfr.IdFactura
			Where dfr.IdDetalleRemito=DetalleRemitos.IdDetalleRemito and IsNull(Facturas.Anulada,'')<>'SI'),0)
	Else 100-Isnull((Select Sum(df.PorcentajeCertificacion) From DetalleFacturasRemitos dfr
			Left Outer Join DetalleFacturas df On df.IdDetalleFactura=dfr.IdDetalleFactura
			Left Outer Join Facturas On Facturas.IdFactura=dfr.IdFactura
			Where dfr.IdDetalleRemito=DetalleRemitos.IdDetalleRemito and IsNull(Facturas.Anulada,'')<>'SI'),0)
 End as [AFacturar],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+Convert(varchar,IsNull(Remitos.PuntoVenta,0))+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Remito],
 Colores.Codigo2 as [CodigoColor],
 Colores.Descripcion as [Color]
FROM DetalleRemitos 
LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
LEFT OUTER JOIN Articulos ON DetalleRemitos.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetalleRemitos.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON Colores.IdColor = DetalleRemitos.IdColor
WHERE (DetalleRemitos.IdRemito = @IdRemito)