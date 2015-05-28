CREATE Procedure [dbo].[PresentacionesTarjetas_E]

@IdPresentacionTarjeta int  

AS

DELETE PresentacionesTarjetas
WHERE (IdPresentacionTarjeta=@IdPresentacionTarjeta)