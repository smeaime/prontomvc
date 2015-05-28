CREATE Procedure [dbo].[DetPresentacionesTarjetas_E]

@IdDetallePresentacionTarjeta int  

AS

DECLARE @IdValor int

SET @IdValor=IsNull((Select Top 1 IdValor From DetallePresentacionesTarjetas Where IdDetallePresentacionTarjeta=@IdDetallePresentacionTarjeta),0)

UPDATE Valores
SET IdDetallePresentacionTarjeta=Null
WHERE IdValor=@IdValor

DELETE [DetallePresentacionesTarjetas]
WHERE (IdDetallePresentacionTarjeta=@IdDetallePresentacionTarjeta)