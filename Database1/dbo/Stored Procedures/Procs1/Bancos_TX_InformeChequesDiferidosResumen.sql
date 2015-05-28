
CREATE Procedure [dbo].[Bancos_TX_InformeChequesDiferidosResumen]

@Fecha datetime,
@IdBanco int

AS

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2), @FechaIni datetime, @FechaFin datetime
SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos  
						From Parametros	Where IdParametro=1),'NO')

SET @FechaIni=Convert(datetime,'01/'+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha)),103)
SET @FechaFin=Dateadd(d,-1,Dateadd(m,1,Convert(datetime,'01/'+Convert(varchar,Month(@Fecha))+'/'+Convert(varchar,Year(@Fecha)),103)))

CREATE TABLE #Auxiliar (IdValor INTEGER, Fecha DATETIME, Dia INTEGER)
INSERT INTO #Auxiliar 
 SELECT Valores.IdValor, Valores.FechaValor, Day(Valores.FechaValor)
 FROM Valores 
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and 
	@ActivarCircuitoChequesDiferidos='SI' and 
	Valores.IdTipoValor=6 and 
	Valores.IdTipoComprobante=17 and 
	IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
	IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO' and 
	(@IdBanco=-1 or Valores.IdBanco=@IdBanco)

SET NOCOUNT OFF

SELECT
 1 as [IdAux1],
 Max(#Auxiliar.Fecha) as [IdAux2],
 'TOTALES DIA '+Convert(varchar,#Auxiliar.Dia)+', '+
	'MES '+Convert(varchar,Month(Max(#Auxiliar.Fecha)))+', '+
	'AÑO '+Convert(varchar,Year(Max(#Auxiliar.Fecha))) as [Detalle],
 Sum(Valores.Importe) as [Importe]
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
WHERE #Auxiliar.Fecha<=@FechaFin
GROUP BY #Auxiliar.Dia

UNION ALL

SELECT 2 as [IdAux1], Null as [IdAux2], '' as [Detalle], Null as [Importe]

UNION ALL

SELECT
 3 as [IdAux1],
 Max(#Auxiliar.Fecha) as [IdAux2],
 'TOTALES SEMANA 1, MES '+Convert(varchar,Month(Max(#Auxiliar.Fecha))) as [Detalle],
 Sum(Valores.Importe) as [Importe]
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
WHERE Year(#Auxiliar.Fecha)=Year(Dateadd(m,1,@Fecha)) and 
	Month(#Auxiliar.Fecha)=Month(Dateadd(m,1,@Fecha)) and 
	Day(#Auxiliar.Fecha)<=7

UNION ALL

SELECT
 3 as [IdAux1],
 Max(#Auxiliar.Fecha) as [IdAux2],
 'TOTALES SEMANA 2, MES '+Convert(varchar,Month(Max(#Auxiliar.Fecha))) as [Detalle],
 Sum(Valores.Importe) as [Importe]
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
WHERE Year(#Auxiliar.Fecha)=Year(Dateadd(m,1,@Fecha)) and 
	Month(#Auxiliar.Fecha)=Month(Dateadd(m,1,@Fecha)) and 
	Day(#Auxiliar.Fecha)>7 and Day(#Auxiliar.Fecha)<=14

UNION ALL

SELECT
 3 as [IdAux1],
 Max(#Auxiliar.Fecha) as [IdAux2],
 'TOTALES SEMANA 3, MES '+Convert(varchar,Month(Max(#Auxiliar.Fecha))) as [Detalle],
 Sum(Valores.Importe) as [Importe]
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
WHERE Year(#Auxiliar.Fecha)=Year(Dateadd(m,1,@Fecha)) and 
	Month(#Auxiliar.Fecha)=Month(Dateadd(m,1,@Fecha)) and 
	Day(#Auxiliar.Fecha)>14 and Day(#Auxiliar.Fecha)<=21

UNION ALL

SELECT
 3 as [IdAux1],
 Max(#Auxiliar.Fecha) as [IdAux2],
 'TOTALES SEMANA 4, MES '+Convert(varchar,Month(Max(#Auxiliar.Fecha))) as [Detalle],
 Sum(Valores.Importe) as [Importe]
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
WHERE Year(#Auxiliar.Fecha)=Year(Dateadd(m,1,@Fecha)) and 
	Month(#Auxiliar.Fecha)=Month(Dateadd(m,1,@Fecha)) and 
	Day(#Auxiliar.Fecha)>21

UNION ALL

SELECT 4 as [IdAux1], Null as [IdAux2], '' as [Detalle], Null as [Importe]

UNION ALL

SELECT
 5 as [IdAux1],
 Max(#Auxiliar.Fecha) as [IdAux2],
 'TOTALES MES '+Convert(varchar,Month(Max(#Auxiliar.Fecha))) as [Detalle],
 Sum(Valores.Importe) as [Importe]
FROM #Auxiliar 
LEFT OUTER JOIN Valores ON #Auxiliar.IdValor=Valores.IdValor
WHERE #Auxiliar.Fecha>=Dateadd(m,2,@FechaIni)
GROUP BY Month(#Auxiliar.Fecha), Year(#Auxiliar.Fecha)

ORDER BY [IdAux1], [IdAux2], [Detalle]

DROP TABLE #Auxiliar
