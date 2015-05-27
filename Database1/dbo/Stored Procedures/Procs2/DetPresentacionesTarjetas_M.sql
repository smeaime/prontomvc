CREATE Procedure [dbo].[DetPresentacionesTarjetas_M]

@IdDetallePresentacionTarjeta int,
@IdPresentacionTarjeta int,
@IdValor int

AS

UPDATE [DetallePresentacionesTarjetas]
SET 
 IdPresentacionTarjeta=@IdPresentacionTarjeta,
 IdValor=@IdValor
WHERE (IdDetallePresentacionTarjeta=@IdDetallePresentacionTarjeta)

RETURN(@IdDetallePresentacionTarjeta)