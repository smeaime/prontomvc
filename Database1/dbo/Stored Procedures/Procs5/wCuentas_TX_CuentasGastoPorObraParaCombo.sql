
CREATE Procedure [dbo].[wCuentas_TX_CuentasGastoPorObraParaCombo]

@IdObra int,
@FechaConsulta datetime = Null

AS 

SET NOCOUNT ON

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())

CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(100)
			)
INSERT INTO #Auxiliar1 
 SELECT Cuentas.IdCuenta, 
	IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Codigo),
	IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Descripcion)
 FROM Cuentas
 WHERE (Cuentas.IdTipoCuenta=2 or Cuentas.IdTipoCuenta=4) and 
	IdObra=@IdObra and Cuentas.IdCuentaGasto is not null

SET NOCOUNT OFF

SELECT DISTINCT 
 Cuentas.IdCuentaGasto,
	CuentasGastos.Descripcion + ' ' + Convert(varchar,#Auxiliar1.Codigo) as [Titulo] 
--	CuentasGastos.Descripcion as [Titulo]
FROM #Auxiliar1
LEFT OUTER JOIN Cuentas ON #Auxiliar1.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN CuentasGastos ON Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto
WHERE Len(LTrim(#Auxiliar1.Descripcion))>0 and Len(LTrim(CuentasGastos.Descripcion))>0
ORDER by CuentasGastos.Descripcion + ' ' + Convert(varchar,#Auxiliar1.Codigo)
--ORDER by CuentasGastos.Descripcion

