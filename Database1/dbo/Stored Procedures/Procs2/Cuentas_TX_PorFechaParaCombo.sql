CREATE Procedure [dbo].[Cuentas_TX_PorFechaParaCombo]

@FechaConsulta datetime = Null,
@IdObra int = Null,
@SoloImputable varchar(2) = Null,
@SinCajaBancos varchar(2) = Null,
@SinCuentasHijas varchar(2) = Null,
@Orden varchar(1) = Null,
@IdUsuario int = Null

AS 

SET NOCOUNT ON

SET @FechaConsulta=IsNull(@FechaConsulta,GetDate())
SET @IdObra=IsNull(@IdObra,-1)
SET @SoloImputable=IsNull(@SoloImputable,'NO')
SET @SinCajaBancos=IsNull(@SinCajaBancos,'NO')
SET @SinCuentasHijas=IsNull(@SinCuentasHijas,'NO')
SET @Orden=IsNull(@Orden,'D')
SET @IdUsuario=IsNull(@IdUsuario,-1)

IF Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
		Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
		Where pic.Clave='Ignorar obra en cuentas para combo'),'')='SI'
  BEGIN
	SET @IdObra=-1
	SET @SinCuentasHijas='NO'
  END

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
 WHERE (Cuentas.IdTipoCuenta=2 or (@SoloImputable<>'SI' and Cuentas.IdTipoCuenta=4)) and 
	(@IdObra<=0 or Cuentas.IdObra is null or Cuentas.IdObra=@IdObra) and 
	(@SinCajaBancos='NO' or IsNull(TiposCuentaGrupos.EsCajaBanco,'NO')='NO') and 
	(@SinCuentasHijas='NO' or Cuentas.IdCuentaGasto is null) and 
	(@IdUsuario=-1 or not Exists(Select aepu.IdCuenta From AutorizacionesEspecialesPorUsuario aepu Where aepu.IdUsuario=@IdUsuario and aepu.IdCuenta=Cuentas.IdCuenta))

SET NOCOUNT OFF

SELECT IdCuenta, Case When @Orden='D' Then Descripcion + ' ' + Convert(varchar,Codigo) Else Convert(varchar,IsNull(Codigo,0)) + ' ' + Descripcion End as [Titulo], Codigo as [Codigo]
FROM #Auxiliar1
WHERE Len(LTrim(Descripcion))>0
ORDER by [Titulo]

DROP TABLE #Auxiliar1