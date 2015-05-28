
CREATE Procedure [dbo].[Depositos_TX_ParaTransmitir]

@IdObra int

AS 

SELECT *
FROM Depositos
WHERE @IdObra<=0 or IsNull(Depositos.IdObra,-1)=@IdObra
