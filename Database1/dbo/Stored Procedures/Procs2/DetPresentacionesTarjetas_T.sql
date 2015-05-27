CREATE Procedure [dbo].[DetPresentacionesTarjetas_T]

@IdDetallePresentacionTarjeta int

AS 

SELECT *
FROM [DetallePresentacionesTarjetas]
WHERE (IdDetallePresentacionTarjeta=@IdDetallePresentacionTarjeta)