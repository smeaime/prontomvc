CREATE Procedure [dbo].[PresentacionesTarjetas_M]

@IdPresentacionTarjeta int,
@IdTarjetaCredito int,
@NumeroPresentacion int,
@FechaIngreso datetime,
@Observaciones ntext,
@IdRealizo int

AS

UPDATE PresentacionesTarjetas
SET
 IdTarjetaCredito=@IdTarjetaCredito,
 NumeroPresentacion=@NumeroPresentacion,
 FechaIngreso=@FechaIngreso,
 Observaciones=@Observaciones,
 IdRealizo=@IdRealizo
WHERE (IdPresentacionTarjeta=@IdPresentacionTarjeta)

RETURN(@IdPresentacionTarjeta)