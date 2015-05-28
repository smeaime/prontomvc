
CREATE Procedure [dbo].[Cuentas_TX_ResultadoCierreAnterior]

@NumeroAsientoCierre int

AS 

SET NOCOUNT ON
DECLARE @IdCuentaResultadosEjercicio int
SET @IdCuentaResultadosEjercicio=(Select Top 1 Parametros.IdCuentaResultadosEjercicio From Parametros
					Where Parametros.IdParametro=1)
SET NOCOUNT OFF

SELECT 
 DetAsi.IdCuenta,
 DetAsi.Haber,
 DetAsi.Debe
FROM DetalleAsientos DetAsi
LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = DetAsi.IdAsiento
WHERE Asientos.NumeroAsiento=@NumeroAsientoCierre and 
	DetAsi.IdCuenta=@IdCuentaResultadosEjercicio
