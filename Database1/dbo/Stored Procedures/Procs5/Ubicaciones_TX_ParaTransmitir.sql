
CREATE Procedure [dbo].[Ubicaciones_TX_ParaTransmitir]

@IdObra int

AS 

SELECT 
 Ubicaciones.*
FROM Ubicaciones
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito=Depositos.IdDeposito
WHERE @IdObra<=0 or IsNull(Depositos.IdObra,-1)=@IdObra
