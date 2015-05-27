
CREATE Procedure [dbo].[Cuentas_TX_BalanceConAperturaResumen]

@Desde varchar(10),
@Hasta varchar(10),
@FechaDesde datetime,
@FechaHasta datetime,
@EjercicioInicio int,
@FechaInicioEjercicio datetime,
@IncluirCierre varchar(2) = Null,
@IncluirApertura varchar(2) = Null,
@IncluirConsolidacion varchar(2) = Null

AS 

SET NOCOUNT ON

SET @IncluirCierre=IsNull(@IncluirCierre,'SI')
SET @IncluirApertura=IsNull(@IncluirApertura,'SI')
SET @IncluirConsolidacion=IsNull(@IncluirConsolidacion,'SI')

CREATE TABLE #Auxiliar0
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(20),
			 DescripcionJerarquia1 VARCHAR(55),
			 DescripcionJerarquia2 VARCHAR(55),
			 DescripcionJerarquia3 VARCHAR(55),
			 DescripcionJerarquia4 VARCHAR(55)
			)

INSERT INTO #Auxiliar0 
 SELECT 
  C.IdCuenta,
  IsNull((Select Top 1 dc.CodigoAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Codigo),
  IsNull((Select Top 1 dc.NombreAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Descripcion),
  IsNull((Select Top 1 dc.JerarquiaAnterior 
		From DetalleCuentas dc 
		Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
		Order By dc.FechaCambio),C.Jerarquia),
  '',
  '',
  '',
  ''
 FROM Cuentas C 
 WHERE 	Not (Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
			 Order By dc.FechaCambio),'S/D'))=0 and C.IdTipoCuenta=1) and 

	(Len(IsNull(C.Descripcion,''))>0 or 
	 (Len(IsNull(C.Descripcion,''))=0 and 
	  Len(IsNull((Select Top 1 dc.NombreAnterior 
			 From DetalleCuentas dc 
			 Where dc.IdCuenta=C.IdCuenta and dc.FechaCambio>@FechaHasta 
			 Order By dc.FechaCambio),''))>0))

