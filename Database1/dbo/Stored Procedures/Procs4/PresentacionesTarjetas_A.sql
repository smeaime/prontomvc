CREATE Procedure [dbo].[PresentacionesTarjetas_A]

@IdPresentacionTarjeta int  output,
@IdTarjetaCredito int,
@NumeroPresentacion int,
@FechaIngreso datetime,
@Observaciones ntext,
@IdRealizo int

AS

INSERT INTO PresentacionesTarjetas
(
 IdTarjetaCredito,
 NumeroPresentacion,
 FechaIngreso,
 Observaciones,
 IdRealizo
)
VALUES
(
 @IdTarjetaCredito,
 @NumeroPresentacion,
 @FechaIngreso,
 @Observaciones,
 @IdRealizo
)

SELECT @IdPresentacionTarjeta=@@identity

RETURN(@IdPresentacionTarjeta)