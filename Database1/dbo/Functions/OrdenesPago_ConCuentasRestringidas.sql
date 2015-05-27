CREATE FUNCTION [dbo].[OrdenesPago_ConCuentasRestringidas]
(
	@IdOrdenPago int,
	@IdUsuario int
)

RETURNS int

AS

  BEGIN
	DECLARE @i int

	SET @i=IsNull((SELECT count(*) FROM AutorizacionesEspecialesPorUsuario WHERE IdUsuario=@IdUsuario),0)
	IF @i>0
		SET @i=IsNull((SELECT count(*) 
						FROM DetalleOrdenesPagoCuentas
						INNER JOIN AutorizacionesEspecialesPorUsuario ON AutorizacionesEspecialesPorUsuario.IdUsuario=@IdUsuario and AutorizacionesEspecialesPorUsuario.IdCuenta=DetalleOrdenesPagoCuentas.IdCuenta
						WHERE IdOrdenPago=@IdOrdenPago),0)
	RETURN @i
  END