UPDATE #Auxiliar0
SET DescripcionJerarquia1=(Select Top 1 Aux.Descripcion From #Auxiliar0 Aux 
					Where Substring(Aux.Jerarquia,1,1)=Substring(#Auxiliar0.Jerarquia,1,1)
					Order By Aux.Jerarquia)
UPDATE #Auxiliar0
SET DescripcionJerarquia1=Substring(Jerarquia,1,1)+' - '+DescripcionJerarquia1

UPDATE #Auxiliar0
SET DescripcionJerarquia2=(Select Top 1 Aux.Descripcion From #Auxiliar0 Aux 
					Where Substring(Aux.Jerarquia,1,3)=Substring(#Auxiliar0.Jerarquia,1,3)
					Order By Aux.Jerarquia)
UPDATE #Auxiliar0
SET DescripcionJerarquia2=Substring(Jerarquia,3,1)+' - '+DescripcionJerarquia2

UPDATE #Auxiliar0
SET DescripcionJerarquia3=(Select Top 1 Aux.Descripcion From #Auxiliar0 Aux 
					Where Substring(Aux.Jerarquia,1,6)=Substring(#Auxiliar0.Jerarquia,1,6)
					Order By Aux.Jerarquia)
UPDATE #Auxiliar0
SET DescripcionJerarquia3=Substring(Jerarquia,5,2)+' - '+DescripcionJerarquia3

UPDATE #Auxiliar0
SET DescripcionJerarquia4=Case When Substring(Jerarquia,1,1)<'6'
				Then (Select Top 1 Aux.Descripcion From #Auxiliar0 Aux 
					Where Substring(Aux.Jerarquia,1,9)=Substring(#Auxiliar0.Jerarquia,1,9)
					Order By Aux.Jerarquia)
				Else (Select Top 1 Aux.Descripcion From #Auxiliar0 Aux 
					Where Substring(Aux.Jerarquia,1,6)=Substring(#Auxiliar0.Jerarquia,1,6)
					Order By Aux.Jerarquia)
			  End
UPDATE #Auxiliar0
SET DescripcionJerarquia4=Substring(Jerarquia,8,2)+' - '+DescripcionJerarquia4


CREATE TABLE #Auxiliar1
			(
			 A_IdCuenta INTEGER,
			 A_Debe NUMERIC(18, 2),
			 A_Haber NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar1 
 SELECT DetAsi.IdCuenta, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.IdCuentaSubdiario is null and 
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta and 
	(@IncluirCierre='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'CIE') and 
/*
		(@IncluirCierre='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
*/
	(@IncluirApertura='SI' or Substring(IsNull(Asientos.Tipo,'   '),1,3)<>'APE') and 
/*
		(@IncluirApertura='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='APE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
*/
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL 

 SELECT Sub.IdCuenta, IsNull(Sub.Debe,0), ISNull(Sub.Haber,0)
 FROM Subdiarios Sub
 WHERE Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta 


CREATE TABLE #Auxiliar5
			(
			 A_IdCuenta INTEGER,
			 A_Debe NUMERIC(18, 2),
			 A_Haber NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar5 
 SELECT 
  #Auxiliar1.A_IdCuenta,
  SUM(#Auxiliar1.A_Debe),
  SUM(#Auxiliar1.A_Haber)
 FROM #Auxiliar1 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdCuenta=#Auxiliar1.A_IdCuenta
 WHERE #Auxiliar0.IdCuenta is not null
 GROUP BY #Auxiliar1.A_IdCuenta


CREATE TABLE #Auxiliar2
			(
			 A_IdCuenta INTEGER,
			 A_SaldoDeudor NUMERIC(18, 2),
			 A_SaldoAcreedor NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar2 
 SELECT DetAsi.IdCuenta, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.IdCuentaSubdiario is null and Asientos.FechaAsiento<@FechaDesde and 
/*
	(@IncluirCierre='SI' or 
		(@IncluirCierre='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='CIE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
	(@IncluirApertura='SI' or 
		(@IncluirApertura='NO' and not (Substring(IsNull(Asientos.Tipo,'   '),1,3)='APE' and 
						Year(Asientos.FechaAsiento)=Year(@FechaHasta) and 
						Month(Asientos.FechaAsiento)=Month(@FechaHasta)))) and 
*/
	(@IncluirConsolidacion='SI' or (@IncluirConsolidacion='NO' and Asientos.FechaGeneracionConsolidado is null))

 UNION ALL 

 SELECT Sub.IdCuenta, IsNull(Sub.Debe,0), ISNull(Sub.Haber,0)
 FROM Subdiarios Sub
 WHERE Sub.FechaComprobante<@FechaDesde 


CREATE TABLE #Auxiliar3 (A_IdCuenta INTEGER,A_SaldoAnterior NUMERIC(18, 2))
INSERT INTO #Auxiliar3 
 SELECT #Auxiliar2.A_IdCuenta, SUM(#Auxiliar2.A_SaldoDeudor-#Auxiliar2.A_SaldoAcreedor)
 FROM #Auxiliar2
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdCuenta=#Auxiliar2.A_IdCuenta
 WHERE #Auxiliar0.IdCuenta is not null
 GROUP BY #Auxiliar2.A_IdCuenta


CREATE TABLE #Auxiliar4 
			(
			 A_IdCuenta INTEGER,
			 A_Clave INTEGER,
			 A_Jerarquia1 VARCHAR(55),
			 A_Jerarquia2 VARCHAR(55),
			 A_Jerarquia3 VARCHAR(55),
			 A_Jerarquia4 VARCHAR(55),
			 A_Codigo INTEGER,
			 A_Descripcion  VARCHAR(50),
			 A_Detalle VARCHAR(100),
			 A_SaldoInicial NUMERIC(18, 2),
			 A_SaldoDeudorPeriodo NUMERIC(18, 2),
			 A_SaldoAcreedorPeriodo NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar4 
 SELECT 
  #Auxiliar0.IdCuenta,
  1,
  #Auxiliar0.DescripcionJerarquia1,
  #Auxiliar0.DescripcionJerarquia2,
  #Auxiliar0.DescripcionJerarquia3,
  #Auxiliar0.DescripcionJerarquia4,
  #Auxiliar0.Codigo,
  #Auxiliar0.Descripcion,
  '',
  IsNull(#Auxiliar3.A_SaldoAnterior,0),
  0,
  0
 FROM #Auxiliar0 
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.A_IdCuenta = #Auxiliar0.IdCuenta
 WHERE #Auxiliar0.Codigo between @Desde and @Hasta

 UNION ALL 

 SELECT 
  #Auxiliar5.A_IdCuenta,
  2,
  #Auxiliar0.DescripcionJerarquia1,
  #Auxiliar0.DescripcionJerarquia2,
  #Auxiliar0.DescripcionJerarquia3,
  #Auxiliar0.DescripcionJerarquia4,
  #Auxiliar0.Codigo,
  #Auxiliar0.Descripcion,
  '',
  0,
  #Auxiliar5.A_Debe,
  #Auxiliar5.A_Haber
 FROM #Auxiliar5
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdCuenta=#Auxiliar5.A_IdCuenta
 WHERE #Auxiliar0.IdCuenta is not null

SET NOCOUNT OFF


DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0011111111111133'
SET @vector_T='0099991305555500'

SELECT 
 #Auxiliar4.A_IdCuenta,
 #Auxiliar4.A_Clave,
 #Auxiliar4.A_Jerarquia1 as [Nivel 1],
 #Auxiliar4.A_Jerarquia2 as [Nivel 2],
 #Auxiliar4.A_Jerarquia3 as [Nivel 3],
 #Auxiliar4.A_Jerarquia4 as [Nivel 4],
 #Auxiliar4.A_Codigo as [Cod.],
 #Auxiliar4.A_Descripcion as [Cuenta],
 #Auxiliar4.A_Detalle as [Detalle],
 Case When #Auxiliar4.A_SaldoInicial<>0 Then #Auxiliar4.A_SaldoInicial Else Null End as [Sdo. inicial],
 Case When #Auxiliar4.A_SaldoDeudorPeriodo<>0 Then #Auxiliar4.A_SaldoDeudorPeriodo Else Null End as [Sdo. deudor periodo],
 Case When #Auxiliar4.A_SaldoAcreedorPeriodo<>0 Then #Auxiliar4.A_SaldoAcreedorPeriodo Else Null End as [Sdo. acreedor periodo],
 Case When #Auxiliar4.A_SaldoDeudorPeriodo-#Auxiliar4.A_SaldoAcreedorPeriodo<>0 
	Then #Auxiliar4.A_SaldoDeudorPeriodo-#Auxiliar4.A_SaldoAcreedorPeriodo 
	Else Null 
 End as [Sdo. periodo],
 Case When #Auxiliar4.A_SaldoInicial+#Auxiliar4.A_SaldoDeudorPeriodo-#Auxiliar4.A_SaldoAcreedorPeriodo<>0 
	Then #Auxiliar4.A_SaldoInicial+#Auxiliar4.A_SaldoDeudorPeriodo-#Auxiliar4.A_SaldoAcreedorPeriodo 
	Else Null 
 End as [Sdo. final],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar4
ORDER BY A_Jerarquia1, A_Jerarquia2, A_Jerarquia3, A_Jerarquia4, A_Codigo,A_Clave

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
