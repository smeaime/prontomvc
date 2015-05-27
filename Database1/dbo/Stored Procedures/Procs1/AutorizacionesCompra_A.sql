
CREATE Procedure [dbo].[AutorizacionesCompra_A]

@IdAutorizacionCompra int output,
@Numero int,
@Fecha datetime,
@IdObra int,
@IdProveedor int, 
@Observaciones ntext,
@IdRealizo int,
@IdAprobo int,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@CircuitoFirmasCompleto varchar(2)

AS 

BEGIN TRAN

BEGIN
	SET @Numero=IsNull((Select Top 1 ProximoNumeroAutorizacionCompra From Obras Where IdObra=@IdObra),1)
	UPDATE Obras
	SET ProximoNumeroAutorizacionCompra=@Numero+1
	WHERE IdObra=@IdObra
END

INSERT INTO AutorizacionesCompra
(
 Numero,
 Fecha,
 IdObra,
 IdProveedor,
 Observaciones,
 IdRealizo,
 IdAprobo,
 IdUsuarioIngreso,
 FechaIngreso,
 IdUsuarioModifico,
 FechaModifico,
 CircuitoFirmasCompleto
)
VALUES 
(
 @Numero,
 @Fecha,
 @IdObra,
 @IdProveedor,
 @Observaciones,
 @IdRealizo,
 @IdAprobo,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,
 @CircuitoFirmasCompleto
)

SELECT @IdAutorizacionCompra=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdAutorizacionCompra)
