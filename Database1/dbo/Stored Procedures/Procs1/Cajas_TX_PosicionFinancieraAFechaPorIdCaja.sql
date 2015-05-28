
CREATE PROCEDURE [dbo].[Cajas_TX_PosicionFinancieraAFechaPorIdCaja]

@IdCaja Int,
@Fecha datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (
			 IdCaja INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2),
			 IngresosDelDia NUMERIC(18, 2),
			 EgresosDelDia NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdCaja,
  Case 	When 	((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		 (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0))
		and not Valores.IdTipoComprobante=14
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
  					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0) or 
		Valores.IdTipoComprobante=14
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else Null 
  End,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 WHERE Valores.IdCaja is not null and Valores.IdCaja=@IdCaja and Valores.FechaComprobante<=DATEADD(n,1439,@Fecha) and IsNull(Valores.Anulado,'NO')<>'SI'

INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdCaja,
  0,
  0,
  Case 	When 	((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		 (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		  Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0))
		and not Valores.IdTipoComprobante=14
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
  					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0) or 
		Valores.IdTipoComprobante=14
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else Null 
  End
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 WHERE Valores.IdCaja is not null and Valores.IdCaja=@IdCaja and Valores.FechaComprobante=@Fecha and IsNull(Valores.Anulado,'NO')<>'SI'


UPDATE #Auxiliar1
SET Ingresos=IsNull(Ingresos,0), Egresos=IsNull(Egresos,0), IngresosDelDia=IsNull(IngresosDelDia,0), EgresosDelDia=IsNull(EgresosDelDia,0)

CREATE TABLE #Auxiliar2(
			 IdCaja INTEGER,
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2),
			 IngresosDelDia NUMERIC(18, 2),
			 EgresosDelDia NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdCaja, Sum(IsNull(#Auxiliar1.Ingresos,0)), Sum(IsNull(#Auxiliar1.Egresos,0)), 
	Sum(IsNull(#Auxiliar1.IngresosDelDia,0)), Sum(IsNull(#Auxiliar1.EgresosDelDia,0))
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdCaja

SET NOCOUNT OFF

SELECT Ingresos, Egresos, Ingresos-Egresos as [Saldo], IngresosDelDia, EgresosDelDia, IngresosDelDia-EgresosDelDia as [SaldoDelDia] 
FROM #Auxiliar2

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
