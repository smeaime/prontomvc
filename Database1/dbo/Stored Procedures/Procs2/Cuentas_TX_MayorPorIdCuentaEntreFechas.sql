CREATE PROCEDURE [dbo].[Cuentas_TX_MayorPorIdCuentaEntreFechas]

@IdCuenta int,
@FechaDesde datetime,
@FechaHasta datetime,
@Formato varchar(10) = Null,
@IdTipoCuentaGrupo int = Null

AS

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')
SET @IdTipoCuentaGrupo=IsNull(@IdTipoCuentaGrupo,-1)

CREATE TABLE #Auxiliar1
			(
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 DebeInicial NUMERIC(18, 2),
			 HaberInicial NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetAsi.IdCuenta,
  IsNull(DetAsi.Debe,0),
  IsNull(DetAsi.Haber,0),
  0,
  0
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetAsi.IdCuenta
 WHERE (@IdCuenta=-1 or DetAsi.IdCuenta=@IdCuenta) and 
		(@IdTipoCuentaGrupo=-1 or Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupo) and 
		asientos.IdCuentaSubdiario is null and
	--	SUBSTRING(IsNull(Asientos.Tipo,'   '),1,3)<>'CIE' and 
	--	SUBSTRING(IsNull(Asientos.Tipo,'   '),1,3)<>'APE' and 
		Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta)

 UNION ALL

 SELECT 
  Subdiarios.IdCuenta, 
  IsNull(Subdiarios.Debe,0),
  IsNull(Subdiarios.Haber,0),
  0,
  0
 FROM Subdiarios
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Subdiarios.IdCuenta
 WHERE (@IdCuenta=-1 or Subdiarios.IdCuenta=@IdCuenta) and 
		(@IdTipoCuentaGrupo=-1 or Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupo) and 
		Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta)

 UNION ALL

 SELECT
  Cuentas.IdCuenta,
  0,
  0,
  IsNull((Select Sum(IsNull(Sub.Debe,0)) From Subdiarios Sub Where Sub.IdCuenta=Cuentas.IdCuenta and Sub.FechaComprobante<@FechaDesde),0)+
	  IsNull((Select Sum(IsNull(DetAsi.Debe,0)) From DetalleAsientos DetAsi
				Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
				Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=Cuentas.IdCuenta and Asientos.FechaAsiento<@FechaDesde and 
					Not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and Year(Asientos.FechaAsiento)=Year(@FechaHasta) and Month(Asientos.FechaAsiento)=Month(@FechaHasta))),0),
  IsNull((Select Sum(IsNull(Sub.Haber,0)) From Subdiarios Sub Where Sub.IdCuenta=Cuentas.IdCuenta and Sub.FechaComprobante<@FechaDesde),0)+
	  IsNull((Select Sum(IsNull(DetAsi.Haber,0)) From DetalleAsientos DetAsi
				Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
				Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=Cuentas.IdCuenta and Asientos.FechaAsiento<@FechaDesde and 
					Not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and Year(Asientos.FechaAsiento)=Year(@FechaHasta) and Month(Asientos.FechaAsiento)=Month(@FechaHasta))),0)
 FROM Cuentas 
 WHERE (@IdCuenta=-1 or Cuentas.IdCuenta=@IdCuenta) and 
		(@IdTipoCuentaGrupo=-1 or Cuentas.IdTipoCuentaGrupo=@IdTipoCuentaGrupo)

SET NOCOUNT ON

IF @Formato=''
	SELECT
	 SUM(#Auxiliar1.Debe) as [Debe],
	 SUM(#Auxiliar1.Haber) as [Haber],
	 SUM(#Auxiliar1.Debe)-SUM(#Auxiliar1.Haber) as [Saldo],
	 SUM(#Auxiliar1.DebeInicial) as [DebeInicial],
	 SUM(#Auxiliar1.HaberInicial) as [HaberInicial],
	 SUM(#Auxiliar1.DebeInicial)-SUM(#Auxiliar1.HaberInicial) as [SaldoInicial]
	FROM #Auxiliar1
ELSE
  BEGIN
	SELECT 
	 IdCuenta,
	 SUM(#Auxiliar1.Debe) as [Debe],
	 SUM(#Auxiliar1.Haber) as [Haber],
	 SUM(#Auxiliar1.Debe)-SUM(#Auxiliar1.Haber) as [Saldo],
	 SUM(#Auxiliar1.DebeInicial) as [DebeInicial],
	 SUM(#Auxiliar1.HaberInicial) as [HaberInicial],
	 SUM(#Auxiliar1.DebeInicial)-SUM(#Auxiliar1.HaberInicial) as [SaldoInicial]
	FROM #Auxiliar1
	GROUP BY IdCuenta
	ORDER BY IdCuenta
  END
  
DROP TABLE #Auxiliar1