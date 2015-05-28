CREATE Procedure [dbo].[NotasCredito_ActualizarCampos]

@IdNotaCredito int,
@IdProvinciaDestino int,
@IdObra int,
@NoIncluirEnCubos varchar(2),
@Observaciones ntext,
@IdPuntoVenta int = Null,
@FechaNotaCredito datetime = Null,
@NumeroNotaCredito int = Null,
@FechaRecepcionCliente datetime = Null,
@CuentaVentaLetra varchar(1) = Null,
@CuentaVentaPuntoVenta int = Null,
@CuentaVentaNumero int = Null,
@IdTipoOperacion int = Null

AS

SET @IdPuntoVenta=IsNull(@IdPuntoVenta,0)
SET @FechaNotaCredito=IsNull(@FechaNotaCredito,0)
SET @NumeroNotaCredito=IsNull(@NumeroNotaCredito,0)
SET @FechaRecepcionCliente=IsNull(@FechaRecepcionCliente,@FechaNotaCredito)

DECLARE @PuntoVenta int

SET @PuntoVenta=IsNull((Select Top 1 PuntoVenta From PuntosVenta Where IdPuntoVenta=@IdPuntoVenta),0)

UPDATE NotasCredito
SET 
 IdProvinciaDestino=Case When @IdProvinciaDestino=-1 Then Null Else @IdProvinciaDestino End,
 IdObra=Case When @IdObra=-1 Then Null Else @IdObra End,
 NoIncluirEnCubos=@NoIncluirEnCubos,
 Observaciones=@Observaciones,
 FechaRecepcionCliente=@FechaRecepcionCliente,
 CuentaVentaLetra=Case When IsNull(@CuentaVentaNumero,0)=0 Then Null Else @CuentaVentaLetra End,
 CuentaVentaPuntoVenta=Case When IsNull(@CuentaVentaNumero,0)=0 Then Null Else @CuentaVentaPuntoVenta End,
 CuentaVentaNumero=Case When IsNull(@CuentaVentaNumero,0)=0 Then Null Else @CuentaVentaNumero End,
 IdTipoOperacion=Case When IsNull(@IdTipoOperacion,0)=0 Then Null Else @IdTipoOperacion End
WHERE (IdNotaCredito=@IdNotaCredito)

IF @IdPuntoVenta>0 
   BEGIN
	UPDATE NotasCredito
	SET IdPuntoVenta=@IdPuntoVenta, PuntoVenta=@PuntoVenta
	WHERE (IdNotaCredito=@IdNotaCredito)
   END

IF @FechaNotaCredito>0
   BEGIN
	UPDATE NotasCredito
	SET FechaNotaCredito=@FechaNotaCredito
	WHERE IdNotaCredito=@IdNotaCredito

	UPDATE Subdiarios
	SET FechaComprobante=@FechaNotaCredito
	WHERE IdComprobante=@IdNotaCredito and IdTipoComprobante=4

	UPDATE CuentasCorrientesDeudores
	SET Fecha=@FechaNotaCredito
	WHERE IdComprobante=@IdNotaCredito and IdTipoComp=4
   END

IF @NumeroNotaCredito>0
   BEGIN
	UPDATE NotasCredito
	SET NumeroNotaCredito=@NumeroNotaCredito
	WHERE IdNotaCredito=@IdNotaCredito

	UPDATE Subdiarios
	SET NumeroComprobante=@NumeroNotaCredito
	WHERE IdComprobante=@IdNotaCredito and IdTipoComprobante=4

	UPDATE CuentasCorrientesDeudores
	SET NumeroComprobante=@NumeroNotaCredito
	WHERE IdComprobante=@IdNotaCredito and IdTipoComp=4
   END

RETURN(@IdNotaCredito)