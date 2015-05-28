




CREATE PROCEDURE [dbo].[InformeMayorResumido_TX_1]

@IdCuenta int,
@FechaDesde datetime,
@FechaHasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1	
			(
			 A_IdCuenta INTEGER,
			 A_Codigo INTEGER,
			 A_IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Cuentas.IdCuenta,
  Cuentas.Codigo,
  Cuentas.IdObra
 FROM Cuentas 
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaMadre=@IdCuenta
 WHERE Cuentas.IdCuentaGasto IS NOT NULL AND Cuentas.IdCuentaGasto=CuentasGastos.IdCuentaGasto

CREATE TABLE #Auxiliar2
			(
			 IdCuenta INTEGER,
			 Cuenta INTEGER,
			 Descripcion VARCHAR(50),
			 Asiento INTEGER,
			 Fecha DATETIME,
			 Mes INTEGER,
			 Año INTEGER,
			 Concepto VARCHAR(80),
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  DetAsi.IdCuenta,
  Cuentas.Codigo,
  Case	When IsNull(DetAsi.Debe,0)=0 Then '   '+Cuentas.Descripcion
	Else Cuentas.Descripcion 
  End,
  Asientos.NumeroAsiento,
  Asientos.FechaAsiento,
  Null,
  Null,
  SubString(IsNull(Asientos.Concepto COLLATE Modern_Spanish_CI_AS,'')+ 
	Case When #Auxiliar1.A_IdCuenta is not null 
		Then '[ Cuenta : '+Convert(varchar,#Auxiliar1.A_Codigo)+' - Obra : '+Obras.NumeroObra+' ]'
		Else ' '
	End,1,200),
  DetAsi.Debe,
  DetAsi.Haber
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN #Auxiliar1 ON DetAsi.IdCuenta = #Auxiliar1.A_IdCuenta
 LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar1.A_IdObra
 WHERE 	(DetAsi.IdCuenta=@IdCuenta or #Auxiliar1.A_IdCuenta is not null) and 
	Asientos.IdCuentaSubdiario is null and
	Asientos.FechaAsiento>=@FechaDesde and Asientos.FechaAsiento<=DATEADD(n,1439,@FechaHasta)

 UNION ALL

 SELECT
  Subdiarios.IdCuenta,
  Cuentas.Codigo,
  Case	When IsNull(Subdiarios.Debe,0)=0 Then '   '+Cuentas.Descripcion
	Else Cuentas.Descripcion 
  End,
  Null,
  Null,
  Month(Subdiarios.FechaComprobante),
  Year(Subdiarios.FechaComprobante),
  Titulos.Titulo+' [ '+Convert(varchar,Month(Subdiarios.FechaComprobante))+'/'+
	Convert(varchar,Year(Subdiarios.FechaComprobante)) as [Concepto],
  Subdiarios.Debe,
  Subdiarios.Haber
 FROM Subdiarios
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN Titulos ON Subdiarios.IdCuentaSubdiario=Titulos.IdTitulo
 LEFT OUTER JOIN #Auxiliar1 ON Subdiarios.IdCuenta = #Auxiliar1.A_IdCuenta
 LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar1.A_IdObra WHERE 	(Subdiarios.IdCuenta=@IdCuenta or #Auxiliar1.A_IdCuenta is not null) and 
	Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta)

SET NOCOUNT OFF

Declare @Saldo numeric(18,2)
Set @Saldo=0

SELECT 
 0 as [IdAux],
 #Auxiliar2.Cuenta as [Cuenta],
 #Auxiliar2.Descripcion as [Descripcion],
 #Auxiliar2.Asiento as [Nro.Asiento],
 #Auxiliar2.Fecha as [Fecha Asiento],
 #Auxiliar2.Concepto as [Concepto],
 SUM(IsNull(#Auxiliar2.Debe,0)) as [Debe],
 SUM(IsNull(#Auxiliar2.Haber,0)) as [Haber],
 @Saldo as [Saldo],
 Convert(varchar(250),'  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  |  |  |') as [Vector_E],
 Convert(varchar(50),NULL) as [Vector_T],
 Convert(varchar(50),NULL) as [Vector_X]
FROM #Auxiliar2
GROUP BY #Auxiliar2.Cuenta,#Auxiliar2.Descripcion,#Auxiliar2.Asiento,#Auxiliar2.Fecha,
	#Auxiliar2.Concepto,#Auxiliar2.Mes,#Auxiliar2.Año
ORDER BY #Auxiliar2.Cuenta,#Auxiliar2.Fecha,#Auxiliar2.Mes,#Auxiliar2.Año,#Auxiliar2.Concepto

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2




