CREATE Procedure [dbo].[Cuentas_TX_PrimerCodigo]

@Orden varchar(1) = Null

AS 

SET @Orden=IsNull(@Orden,'A')

IF @Orden='A'
	SELECT TOP 1 IdCuenta, Codigo
	FROM Cuentas
	ORDER BY Codigo
ELSE
	SELECT TOP 1 IdCuenta, Codigo
	FROM Cuentas
	ORDER BY Codigo DESC