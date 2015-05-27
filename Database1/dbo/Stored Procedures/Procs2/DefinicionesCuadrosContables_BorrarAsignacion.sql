



CREATE Procedure [dbo].[DefinicionesCuadrosContables_BorrarAsignacion]

@IdCuenta int,
@IdCuentaIE int,
@TipoCuenta varchar(1)

AS 

IF @TipoCuenta='I'
 BEGIN
	UPDATE DefinicionesCuadrosContables
	SET IdCuentaIngreso=Null
	WHERE DefinicionesCuadrosContables.IdCuenta=@IdCuenta and 
		DefinicionesCuadrosContables.IdCuentaIngreso=@IdCuentaIE
 END
ELSE
 BEGIN
	UPDATE DefinicionesCuadrosContables
	SET IdCuentaEgreso=0
	WHERE DefinicionesCuadrosContables.IdCuenta=@IdCuenta and 
		DefinicionesCuadrosContables.IdCuentaEgreso=@IdCuentaIE
 END



