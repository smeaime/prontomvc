CREATE PROCEDURE [dbo].[Cuentas_TX_MayorPorIdCuentaEntreFechasSinCIE]

@IdCuenta int,
@FechaDesde datetime,
@FechaHasta datetime

AS

SET NOCOUNT ON

DECLARE @OrdenesPagoAnuladas numeric(18,2)

CREATE TABLE #Auxiliar1
			(
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 DebeInicial NUMERIC(18, 2),
			 HaberInicial NUMERIC(18, 2),
			 OrdenesPagoAnuladas NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetAsi.Debe,
  DetAsi.Haber,
  0,
  0,
  0
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE DetAsi.IdCuenta=@IdCuenta and asientos.IdCuentaSubdiario is null and
		Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'CIE' and Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'APE' and 
		Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta)

 UNION ALL

 SELECT
  Subdiarios.Debe,
  Subdiarios.Haber,
  0,
  0,
  0
 FROM Subdiarios
 LEFT OUTER JOIN OrdenesPago ON Subdiarios.IdTipoComprobante=17 and OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante
 WHERE Subdiarios.IdCuenta=@IdCuenta and Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta) 
		--and IsNull(OrdenesPago.Anulada,'')<>'SI'

 UNION ALL

 SELECT
  0,
  0,
  IsNull((Select Sum(Case When Sub.Debe is not null Then Sub.Debe Else 0 End) 
			From Subdiarios Sub
			Left Outer Join OrdenesPago On Sub.IdTipoComprobante=17 and OrdenesPago.IdOrdenPago=Sub.IdComprobante
			Where Sub.IdCuenta=@IdCuenta and Sub.FechaComprobante<@FechaDesde),0) +  --and IsNull(OrdenesPago.Anulada,'')<>'SI'),0) + 
	IsNull((Select Sum(Case When DetAsi.Debe is not null Then DetAsi.Debe Else 0 End) 
			From DetalleAsientos DetAsi
			Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
			Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=@IdCuenta and Asientos.FechaAsiento<@FechaDesde and 
					Not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and Year(Asientos.FechaAsiento)=Year(@FechaHasta) and Month(Asientos.FechaAsiento)=Month(@FechaHasta))),0),
  0,
  0

 UNION ALL

 SELECT
  0,
  0,
  0,
  IsNull((Select Sum(Case When Sub.Haber is not null Then Sub.Haber Else 0 End) 
			From Subdiarios Sub
			Left Outer Join OrdenesPago On Sub.IdTipoComprobante=17 and OrdenesPago.IdOrdenPago=Sub.IdComprobante
			Where Sub.IdCuenta=@IdCuenta and Sub.FechaComprobante<@FechaDesde),0) +  --and IsNull(OrdenesPago.Anulada,'')<>'SI'),0) + 
	IsNull((Select Sum(Case When DetAsi.Haber is not null Then DetAsi.Haber Else 0 End) 
			From DetalleAsientos DetAsi
			Left Outer Join Asientos On DetAsi.IdAsiento = Asientos.IdAsiento
			Where Asientos.IdCuentaSubdiario is null and DetAsi.IdCuenta=@IdCuenta and Asientos.FechaAsiento<@FechaDesde and 
					Not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and Year(Asientos.FechaAsiento)=Year(@FechaHasta) and Month(Asientos.FechaAsiento)=Month(@FechaHasta))),0),
  0

UPDATE #Auxiliar1
SET Debe=0
WHERE Debe IS NULL

UPDATE #Auxiliar1
SET Haber=0
WHERE Haber IS NULL

SET @OrdenesPagoAnuladas=IsNull((Select Sum(IsNull(Sub.Debe,0)-IsNull(Sub.Haber,0)) 
								 From Subdiarios Sub
								 Left Outer Join OrdenesPago On Sub.IdTipoComprobante=17 and OrdenesPago.IdOrdenPago=Sub.IdComprobante
								 Where Sub.IdCuenta=@IdCuenta and Sub.FechaComprobante<@FechaHasta and IsNull(OrdenesPago.Anulada,'')='SI' and 
										IsNull(OrdenesPago.FechaAnulacion,convert(datetime,'1/1/2000',103))>@FechaHasta),0)

SET NOCOUNT ON

SELECT
 SUM(#Auxiliar1.Debe) as [Debe],
 SUM(#Auxiliar1.Haber) as [Haber],
 SUM(#Auxiliar1.Debe)-SUM(#Auxiliar1.Haber) as [Saldo],
 SUM(#Auxiliar1.DebeInicial) as [DebeInicial],
 SUM(#Auxiliar1.HaberInicial) as [HaberInicial],
 SUM(#Auxiliar1.DebeInicial)-SUM(#Auxiliar1.HaberInicial) as [SaldoInicial],
 @OrdenesPagoAnuladas as [OrdenesPagoAnuladas]
FROM #Auxiliar1

DROP TABLE #Auxiliar1
