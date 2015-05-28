
CREATE Procedure [dbo].[CuentasGastos_TL]

AS 

SELECT IdCuentaGasto, Descripcion as [Titulo]
FROM CuentasGastos
WHERE IsNull(Titulo,'')<>'SI'
ORDER BY Descripcion
