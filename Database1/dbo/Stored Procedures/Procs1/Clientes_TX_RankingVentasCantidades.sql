CREATE PROCEDURE [dbo].[Clientes_TX_RankingVentasCantidades]

@Desde datetime,
@hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(100),
			 A_TotalCantidad NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar 
 SELECT 
	Cli.Codigo,
	Cli.RazonSocial,
	Det.Cantidad
 FROM DetalleFacturas Det 
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=Det.IdFactura
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta) and IsNull(Fac.Anulada,'NO')<>'SI'

UNION ALL 

 SELECT 
	Cli.Codigo,
	Cli.RazonSocial,
	Det.Cantidad * -1
 FROM DetalleDevoluciones Det 
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=Det.IdDevolucion
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta) and IsNull(Dev.Anulada,'NO')<>'SI'


CREATE TABLE #Auxiliar1 
			(
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(100),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  #Auxiliar.A_CodigoCliente,
  #Auxiliar.A_Cliente,
  SUM(#Auxiliar.A_TotalCantidad)
 FROM #Auxiliar
 GROUP BY #Auxiliar.A_CodigoCliente, #Auxiliar.A_Cliente

DECLARE @TotalVentas numeric(18,2)
SET @TotalVentas=ISNULL((SELECT SUM(A_Total) FROM #Auxiliar1),0)

CREATE TABLE #Auxiliar2 
			(
			 A_Renglon INTEGER IDENTITY (1, 1),
			 A_CodigoCliente VARCHAR(10),
			 A_Cliente VARCHAR(100),
			 A_Total NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.A_CodigoCliente,
  #Auxiliar1.A_Cliente,
  #Auxiliar1.A_Total
 FROM #Auxiliar1
 ORDER By #Auxiliar1.A_Total DESC

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='01116633'
SET @vector_T='03666600'

SELECT 
 0 as [IdReg],
 A_Renglon as [Item],
 A_CodigoCliente as [Codigo],
 A_Cliente as [Cliente],
 Case When A_Total<>0 Then A_Total Else Null End as [Cant.],
 Case When @TotalVentas<>0 Then Round(A_Total/@TotalVentas*100,3) Else Null End as [% s/Cant.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2 

UNION ALL 

SELECT 
 2 as [IdReg],
 Null as [Item],
 Null as [Codigo],
 'TOTAL GENERAL' as [Cliente],
 SUM(A_Total) as [Cant.],
 Null as [% s/Cant.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2 

ORDER By [IdReg]

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2