










CREATE PROCEDURE [dbo].[Facturas_TX_TraerIdObraDesdeIdDetalleFactura]

@IdDetalleFactura int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	(
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT TOP 1 
  OrdenesCompra.IdObra
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE dfoc.IdDetalleFactura=@IdDetalleFactura and OrdenesCompra.IdObra is not null

 UNION ALL

 SELECT TOP 1 
  DetalleRemitos.IdObra
 FROM DetalleFacturasRemitos DetFacRem
 LEFT OUTER JOIN DetalleRemitos ON DetFacRem.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
 WHERE DetFacRem.IdDetalleFactura=@IdDetalleFactura and DetalleRemitos.IdObra is not null

SET NOCOUNT OFF

 SELECT TOP 1 
  #Auxiliar1.IdObra,
  Obras.NumeroObra
 FROM #Auxiliar1 
 LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
 WHERE #Auxiliar1.IdObra is not null

DROP TABLE #Auxiliar1










