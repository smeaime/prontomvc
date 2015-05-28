




CREATE PROCEDURE [dbo].[ComprobantesProveedores_TX_DistribucionPorIdPedido]

@IdComprobanteProveedor int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdComprobanteProveedor INTEGER,
			 IdPedido INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT
  DetCP.IdComprobanteProveedor,
  DetCP.IdPedido,
  SUM(DetCP.Importe)
 FROM DetalleComprobantesProveedores DetCP 
 WHERE DetCP.IdComprobanteProveedor = @IdComprobanteProveedor
 GROUP BY DetCP.IdComprobanteProveedor, DetCP.IdPedido

CREATE TABLE #Auxiliar2 
			(
			 IdComprobanteProveedor INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT
  DetCP.IdComprobanteProveedor,
  SUM(DetCP.Importe)
 FROM DetalleComprobantesProveedores DetCP 
 WHERE DetCP.IdComprobanteProveedor = @IdComprobanteProveedor
 GROUP BY DetCP.IdComprobanteProveedor

SET NOCOUNT OFF

SELECT
 #Auxiliar1.IdComprobanteProveedor,
 #Auxiliar1.IdPedido,
 Case When IsNull(#Auxiliar2.Importe,0)<>0 
	Then #Auxiliar1.Importe / #Auxiliar2.Importe
	Else 1
 End as [Porcentaje]
FROM #Auxiliar1
LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar1.IdComprobanteProveedor = #Auxiliar2.IdComprobanteProveedor
ORDER BY #Auxiliar1.IdPedido

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2




