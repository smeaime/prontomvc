CREATE Procedure [dbo].[Cuentas_TX_DesdeHasta]

@Desde varchar(10),
@Hasta varchar(10),
@FechaConsulta datetime = Null,
@IdUsuario int = Null

AS 

SET NOCOUNT ON

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())
SET @IdUsuario=IsNull(@IdUsuario,-1)

CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 IdTipoCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(100)
			)
INSERT INTO #Auxiliar1 
 SELECT Cuentas.IdCuenta, Cuentas.IdTipoCuenta, 
	IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Codigo),
	IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>@FechaConsulta 
		Order By dc.FechaCambio),Cuentas.Descripcion)
 FROM Cuentas
 WHERE (@IdUsuario=-1 or not Exists(Select aepu.IdCuenta From AutorizacionesEspecialesPorUsuario aepu Where aepu.IdUsuario=@IdUsuario and aepu.IdCuenta=Cuentas.IdCuenta))

SET NOCOUNT OFF

SELECT *
FROM #Auxiliar1
WHERE Codigo between @Desde and @Hasta
ORDER BY Codigo

DROP TABLE #Auxiliar1