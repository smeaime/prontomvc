CREATE Procedure [dbo].[Bancos_TX_SaldosAFecha]

@Fecha datetime 

AS 

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2), @FechaMasUno datetime

SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')
SET @FechaMasUno=DATEADD(day,1,@Fecha)

CREATE TABLE #Auxiliar1
			(
			 IdBanco INTEGER,
			 IdCuentaBancaria INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2),
			 ChequesPendientes NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  CuentasBancarias.IdBanco,
  Valores.IdCuentaBancariaDeposito,
  Valores.Importe,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancariaDeposito=CuentasBancarias.IdCuentaBancaria
 WHERE Valores.Estado='D' and CuentasBancarias.IdCuentaBancaria is not null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	  Case When Valores.FechaDeposito is not null 
		Then Valores.FechaDeposito
		Else Valores.FechaComprobante 
	  End<=DATEADD(n,1439,@Fecha)

 UNION ALL 

 SELECT 
  CuentasBancarias.IdBanco,
  Valores.IdCuentaBancaria,
  Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 
		Then Valores.Importe  Else Valores.Importe*-1 End 
	Else 0 
  End,
  Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 
		Then Valores.Importe  Else Valores.Importe*-1 End 
	Else 0 
  End,
  0
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	CuentasBancarias.IdCuentaBancaria is not null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Case When IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI'
		Then 	Case When (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor) is not null
				Then (Select Top 1 Asientos.FechaAsiento 
					From DetalleAsientos da 
					Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento
					Where da.IdValor=Valores.IdValor)
				Else Valores.FechaValor
			End
		Else Valores.FechaComprobante 
	End<=DATEADD(n,1439,@Fecha) and 
	not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')

 UNION ALL 

 SELECT 
  CuentasBancarias.IdBanco,
  Valores.IdCuentaBancaria,
  Case When tc.Coeficiente=-1 Then Valores.Importe Else 0 End,
  Case When tc.Coeficiente=1 Then Valores.Importe Else 0 End,
  0
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 WHERE Valores.Estado='G' and CuentasBancarias.IdCuentaBancaria is not null and 
	Valores.FechaComprobante<=DATEADD(n,1439,@Fecha) and IsNull(Valores.Anulado,'NO')<>'SI'

 UNION ALL 

 SELECT
  CuentasBancarias.IdBanco,
  Valores.IdCuentaBancaria,
  Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else 0 
  End,
  Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else 0 
  End,
  0
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	CuentasBancarias.IdCuentaBancaria is not null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.Estado is null and Valores.FechaComprobante<=DATEADD(n,1439,@Fecha) and 
	not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')

 UNION ALL 

 SELECT
  CuentasBancarias.IdBanco,
  Valores.IdCuentaBancaria,
  0,
  0,
  Valores.Importe
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopv.IdOrdenPago
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and Valores.IdTipoComprobante=17 and 
	@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
	IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
	OrdenesPago.FechaOrdenPago<=@Fecha and 
	IsNull((Select Top 1 Asientos.FechaAsiento From DetalleAsientos da Left Outer Join Asientos On Asientos.IdAsiento=da.IdAsiento Where da.IdValor=Valores.IdValor),@FechaMasUno)>@Fecha and 
	Not (IsNull(Valores.RegistroContableChequeDiferido,'NO')='SI' and Not Exists(Select Top 1 da1.IdValor From DetalleAsientos da1 Where da1.IdValor=Valores.IdValor))

UPDATE #Auxiliar1
SET IdBanco=0
WHERE IdBanco IS NULL

UPDATE #Auxiliar1
SET Ingresos=0
WHERE Ingresos IS NULL

UPDATE #Auxiliar1
SET Egresos=0
WHERE Egresos IS NULL


CREATE TABLE #Auxiliar2
			(
			 IdBanco INTEGER,
			 IdCuentaBancaria INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2),
			 ChequesPendientes NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdBanco,
  #Auxiliar1.IdCuentaBancaria,
  SUM(#Auxiliar1.Ingresos),
  SUM(#Auxiliar1.Egresos),
  SUM(#Auxiliar1.ChequesPendientes)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdBanco,#Auxiliar1.IdCuentaBancaria

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011166633'
Set @vector_T='050E44400'

SELECT 
 Bancos.IdBanco,
 Bancos.Nombre as [Banco],
 CuentasBancarias.Cuenta as [Cuenta banco],
 Monedas.Nombre as [Moneda],
 Ingresos-Egresos as [Saldo],
 ChequesPendientes as [Cheques dif.],
 (Ingresos-Egresos)-ChequesPendientes as [Saldo final],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Bancos ON #Auxiliar2.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN CuentasBancarias ON #Auxiliar2.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN Monedas ON CuentasBancarias.IdMoneda=Monedas.IdMoneda
WHERE Ingresos-Egresos<>0 or ChequesPendientes<>0
ORDER BY Bancos.Nombre

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2