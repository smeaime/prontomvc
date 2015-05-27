



CREATE Procedure [dbo].[Recibos_TX_PorEstadoValores]

@IdRecibo int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleReciboValores INTEGER,
			 Estado VARCHAR(1)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  IdDetalleReciboValores,
  (Select Top 1 Valores.Estado From Valores
   Where Valores.IdDetalleReciboValores=DetRec.IdDetalleReciboValores)
 FROM DetalleRecibosValores DetRec
 WHERE IdRecibo=@IdRecibo and DetRec.IdTipoValor<>21

SET NOCOUNT OFF

SELECT Estado
FROM #Auxiliar1
WHERE Estado is not null
GROUP BY Estado

DROP TABLE #Auxiliar1



