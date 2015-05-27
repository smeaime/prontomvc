CREATE Procedure [dbo].[Depositos_TX_PorIdObraParaCombo]

@IdObra int

AS 

SELECT IdDeposito,Descripcion as Titulo
FROM Depositos 
WHERE @IdObra=-1 or IsNull(IdObra,0)=@IdObra
ORDER by Descripcion