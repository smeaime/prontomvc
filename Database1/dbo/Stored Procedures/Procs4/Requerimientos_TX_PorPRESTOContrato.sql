


















CREATE Procedure [dbo].[Requerimientos_TX_PorPRESTOContrato]
@PRESTOContrato varchar(13)
AS 
SELECT Top 1 IdRequerimiento
FROM Requerimientos
WHERE PRESTOContrato=@PRESTOContrato



















