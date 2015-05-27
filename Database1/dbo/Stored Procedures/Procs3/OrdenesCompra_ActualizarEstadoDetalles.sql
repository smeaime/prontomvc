
CREATE PROCEDURE [dbo].[OrdenesCompra_ActualizarEstadoDetalles]

@IdOrdenCompra int,
@IdFactura int,
@IdNotaCredito int

AS

SET NOCOUNT ON

DECLARE @PorcentajeToleranciaOrdenesCompra numeric(6,2), @CantidadToleranciaOrdenesCompra numeric(18,2)
SET @PorcentajeToleranciaOrdenesCompra=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='PorcentajeToleranciaOrdenesCompra'),0)
SET @CantidadToleranciaOrdenesCompra=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='CantidadToleranciaOrdenesCompra'),0)

CREATE TABLE #Auxiliar0 (IdOrdenCompra INTEGER)
INSERT INTO #Auxiliar0 
 SELECT OrdenesCompra.IdOrdenCompra
 FROM OrdenesCompra 
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and OrdenesCompra.IdOrdenCompra is not null and OrdenesCompra.IdOrdenCompra=@IdOrdenCompra

 UNION ALL 

 SELECT doc.IdOrdenCompra
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
 LEFT OUTER JOIN Facturas fa On fa.IdFactura=df.IdFactura
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and OrdenesCompra.IdOrdenCompra is not null and df.IdFactura=@IdFactura

 UNION ALL 

 SELECT doc.IdOrdenCompra
 FROM DetalleNotasCreditoOrdenesCompra dncoc
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dncoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=OrdenesCompra.IdCliente
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and OrdenesCompra.IdOrdenCompra is not null and dncoc.IdNotaCredito=@IdNotaCredito


CREATE TABLE #Auxiliar1 (IdOrdenCompra INTEGER)
INSERT INTO #Auxiliar1 
 SELECT #Auxiliar0.IdOrdenCompra
 FROM #Auxiliar0
 GROUP BY #Auxiliar0.IdOrdenCompra


CREATE TABLE #Auxiliar2
			(
			 IdDetalleOrdenCompra INTEGER,
			 TipoCancelacion INTEGER,
			 CantidadOC NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2),
			 PorcentajeCertificacion NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  doc.IdDetalleOrdenCompra,
  doc.TipoCancelacion,
  IsNull(doc.Cantidad,0),
  0,
  0
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN #Auxiliar1 ON doc.IdOrdenCompra = #Auxiliar1.IdOrdenCompra
 WHERE  IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and IsNull(#Auxiliar1.IdOrdenCompra,0)=doc.IdOrdenCompra and doc.IdDioPorCumplido is null

 UNION ALL

 SELECT 
  dfoc.IdDetalleOrdenCompra,
  doc.TipoCancelacion,
  0,
  IsNull(df.Cantidad,0),
  IsNull(df.PorcentajeCertificacion,0)
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN #Auxiliar1 ON doc.IdOrdenCompra = #Auxiliar1.IdOrdenCompra
 LEFT OUTER JOIN DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
 LEFT OUTER JOIN Facturas fa On fa.IdFactura=df.IdFactura
 WHERE  IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and IsNull(#Auxiliar1.IdOrdenCompra,0)=doc.IdOrdenCompra and 
	IsNull(fa.Anulada,'NO')<>'SI' and doc.IdDioPorCumplido is null

 UNION ALL

 SELECT 
  dncoc.IdDetalleOrdenCompra,
  doc.TipoCancelacion,
  0,
  IsNull(dncoc.Cantidad,0) * -1,
  IsNull(dncoc.PorcentajeCertificacion,0) * -1
 FROM DetalleNotasCreditoOrdenesCompra dncoc
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dncoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN #Auxiliar1 ON doc.IdOrdenCompra = #Auxiliar1.IdOrdenCompra
 LEFT OUTER JOIN NotasCredito nc On nc.IdNotaCredito=dncoc.IdNotaCredito
 WHERE  IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and IsNull(#Auxiliar1.IdOrdenCompra,0)=doc.IdOrdenCompra and 
	IsNull(nc.Anulada,'NO')<>'SI' and doc.IdDioPorCumplido is null


CREATE TABLE #Auxiliar3
			(
			 IdDetalleOrdenCompra INTEGER,
			 TipoCancelacion INTEGER,
			 CantidadOC NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2),
			 PorcentajeCertificacion NUMERIC(18, 2),
			 Cumplido VARCHAR(2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.IdDetalleOrdenCompra,
  #Auxiliar2.TipoCancelacion,
  SUM(#Auxiliar2.CantidadOC),
  SUM(#Auxiliar2.Cantidad),
  SUM(#Auxiliar2.PorcentajeCertificacion),
  Null
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdDetalleOrdenCompra, #Auxiliar2.TipoCancelacion

UPDATE #Auxiliar3
SET Cumplido='SI'
WHERE (TipoCancelacion=1 and CantidadOC<=Cantidad+
		Case When Cantidad*@PorcentajeToleranciaOrdenesCompra/100<@CantidadToleranciaOrdenesCompra
			Then Cantidad*@PorcentajeToleranciaOrdenesCompra/100
			Else @CantidadToleranciaOrdenesCompra
		End) or 
	(TipoCancelacion=2 and PorcentajeCertificacion>=100-@PorcentajeToleranciaOrdenesCompra)

UPDATE DetalleOrdenesCompra
SET Cumplido=(Select Top 1 #Auxiliar3.Cumplido
		From #Auxiliar3 
		Where DetalleOrdenesCompra.IdDetalleOrdenCompra=#Auxiliar3.IdDetalleOrdenCompra)
WHERE IsNull(FacturacionAutomatica,'NO')<>'SI' and 
	Exists(Select Top 1 #Auxiliar3.Cumplido
		From #Auxiliar3 
		Where DetalleOrdenesCompra.IdDetalleOrdenCompra=#Auxiliar3.IdDetalleOrdenCompra)

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
