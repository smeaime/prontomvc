CREATE Procedure [dbo].[Facturas_TX_PorIdConDatos]

@IdFactura int

AS 

SELECT 
 Facturas.*,
 IsNull(Facturas.IdObra,0) as [IdObra],
 IsNull(Obras.NumeroObra,'') as [NumeroObra],
 Case When IsNull((Select Count(Distinct DetalleRemitos.IdRemito)
			From DetalleFacturasRemitos Det 
			Left Outer Join DetalleRemitos On Det.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
			Where Det.IdFactura=@IdFactura),0)<=1 
	Then IsNull((Select Top 1 Convert(varchar,Remitos.NumeroRemito)
			From DetalleFacturasRemitos Det 
			Left Outer Join DetalleRemitos On Det.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
			Left Outer Join Remitos On DetalleRemitos.IdRemito = Remitos.IdRemito
			Where Det.IdFactura=@IdFactura),'')
	Else 'Varios'
 End as [Remito],
 IsNull(PuntosVenta.WebService,'') as [WebService],
 IsNull(Clientes.email,'') as [Email]
 FROM Facturas
LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Obras ON Obras.IdObra=Facturas.IdObra
LEFT OUTER JOIN PuntosVenta ON PuntosVenta.IdPuntoVenta=Facturas.IdPuntoVenta
WHERE (IdFactura=@IdFactura)