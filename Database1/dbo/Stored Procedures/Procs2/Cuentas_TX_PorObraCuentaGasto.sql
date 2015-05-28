CREATE Procedure [dbo].[Cuentas_TX_PorObraCuentaGasto]

@IdObra int,
@IdCuentaGasto int,
@FechaConsulta datetime = Null

AS 

SET NOCOUNT ON

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 IdCuentaGasto INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(100)
			)
INSERT INTO #Auxiliar1 
 SELECT Cuentas.IdCuenta, Cuentas.IdCuentaGasto, 
	IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Codigo),
	IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Descripcion)
 FROM Cuentas
 WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and IdObra=@IdObra And IdCuentaGasto=@IdCuentaGasto

SET NOCOUNT OFF

SELECT TOP 1 #Auxiliar1.*, Cuentas.IdRubroFinanciero
FROM #Auxiliar1 
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar1.IdCuenta
WHERE Len(LTrim(#Auxiliar1.Descripcion))>0

DROP TABLE #Auxiliar1