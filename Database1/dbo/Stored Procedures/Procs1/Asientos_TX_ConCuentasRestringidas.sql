CREATE Procedure [dbo].[Asientos_TX_ConCuentasRestringidas]

@IdAsiento int,
@IdUsuario int = Null

AS 

SET @IdUsuario=IsNull(@IdUsuario,-1)

SELECT IdAsiento
FROM DetalleAsientos
WHERE IdAsiento=@IdAsiento and
		(@IdUsuario=-1 or Exists(Select aepu.IdCuenta From AutorizacionesEspecialesPorUsuario aepu Where aepu.IdUsuario=@IdUsuario and aepu.IdCuenta=DetalleAsientos.IdCuenta))





























