CREATE Procedure [dbo].[DetPresentacionesTarjetas_A]

@IdDetallePresentacionTarjeta int output,
@IdPresentacionTarjeta int,
@IdValor int

AS

INSERT INTO [DetallePresentacionesTarjetas]
(
 IdPresentacionTarjeta,
 IdValor
)
VALUES
(
 @IdPresentacionTarjeta,
 @IdValor
)

SELECT @IdDetallePresentacionTarjeta=@@identity

UPDATE Valores
SET IdDetallePresentacionTarjeta=@IdDetallePresentacionTarjeta
WHERE IdValor=@IdValor

RETURN(@IdDetallePresentacionTarjeta)