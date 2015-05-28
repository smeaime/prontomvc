


CREATE Procedure [dbo].[Articulos_TX_ParaTransmitirPorIdRubros]
@IdRubros varchar(100)
AS 
SELECT *
FROM Articulos
WHERE EnviarEmail=1 and Patindex('%'+Convert(varchar,IdRubro)+'%', @IdRubros)<>0  


