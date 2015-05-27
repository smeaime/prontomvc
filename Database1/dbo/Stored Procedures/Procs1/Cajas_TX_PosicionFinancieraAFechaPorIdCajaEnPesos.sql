
CREATE PROCEDURE [dbo].[Cajas_TX_PosicionFinancieraAFechaPorIdCajaEnPesos]

@IdCaja Int,
@Fecha datetime

AS

SET NOCOUNT ON

Declare @FechaArranqueCajaYBancos datetime
Set @FechaArranqueCajaYBancos=ISNULL((Select FechaArranqueCajaYBancos 
					From Parametros
					Where IdParametro=1),Convert(datetime,'01/01/1980'))

CREATE TABLE #Auxiliar1(
			 IdCaja INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdCaja,
  Case 	When Valores.IdDetalleAsiento is null or Isnull(Valores.Importe,0)<>0
	 Then 	Case When ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
			    Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
			   (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
			    Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0))
			  and not Valores.IdTipoComprobante=14
			Then 	Case 	When Valores.Importe * 
						Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
					 Then Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
					 Else Valores.Importe * Isnull((Select top 1 TiposComprobante.Coeficiente
									From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1) * -1 
				End 
			Else 0 
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
			   Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
							From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0) or 
			  Valores.IdTipoComprobante=14
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
WHERE Valores.IdCaja is not null and Valores.IdCaja=@IdCaja and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
		Then Valores.FechaDeposito
		Else Valores.FechaComprobante 
	End>=@FechaArranqueCajaYBancos and 
	Case When Valores.IdBancoDeposito is not null and Valores.FechaDeposito is not null 
		Then Valores.FechaDeposito
		Else Valores.FechaComprobante 
	End<=DATEADD(n,1439,@Fecha) 

UPDATE #Auxiliar1
SET Ingresos=0
WHERE Ingresos IS NULL

UPDATE #Auxiliar1
SET Egresos=0
WHERE Egresos IS NULL


CREATE TABLE #Auxiliar2(
			 IdCaja INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdCaja,
  SUM(#Auxiliar1.Ingresos),
  SUM(#Auxiliar1.Egresos)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdCaja

SET NOCOUNT OFF

SELECT Ingresos-Egresos as [Saldo]
FROM #Auxiliar2

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
