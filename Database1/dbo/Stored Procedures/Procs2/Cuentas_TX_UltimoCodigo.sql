CREATE Procedure [dbo].[Cuentas_TX_UltimoCodigo]

@JerarquiaMaxima varchar(1) = Null

AS 

SET @JerarquiaMaxima=IsNull(@JerarquiaMaxima,'')

SELECT TOP 1 IdCuenta,Codigo
FROM Cuentas
WHERE (@JerarquiaMaxima='' or Substring(Jerarquia,1,1)<=@JerarquiaMaxima)
ORDER BY Codigo DESC
