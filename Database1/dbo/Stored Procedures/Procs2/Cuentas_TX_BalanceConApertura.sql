
CREATE Procedure [dbo].[Cuentas_TX_BalanceConApertura]

@Desde varchar(10),
@Hasta varchar(10),
@FechaDesde datetime,
@FechaHasta datetime,
@EjercicioInicio int,
@FechaInicioEjercicio datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar0
			(
			 IdCuenta INTEGER,
			 Codigo INTEGER,
			 Descripcion VARCHAR(50),
			 Jerarquia VARCHAR(50),
			 DescripcionJerarquia1 VARCHAR(50),
			 DescripcionJerarquia2 VARCHAR(50),
			 DescripcionJerarquia3 VARCHAR(50),
			 DescripcionJerarquia4 VARCHAR(50)
			)

INSERT INTO #Auxiliar0 
 SELECT 
  C.IdCuenta,
  C.Codigo,
  C.Descripcion,
  C.Jerarquia,
  '',
  '',
  '',
  ''
 FROM Cuentas C 

UPDATE #Auxiliar0
SET DescripcionJerarquia1=(Select Top 1 C.Descripcion From Cuentas C 
					Where Substring(C.Jerarquia,1,1)=Substring(#Auxiliar0.Jerarquia,1,1)
					Order By C.Jerarquia)
UPDATE #Auxiliar0
SET DescripcionJerarquia1=Substring(Jerarquia,1,1)+' - '+DescripcionJerarquia1

UPDATE #Auxiliar0
SET DescripcionJerarquia2=(Select Top 1 C.Descripcion From Cuentas C 
					Where Substring(C.Jerarquia,1,3)=Substring(#Auxiliar0.Jerarquia,1,3)
					Order By C.Jerarquia)
UPDATE #Auxiliar0
SET DescripcionJerarquia2=Substring(Jerarquia,3,1)+' - '+DescripcionJerarquia2

UPDATE #Auxiliar0
SET DescripcionJerarquia3=(Select Top 1 C.Descripcion From Cuentas C 
					Where Substring(C.Jerarquia,1,6)=Substring(#Auxiliar0.Jerarquia,1,6)
					Order By C.Jerarquia)
UPDATE #Auxiliar0
SET DescripcionJerarquia3=Substring(Jerarquia,5,2)+' - '+DescripcionJerarquia3

UPDATE #Auxiliar0
SET DescripcionJerarquia4=(Select Top 1 C.Descripcion From Cuentas C 
					Where Substring(C.Jerarquia,1,9)=Substring(#Auxiliar0.Jerarquia,1,9)
					Order By C.Jerarquia)
UPDATE #Auxiliar0
SET DescripcionJerarquia4=Substring(Jerarquia,8,2)+' - '+DescripcionJerarquia4


CREATE TABLE #Auxiliar1
			(
			 A_IdCuenta INTEGER,
			 A_Detalle VARCHAR(100),
			 A_Debe NUMERIC(18, 2),
			 A_Haber NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar1 
 SELECT 
  DetAsi.IdCuenta,
  TiposComprobante.DescripcionAb+' '+Convert(varchar,DetAsi.NumeroComprobante)+' '+
  Convert(varchar,DetAsi.FechaComprobante,103)+' '+DetAsi.Libro,
  Case When DetAsi.Debe is not null Then DetAsi.Debe Else 0 End,
  Case When DetAsi.Haber is not null Then DetAsi.Haber Else 0 End
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN TiposComprobante ON DetAsi.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE Asientos.IdCuentaSubdiario is null and 
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=@FechaHasta 

 UNION ALL 

 SELECT 
  Sub.IdCuenta,
  TiposComprobante.DescripcionAb+' '+Convert(varchar,Sub.NumeroComprobante)+' '+
  Convert(varchar,Sub.FechaComprobante,103),
  Case When Sub.Debe is not null Then Sub.Debe Else 0 End,
  Case When Sub.Haber is not null Then Sub.Haber Else 0 End
 FROM Subdiarios Sub
 LEFT OUTER JOIN TiposComprobante ON Sub.IdTipoComprobante = TiposComprobante.IdTipoComprobante
 WHERE Sub.FechaComprobante>=@FechaDesde and Sub.FechaComprobante<=@FechaHasta 


CREATE TABLE #Auxiliar2
			(
			 A_IdCuenta INTEGER,
			 A_SaldoDeudor NUMERIC(18, 2),
			 A_SaldoAcreedor NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar2 
 SELECT 
  DetAsi.IdCuenta,
  Case 	When DetAsi.Debe is not null Then DetAsi.Debe Else 0 End,
  Case 	When DetAsi.Haber is not null Then DetAsi.Haber Else 0 End
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 WHERE Asientos.FechaAsiento<@FechaDesde

CREATE TABLE #Auxiliar3
			(
			 A_IdCuenta INTEGER,
			 A_SaldoAnterior NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar3 
 SELECT 
  #Auxiliar2.A_IdCuenta,
  SUM(#Auxiliar2.A_SaldoDeudor-#Auxiliar2.A_SaldoAcreedor)
 FROM #Auxiliar2
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
  Case When #Auxiliar3.A_SaldoAnterior is not null Then #Auxiliar3.A_SaldoAnterior Else 0 End,
  0,
  0
 FROM #Auxiliar0 
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.A_IdCuenta = #Auxiliar0.IdCuenta
 WHERE #Auxiliar0.Codigo between @Desde and @Hasta

 UNION ALL 

 SELECT 
  #Auxiliar1.A_IdCuenta,
  2,
  #Auxiliar0.DescripcionJerarquia1,
  #Auxiliar0.DescripcionJerarquia2,
  #Auxiliar0.DescripcionJerarquia3,
  #Auxiliar0.DescripcionJerarquia4,
  #Auxiliar0.Codigo,
  #Auxiliar0.Descripcion,
  #Auxiliar1.A_Detalle,
  0,
  #Auxiliar1.A_Debe,
  #Auxiliar1.A_Haber
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdCuenta=#Auxiliar1.A_IdCuenta


SET NOCOUNT OFF


Declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0011111111111133'
set @vector_T='0099991305555500'

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
ORDER BY A_Jerarquia1,A_Jerarquia2,A_Jerarquia3,A_Jerarquia4,A_Codigo,A_Clave


DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
