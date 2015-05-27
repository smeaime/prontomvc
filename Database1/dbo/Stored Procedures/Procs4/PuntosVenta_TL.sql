





















CREATE Procedure [dbo].[PuntosVenta_TL]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar 	(
			 IdPuntoVenta INTEGER,
			 TiposComprobante VARCHAR(50),
			 Letra VARCHAR(1),
			 PuntoVenta INTEGER,
			 ProximoNumero INTEGER
			)
INSERT INTO #Auxiliar 
 SELECT
  IdPuntoVenta,
  TiposComprobante.Descripcion,
  Letra,
  PuntoVenta,
  ProximoNumero
FROM PuntosVenta
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=PuntosVenta.IdTipoComprobante

SET NOCOUNT OFF

SELECT
 IdPuntoVenta,
 TiposComprobante+' - '+Letra+' - '+
  Substring('0000',1,4-Len(Convert(varchar,PuntoVenta)))+Convert(varchar,PuntoVenta)+' '+
  Substring('00000000',1,8-Len(Convert(varchar,ProximoNumero)))+Convert(varchar,ProximoNumero) as [Titulo]
FROM #Auxiliar
ORDER by TiposComprobante,Letra,PuntoVenta,ProximoNumero

DROP TABLE #Auxiliar






















