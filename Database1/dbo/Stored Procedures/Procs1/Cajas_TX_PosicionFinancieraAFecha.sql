CREATE PROCEDURE [dbo].[Cajas_TX_PosicionFinancieraAFecha]

@Fecha datetime,
@IdMoneda int, 
@IncluirValoresADepositarYChequesDiferidos varchar(2) = Null

AS

SET NOCOUNT ON

SET @IncluirValoresADepositarYChequesDiferidos=IsNull(@IncluirValoresADepositarYChequesDiferidos,'')

DECLARE @CuentasDescarte varchar(2000), @IdCuentaValores int, @IdMonedaPesos int

SET @CuentasDescarte=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Cuentas a descartar para posicion financiera'),'')
SET @IdCuentaValores=Isnull((Select Top 1 IdCuentaValores From Parametros Where IdParametro=1),0)
SET @IdMonedaPesos=Isnull((Select Top 1 IdMoneda From Parametros Where IdParametro=1),1)

CREATE TABLE #Auxiliar1
			(
			 IdCaja INTEGER,
			 IdCuenta INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT IdCaja, IdCuenta
 FROM Cajas 
 WHERE IdMoneda=@IdMoneda

IF @IncluirValoresADepositarYChequesDiferidos='SI' and @IdMoneda=@IdMonedaPesos
    BEGIN
	INSERT INTO #Auxiliar1 
	(IdCaja, IdCuenta)
	VALUES
	(0, @IdCuentaValores)

	INSERT INTO #Auxiliar1 
	 SELECT cb.IdCuentaBancaria*-1, Bancos.IdCuentaParaChequesDiferidos
	 FROM CuentasBancarias cb
	 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=cb.IdBanco
	 WHERE cb.IdMoneda=@IdMoneda
    END

CREATE TABLE #Auxiliar2
			(
			 IdCaja INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 DebeAnterior NUMERIC(18, 2),
			 HaberAnterior NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdCaja, #Auxiliar1.IdCuenta, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0), 
	Case When Asientos.FechaAsiento<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(DetAsi.Debe,0) Else 0 End,
	Case When Asientos.FechaAsiento<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(DetAsi.Haber,0) Else 0 End
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN #Auxiliar1 ON DetAsi.IdCuenta = #Auxiliar1.IdCuenta
 WHERE #Auxiliar1.IdCuenta is not null and asientos.IdCuentaSubdiario is null and Asientos.FechaAsiento<=DATEADD(n,1439,@Fecha)

 UNION ALL

 SELECT #Auxiliar1.IdCaja, #Auxiliar1.IdCuenta, IsNull(Subdiarios.Debe,0), IsNull(Subdiarios.Haber,0), 
	Case When Subdiarios.FechaComprobante<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(Subdiarios.Debe,0) Else 0 End,
	Case When Subdiarios.FechaComprobante<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(Subdiarios.Haber,0) Else 0 End
 FROM Subdiarios
 LEFT OUTER JOIN #Auxiliar1 ON Subdiarios.IdCuenta = #Auxiliar1.IdCuenta
 WHERE #Auxiliar1.IdCuenta is not null and Subdiarios.FechaComprobante<=DATEADD(n,1439,@Fecha)

CREATE TABLE #Auxiliar3
			(
			 IdCaja INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 DebeAnterior NUMERIC(18, 2),
			 HaberAnterior NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT #Auxiliar2.IdCaja, #Auxiliar2.IdCuenta, Sum(IsNull(#Auxiliar2.Debe,0)), Sum(IsNull(#Auxiliar2.Haber,0)), 
	Sum(IsNull(#Auxiliar2.DebeAnterior,0)), Sum(IsNull(#Auxiliar2.HaberAnterior,0))
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdCaja, #Auxiliar2.IdCuenta

SET NOCOUNT ON

SELECT 
 #Auxiliar3.IdCaja,
 #Auxiliar3.IdCuenta,
 IsNull(Cajas.Descripcion,Cuentas.Descripcion) as [Caja],
 Monedas.Nombre as [Moneda],
 Cuentas.Codigo as [CodigoCuenta],
 IsNull(#Auxiliar3.Debe,0)-IsNull(#Auxiliar3.Haber,0) as [Saldo],
 IsNull(#Auxiliar3.DebeAnterior,0)-IsNull(#Auxiliar3.HaberAnterior,0) as [SaldoAnterior]
FROM #Auxiliar3
LEFT OUTER JOIN Cajas ON Cajas.IdCaja=#Auxiliar3.IdCaja
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=IsNull(Cajas.IdMoneda,@IdMoneda)
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar3.IdCuenta
WHERE Patindex('%('+Convert(varchar,Cuentas.Codigo)+')%', @CuentasDescarte)=0
ORDER BY IsNull(Cuentas.OrdenamientoAuxiliar,999999), Cajas.Descripcion

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3