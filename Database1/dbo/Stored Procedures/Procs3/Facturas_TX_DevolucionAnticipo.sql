
CREATE  Procedure [dbo].[Facturas_TX_DevolucionAnticipo]

@IdDetalleOrdenCompra int

AS 

DECLARE @IdOrdenCompra int, @IdRubroAnticipos int
SET @IdOrdenCompra=IsNull((Select Top 1 IdOrdenCompra
				From DetalleOrdenesCompra
				Where IdDetalleOrdenCompra=@IdDetalleOrdenCompra),0)
SET @IdRubroAnticipos=IsNull((Select Top 1 Convert(integer,Valor)
				From Parametros2
				Where Campo='IdRubroAnticipos'),0)

SELECT Sum(IsNull(Det.Cantidad,0) * IsNull(Det.PrecioUnitario,0) * 
	(1-(IsNull(Det.Bonificacion,0)/100))) as [Importe],
	Sum(IsNull(Det.PorcentajeCertificacion,0)) as [PorcentajeCertificacion]
FROM DetalleFacturas Det 
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura
WHERE Exists(Select Top 1 IdDetalleFacturaOrdenesCompra
		From DetalleFacturasOrdenesCompra Det1
		Left Outer Join DetalleOrdenesCompra doc On Det1.IdDetalleOrdenCompra = doc.IdDetalleOrdenCompra
		Where Det1.IdDetalleFactura=Det.IdDetalleFactura and Det1.IdDetalleOrdenCompra=@IdDetalleOrdenCompra) and 
	Det.IdArticulo In(Select A1.IdArticulo From Articulos A1 Where A1.IdRubro=@IdRubroAnticipos) and 
	Det.Cantidad>=0 and IsNull(Facturas.Anulada,'NO')<>'SI'
