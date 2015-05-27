CREATE Procedure [dbo].[Cuentas_TX_PorDescripcionCodigoParaCombo]

@FechaConsulta datetime = Null,
@IdUsuario int = Null

AS 

SET NOCOUNT ON

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())
SET @IdUsuario=IsNull(@IdUsuario,-1)

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
 WHERE (IdTipoCuenta=2 or IdTipoCuenta=4) and (@IdUsuario=-1 or not Exists(Select aepu.IdCuenta From AutorizacionesEspecialesPorUsuario aepu Where aepu.IdUsuario=@IdUsuario and aepu.IdCuenta=Cuentas.IdCuenta))

SET NOCOUNT OFF

SELECT IdCuenta, Descripcion+' '+Convert(varchar,Codigo) as [Titulo], Codigo as [Codigo]
FROM #Auxiliar1
WHERE Len(LTrim(Descripcion))>0
ORDER by [Titulo]

DROP TABLE #Auxiliar1
