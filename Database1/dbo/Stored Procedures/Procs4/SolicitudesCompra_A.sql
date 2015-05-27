



CREATE Procedure [dbo].[SolicitudesCompra_A]
@IdSolicitudCompra int  output,
@NumeroSolicitud int,
@FechaSolicitud datetime,
@Confecciono int

AS

BEGIN TRAN

BEGIN
	Set @NumeroSolicitud=IsNull((Select Top 1 P.ProximoNumeroSolicitudCompra
					From Parametros P Where P.IdParametro=1),1)
	Update Parametros
	Set ProximoNumeroSolicitudCompra=@NumeroSolicitud+1
END

INSERT INTO SolicitudesCompra
(
 NumeroSolicitud,
 FechaSolicitud,
 Confecciono
)
Values
(
 @NumeroSolicitud,
 @FechaSolicitud,
 @Confecciono
)

SELECT @IdSolicitudCompra=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdSolicitudCompra)



