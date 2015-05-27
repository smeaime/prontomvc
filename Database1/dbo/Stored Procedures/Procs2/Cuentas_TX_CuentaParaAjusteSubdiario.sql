
CREATE Procedure [dbo].[Cuentas_TX_CuentaParaAjusteSubdiario]
@IdCuenta int
AS 
IF IsNull((Select Top 1 Substring(IsNull(C.Jerarquia,'0'),1,1)
		From Cuentas C Where C.IdCuenta=@IdCuenta),'0')>'5'
	SELECT 1 as [Valor]
ELSE
IF IsNull((Select Top 1 tcg.AjustarDiferenciasEnSubdiarios 
		From Cuentas C 
		Left Outer Join TiposCuentaGrupos tcg On tcg.IdTipoCuentaGrupo=C.IdTipoCuentaGrupo
		Where C.IdCuenta=@IdCuenta),'NO')='SI'
	SELECT 1 as [Valor]
ELSE
SELECT 0 as [Valor]

