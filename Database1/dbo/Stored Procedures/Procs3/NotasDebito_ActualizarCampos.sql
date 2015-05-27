
CREATE Procedure [dbo].[NotasDebito_ActualizarCampos]

@IdNotaDebito int,
@IdProvinciaDestino int,
@IdObra int,
@NoIncluirEnCubos varchar(2),
@Observaciones ntext,
@IdPuntoVenta int = Null,
@FechaNotaDebito datetime = Null,
@NumeroNotaDebito int = Null

AS

SET @IdPuntoVenta=IsNull(@IdPuntoVenta,0)
SET @FechaNotaDebito=IsNull(@FechaNotaDebito,0)
SET @NumeroNotaDebito=IsNull(@NumeroNotaDebito,0)

DECLARE @PuntoVenta int

SET @PuntoVenta=IsNull((Select Top 1 PuntoVenta From PuntosVenta Where IdPuntoVenta=@IdPuntoVenta),0)

UPDATE NotasDebito
SET 
 IdProvinciaDestino=Case When @IdProvinciaDestino=-1 Then Null Else @IdProvinciaDestino End,
 IdObra=Case When @IdObra=-1 Then Null Else @IdObra End,
 NoIncluirEnCubos=@NoIncluirEnCubos,
 Observaciones=@Observaciones
WHERE (IdNotaDebito=@IdNotaDebito)

IF @IdPuntoVenta>0 
   BEGIN
	UPDATE NotasDebito
	SET IdPuntoVenta=@IdPuntoVenta, PuntoVenta=@PuntoVenta
	WHERE (IdNotaDebito=@IdNotaDebito)
   END

IF @FechaNotaDebito>0
   BEGIN
	UPDATE NotasDebito
	SET FechaNotaDebito=@FechaNotaDebito
	WHERE (IdNotaDebito=@IdNotaDebito)

	UPDATE Subdiarios
	SET FechaComprobante=@FechaNotaDebito
	WHERE IdComprobante=@IdNotaDebito and IdTipoComprobante=3

	UPDATE CuentasCorrientesDeudores
	SET Fecha=@FechaNotaDebito
	WHERE IdComprobante=@IdNotaDebito and IdTipoComp=3
   END

IF @NumeroNotaDebito>0
   BEGIN
	UPDATE NotasDebito
	SET NumeroNotaDebito=@NumeroNotaDebito
	WHERE (IdNotaDebito=@IdNotaDebito)

	UPDATE Subdiarios
	SET NumeroComprobante=@NumeroNotaDebito
	WHERE IdComprobante=@IdNotaDebito and IdTipoComprobante=3

	UPDATE CuentasCorrientesDeudores
	SET NumeroComprobante=@NumeroNotaDebito
	WHERE IdComprobante=@IdNotaDebito and IdTipoComp=3
   END

RETURN(@IdNotaDebito)
