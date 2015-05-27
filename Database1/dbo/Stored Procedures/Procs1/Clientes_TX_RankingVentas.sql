CREATE PROCEDURE [dbo].[Clientes_TX_RankingVentas]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @Desde1 datetime, @Hasta1 datetime, @Desde2 datetime, @Hasta2 datetime, @Desde3 datetime, @Hasta3 datetime

SET @Desde1=DateAdd(year,-1,@Desde)
SET @Hasta1=DateAdd(year,-1,@Hasta)
SET @Desde2=DateAdd(year,-2,@Desde)
SET @Hasta2=DateAdd(year,-2,@Hasta)
SET @Desde3=DateAdd(year,-3,@Desde)
SET @Hasta3=DateAdd(year,-3,@Hasta)

--select @Desde,@Hasta,@Desde1,@Hasta1,@Desde2,@Hasta2,@Desde3,@Hasta3

CREATE TABLE #Auxiliar 
			(
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(100),
			 A_Total1 NUMERIC(18, 2),
			 A_Total2 NUMERIC(18, 2),
			 A_Total3 NUMERIC(18, 2),
			 A_Total4 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar 
 SELECT 
	Cli.Codigo,
	Cli.RazonSocial,
	Case When Fac.FechaFactura between @Desde and DATEADD(n,1439,@Hasta) 
		Then Case When Fac.TipoABC='B' 
				Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) / (1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
				Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) * Fac.CotizacionMoneda
			 End
		Else 0
	End,
	Case When Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 
		Then Case When Fac.TipoABC='B' 
				Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) / (1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
				Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) * Fac.CotizacionMoneda
			 End
		Else 0
	End,
	Case When Fac.FechaFactura between @Desde2 and DATEADD(n,1439,@Hasta2) 
		Then Case When Fac.TipoABC='B' 
				Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) / (1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
				Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) * Fac.CotizacionMoneda
			 End
		Else 0
	End,
	Case When Fac.FechaFactura between @Desde3 and DATEADD(n,1439,@Hasta3) 
		Then Case When Fac.TipoABC='B' 
				Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) / (1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
				Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - Fac.PercepcionIVA) * Fac.CotizacionMoneda
			 End
		Else 0
	End
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE IsNull(Fac.Anulada,'')<>'SI' and 
		(Fac.FechaFactura between @Desde and DATEADD(n,1439,@Hasta) or Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) or 
		 Fac.FechaFactura between @Desde2 and DATEADD(n,1439,@Hasta2) or Fac.FechaFactura between @Desde3 and DATEADD(n,1439,@Hasta3))

UNION ALL 

 SELECT 
	Cli.Codigo,
	Cli.RazonSocial,
	Case When Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@Hasta)
		Then Case When Dev.TipoABC='B' 
				Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
				Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) * Dev.CotizacionMoneda * -1
			 End
		Else 0
	End,
	Case When Dev.FechaDevolucion between @Desde1 and DATEADD(n,1439,@Hasta1)
		Then Case When Dev.TipoABC='B' 
				Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
				Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) * Dev.CotizacionMoneda * -1
			 End
		Else 0
	End,
	Case When Dev.FechaDevolucion between @Desde2 and DATEADD(n,1439,@Hasta2)
		Then Case When Dev.TipoABC='B' 
				Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
				Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) * Dev.CotizacionMoneda * -1
			 End
		Else 0
	End,
	Case When Dev.FechaDevolucion between @Desde3 and DATEADD(n,1439,@Hasta3)
		Then Case When Dev.TipoABC='B' 
				Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * -1
				Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - Dev.PercepcionIVA) * Dev.CotizacionMoneda * -1
			 End
		Else 0
	End
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE IsNull(Dev.Anulada,'')<>'SI' and 
		(Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@Hasta) or Dev.FechaDevolucion between @Desde1 and DATEADD(n,1439,@Hasta1) or 
		 Dev.FechaDevolucion between @Desde2 and DATEADD(n,1439,@Hasta2) or Dev.FechaDevolucion between @Desde3 and DATEADD(n,1439,@Hasta3))

