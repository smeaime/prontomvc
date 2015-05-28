CREATE Procedure [dbo].[PresentacionesTarjetas_T]

@IdPresentacionTarjeta int

AS 

SELECT * 
FROM PresentacionesTarjetas
WHERE (IdPresentacionTarjeta=@IdPresentacionTarjeta)