
CREATE PROCEDURE [dbo].[SalidasMateriales_TX_RecepcionesPorIdSalidaMateriales]

@IdSalidaMateriales int 

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (IdDetalleSalidaMateriales INTEGER)
INSERT INTO #Auxiliar1
 SELECT IdDetalleSalidaMateriales
 FROM DetalleSalidasMateriales
 WHERE DetalleSalidasMateriales.IdSalidaMateriales=@IdSalidaMateriales

CREATE TABLE #Auxiliar2 (IdDetalleRecepcion INTEGER)
INSERT INTO #Auxiliar2
 SELECT IdDetalleRecepcion
 FROM DetalleRecepciones
 LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
 WHERE IsNull(Recepciones.Anulada,'NO')<>'SI' and DetalleRecepciones.IdDetalleSalidaMateriales In (Select IdDetalleSalidaMateriales From #Auxiliar1)
 
SET NOCOUNT OFF

SELECT 
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+
	IsNull('/'+Convert(varchar,Recepciones.SubNumero),'') as [Recepcion],
 Recepciones.FechaRecepcion as [Fecha]
FROM #Auxiliar2
LEFT OUTER JOIN DetalleRecepciones ON DetalleRecepciones.IdDetalleRecepcion=#Auxiliar2.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
 
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
 