UNION ALL 

 SELECT 
	Cli.Codigo,
	Cli.RazonSocial,
	Case When Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@Hasta)
		Then Case When Deb.TipoABC='B' 
				Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
				Else (Select Sum(IsNull(DetND.Importe,0)) 
						From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Deb.CotizacionMoneda
			 End + IsNull((Select Sum(IsNull(DetND.Importe,0)) 
							From DetalleNotasDebito DetND 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
							Where DetND.IdNotaDebito=Deb.IdNotaDebito and (DetND.Gravado is null or DetND.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Deb.CotizacionMoneda,0)
		Else 0
	End,
	Case When Deb.FechaNotaDebito between @Desde1 and DATEADD(n,1439,@Hasta1)
		Then Case When Deb.TipoABC='B' 
				Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
				Else (Select Sum(IsNull(DetND.Importe,0)) 
						From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Deb.CotizacionMoneda
			 End + IsNull((Select Sum(IsNull(DetND.Importe,0)) 
							From DetalleNotasDebito DetND 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
							Where DetND.IdNotaDebito=Deb.IdNotaDebito and (DetND.Gravado is null or DetND.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Deb.CotizacionMoneda,0)
		Else 0
	End,
	Case When Deb.FechaNotaDebito between @Desde2 and DATEADD(n,1439,@Hasta2)
		Then Case When Deb.TipoABC='B' 
				Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
				Else (Select Sum(IsNull(DetND.Importe,0)) 
						From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Deb.CotizacionMoneda
			 End + IsNull((Select Sum(IsNull(DetND.Importe,0)) 
							From DetalleNotasDebito DetND 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
							Where DetND.IdNotaDebito=Deb.IdNotaDebito and (DetND.Gravado is null or DetND.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Deb.CotizacionMoneda,0)
		Else 0
	End,
	Case When Deb.FechaNotaDebito between @Desde3 and DATEADD(n,1439,@Hasta3)
		Then Case When Deb.TipoABC='B' 
				Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
				Else (Select Sum(IsNull(DetND.Importe,0)) 
						From DetalleNotasDebito DetND 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
						Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Deb.CotizacionMoneda
			 End + IsNull((Select Sum(IsNull(DetND.Importe,0)) 
							From DetalleNotasDebito DetND 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetND.IdConcepto 
							Where DetND.IdNotaDebito=Deb.IdNotaDebito and (DetND.Gravado is null or DetND.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Deb.CotizacionMoneda,0)
		Else 0
	End
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE IsNull(Deb.Anulada,'')<>'SI' and Deb.CtaCte='SI' and 
		(Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@Hasta) or Deb.FechaNotaDebito between @Desde1 and DATEADD(n,1439,@Hasta1) or 
		 Deb.FechaNotaDebito between @Desde2 and DATEADD(n,1439,@Hasta2) or Deb.FechaNotaDebito between @Desde3 and DATEADD(n,1439,@Hasta3))

UNION ALL 

 SELECT 
	Cli.Codigo,
	Cli.RazonSocial,
	Case When Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@Hasta)
		Then Case When Cre.TipoABC='B' 
				Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
				Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Cre.CotizacionMoneda * -1
			 End + IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
							Where DetNC.IdNotaCredito=Cre.IdNotaCredito and (DetNC.Gravado is null or DetNC.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Cre.CotizacionMoneda * -1,0)
		Else 0
	End,
	Case When Cre.FechaNotaCredito between @Desde1 and DATEADD(n,1439,@Hasta1)
		Then Case When Cre.TipoABC='B' 
				Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
				Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Cre.CotizacionMoneda * -1
			 End + IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
							Where DetNC.IdNotaCredito=Cre.IdNotaCredito and (DetNC.Gravado is null or DetNC.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Cre.CotizacionMoneda * -1,0)
		Else 0
	End,
	Case When Cre.FechaNotaCredito between @Desde2 and DATEADD(n,1439,@Hasta2)
		Then Case When Cre.TipoABC='B' 
				Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
				Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Cre.CotizacionMoneda * -1
			 End + IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
							Where DetNC.IdNotaCredito=Cre.IdNotaCredito and (DetNC.Gravado is null or DetNC.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Cre.CotizacionMoneda * -1,0)
		Else 0
	End,
	Case When Cre.FechaNotaCredito between @Desde3 and DATEADD(n,1439,@Hasta3)
		Then Case When Cre.TipoABC='B' 
				Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') / (1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda * -1
				Else (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
						Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
						Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI') * Cre.CotizacionMoneda * -1
			 End + IsNull((Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC 
							Left Outer Join Conceptos On Conceptos.IdConcepto=DetNC.IdConcepto 
							Where DetNC.IdNotaCredito=Cre.IdNotaCredito and (DetNC.Gravado is null or DetNC.Gravado<>'SI' and IsNull(Conceptos.NoTomarEnRanking,'')<>'SI')) * Cre.CotizacionMoneda * -1,0)
		Else 0
	End
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE IsNull(Cre.Anulada,'')<>'SI' and Cre.CtaCte='SI' and 
		(Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@Hasta) or Cre.FechaNotaCredito between @Desde1 and DATEADD(n,1439,@Hasta1) or 
		 Cre.FechaNotaCredito between @Desde2 and DATEADD(n,1439,@Hasta2) or Cre.FechaNotaCredito between @Desde3 and DATEADD(n,1439,@Hasta3))

CREATE TABLE #Auxiliar1 
			(
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(100),
			 A_Total1 NUMERIC(18, 2),
			 A_Total2 NUMERIC(18, 2),
			 A_Total3 NUMERIC(18, 2),
			 A_Total4 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  #Auxiliar.A_CodigoCliente,
  #Auxiliar.A_Cliente,
  Sum(IsNull(#Auxiliar.A_Total1,0)),
  Sum(IsNull(#Auxiliar.A_Total2,0)),
  Sum(IsNull(#Auxiliar.A_Total3,0)),
  Sum(IsNull(#Auxiliar.A_Total4,0))
 FROM #Auxiliar
 GROUP BY #Auxiliar.A_CodigoCliente, #Auxiliar.A_Cliente

DECLARE @TotalVentas numeric(18,2)
SET @TotalVentas=ISNULL((SELECT SUM(A_Total1) FROM #Auxiliar1),0)

CREATE TABLE #Auxiliar2 
			(
			 A_Renglon INTEGER IDENTITY (1, 1),
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(100),
			 A_Total1 NUMERIC(18, 2),
			 A_Total2 NUMERIC(18, 2),
			 A_Total3 NUMERIC(18, 2),
			 A_Total4 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.A_CodigoCliente,
  #Auxiliar1.A_Cliente,
  #Auxiliar1.A_Total1,
  #Auxiliar1.A_Total2,
  #Auxiliar1.A_Total3,
  #Auxiliar1.A_Total4
 FROM #Auxiliar1
 ORDER By #Auxiliar1.A_Total1 DESC, #Auxiliar1.A_Total2 DESC, #Auxiliar1.A_Total3 DESC, #Auxiliar1.A_Total4 DESC

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01116666666633'
SET @vector_T='00214444444400'

SELECT 
 0 as [IdReg],
 A_Renglon as [Item],
 A_CodigoCliente as [Codigo],
 A_Cliente as [Cliente],
 Case When A_Total1<>0 Then A_Total1 Else Null End as [Total],
 Case When @TotalVentas<>0 Then Round(A_Total1/@TotalVentas*100,3) Else Null End as [% s/Total],
 Case When A_Total2<>0 Then A_Total2 Else Null End as [Año -1],
 Case When A_Total1<>0 and A_Total2<>0 Then A_Total2/A_Total1*100 Else Null End as [Dif.% Año -1],
 Case When A_Total3<>0 Then A_Total3 Else Null End as [Año -2],
 Case When A_Total1<>0 and A_Total3<>0 Then A_Total3/A_Total1*100 Else Null End as [Dif.% Año -2],
 Case When A_Total4<>0 Then A_Total4 Else Null End as [Año -3],
 Case When A_Total1<>0 and A_Total4<>0 Then A_Total4/A_Total1*100 Else Null End as [Dif.% Año -3],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2 

UNION ALL 

SELECT 
 2 as [IdReg],
 Null as [Item],
 Null as [Codigo],
 'TOTAL GENERAL' as [Cliente],
 Sum(A_Total1) as [Total],
 Null as [% s/Total],
 Sum(A_Total2) as [Año -1],
 Null as [Dif.% Año -1],
 Sum(A_Total3) as [Año -2],
 Null as [Dif.% Año -2],
 Sum(A_Total4) as [Año -3],
 Null as [Dif.% Año -3],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2 

ORDER By [IdReg]

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2