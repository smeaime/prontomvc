CREATE Procedure [dbo].[Cuentas_TX_PorGrupoParaCombo]

@IdTipoCuentaGrupo int,
@FechaConsulta datetime = Null,
@SinCajaBancos varchar(2) = Null,
@IdUsuario int = Null

AS 

SET NOCOUNT ON

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())
SET @SinCajaBancos=IsNull(@SinCajaBancos,'NO')
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
 LEFT OUTER JOIN TiposCuentaGrupos ON TiposCuentaGrupos.IdTipoCuentaGrupo=Cuentas.IdTipoCuentaGrupo
 WHERE Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupo and Cuentas.IdTipoCuenta=2 and 
		(@SinCajaBancos='NO' or IsNull(TiposCuentaGrupos.EsCajaBanco,'NO')='NO') and 
		(@IdUsuario=-1 or not Exists(Select aepu.IdCuenta From AutorizacionesEspecialesPorUsuario aepu Where aepu.IdUsuario=@IdUsuario and aepu.IdCuenta=Cuentas.IdCuenta))

SET NOCOUNT OFF

SELECT IdCuenta, Descripcion + ' ' + Convert(varchar,Codigo) as [Titulo]
FROM #Auxiliar1
WHERE Len(LTrim(Descripcion))>0
GROUP By IdCuenta,Codigo,Descripcion
ORDER by Descripcion

DROP TABLE #Auxiliar1