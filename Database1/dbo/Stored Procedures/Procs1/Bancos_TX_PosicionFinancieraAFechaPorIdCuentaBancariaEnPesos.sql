
CREATE PROCEDURE [dbo].[Bancos_TX_PosicionFinancieraAFechaPorIdCuentaBancariaEnPesos]

@IdCuentaBancaria Int,
@Fecha datetime

AS

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2), @FechaArranqueCajaYBancos datetime

SET @ActivarCircuitoChequesDiferidos=Isnull((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')
SET @FechaArranqueCajaYBancos=Isnull((Select FechaArranqueCajaYBancos From Parametros Where IdParametro=1),Convert(datetime,'01/01/1980'))

CREATE TABLE #Auxiliar1
			(
			 IdCuentaBancaria INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdCuentaBancariaDeposito,
  Valores.Importe * Case When Valores.IdMoneda=1 Then 1
			When Valores.IdMoneda=2 Then Isnull(Valores.CotizacionMoneda,3) 
			Else Isnull(Valores.CotizacionMoneda,1) 
		    End,
  0
 FROM Valores 
 WHERE Valores.Estado='D' And Valores.IdCuentaBancariaDeposito=@IdCuentaBancaria and 
	  IsNull(Valores.FechaDeposito,Valores.FechaComprobante)>=@FechaArranqueCajaYBancos and 
	  IsNull(Valores.FechaDeposito,Valores.FechaComprobante)<=DATEADD(n,1439,@Fecha) and IsNull(Valores.Anulado,'NO')<>'SI'

 UNION ALL 

 SELECT 
  Valores.IdCuentaBancaria,
  Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
	Else 0 
  End * Case When Valores.IdMoneda=2 Then Isnull(Valores.CotizacionMoneda,3) Else Isnull(Valores.CotizacionMoneda,1) End,
  Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)
	Then Case When Valores.Importe>=0 Then Valores.Importe  Else Valores.Importe*-1 End 
	Else 0 
  End * Case When Valores.IdMoneda=2 Then Isnull(Valores.CotizacionMoneda,3) Else Isnull(Valores.CotizacionMoneda,1) End
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	Valores.IdCuentaBancaria=@IdCuentaBancaria and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.FechaComprobante<=DATEADD(n,1439,@Fecha) and 
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
	End>=@FechaArranqueCajaYBancos and 
	not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')

 UNION ALL 

 SELECT 
  Valores.IdCuentaBancaria,
  Case When tc.Coeficiente=-1 Then Valores.Importe Else 0 End * Case When Valores.IdMoneda=2 Then Isnull(Valores.CotizacionMoneda,3) Else Isnull(Valores.CotizacionMoneda,1) End,
  Case When tc.Coeficiente=1 Then Valores.Importe Else 0 End * Case When Valores.IdMoneda=2 Then Isnull(Valores.CotizacionMoneda,3) Else Isnull(Valores.CotizacionMoneda,1) End
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 WHERE Valores.Estado='G' And Valores.IdCuentaBancaria=@IdCuentaBancaria and 
	Valores.FechaComprobante>=@FechaArranqueCajaYBancos and 
	Valores.FechaComprobante<=DATEADD(n,1439,@Fecha) and IsNull(Valores.Anulado,'NO')<>'SI'

 UNION ALL 

 SELECT
  Valores.IdCuentaBancaria,
  Case 	When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
	 Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
  							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
			Then 	Case 	When Valores.Importe * 
						Isnull((Select top 1 TiposComprobante.Coeficiente
  							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
					 Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
					 Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
				End 
			Else Null 
		End * Case When Valores.IdMoneda=2 Then Isnull(Valores.CotizacionMoneda,3) Else Isnull(Valores.CotizacionMoneda,1) End
	 Else 	Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)>0
			Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)
			Else Null
		End
  End,
  Case 	When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
	 Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			   Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
			Then 	Case 	When Valores.Importe * 
						Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
					 Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
					 Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
				End 
			Else Null 
		End * Case When Valores.IdMoneda=2 Then Isnull(Valores.CotizacionMoneda,3) Else Isnull(Valores.CotizacionMoneda,1) End 
	 Else 	Case When IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0)<0
			Then IsNull(DetalleAsientos.Debe,0)-IsNull(DetalleAsientos.Haber,0) * -1
			Else Null
		End
  End
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN DetalleAsientos ON Valores.IdDetalleAsiento=DetalleAsientos.IdDetalleAsiento
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	Valores.Estado is null and Valores.IdCuentaBancaria=@IdCuentaBancaria and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.FechaComprobante<=DATEADD(n,1439,@Fecha) and 
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
	End>=@FechaArranqueCajaYBancos and 
	not (@ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO')


UPDATE #Auxiliar1
SET Ingresos=0
WHERE Ingresos IS NULL

UPDATE #Auxiliar1
SET Egresos=0
WHERE Egresos IS NULL


CREATE TABLE #Auxiliar2
			(
			 IdCuentaBancaria INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdCuentaBancaria,
  SUM(#Auxiliar1.Ingresos),
  SUM(#Auxiliar1.Egresos)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdCuentaBancaria

SET NOCOUNT OFF

SELECT Ingresos-Egresos as [Saldo]
FROM #Auxiliar2

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
