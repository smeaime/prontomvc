CREATE Procedure [dbo].[Cuentas_TX_ParaComprobantesProveedores]

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
 WHERE IdTipoCuenta=2

SET NOCOUNT OFF

SELECT IdCuenta, Descripcion + ' ' + Convert(varchar,Codigo) as [Titulo]
FROM #Auxiliar1
WHERE Len(Descripcion)>0
ORDER by [Titulo]

DROP TABLE #Auxiliar1