CREATE Procedure [dbo].[DefinicionesFlujoCaja_TX_ControlDeItems]

@IdCuenta int,
@IdRubroContable int

AS 

IF @IdCuenta>0 
	Select Cuentas.*, (Select Top 1 dfc.IdDefinicionFlujoCaja From DetalleDefinicionesFlujoCajaCuentas dfc Where dfc.IdCuenta=@IdCuenta) as [IdDefinicionFlujoCaja]
	From Cuentas
	Where Cuentas.IdCuenta=@IdCuenta
ELSE
	Select RubrosContables.*, (Select Top 1 dfc.IdDefinicionFlujoCaja From DetalleDefinicionesFlujoCajaCuentas dfc Where dfc.IdRubroContable=@IdRubroContable) as [IdDefinicionFlujoCaja]
	From RubrosContables
	Where RubrosContables.IdRubroContable=@IdRubroContable