
































CREATE Procedure [dbo].[CtasCtesD_TX_DeudaVencida]
@IdCliente int
AS 
SET NOCOUNT ON
CREATE TABLE #Auxiliar 	(
			 c_IdCliente INTEGER,
			 FechaComprobante DATETIME,
			 FechaVencimiento DATETIME,
			 CodigoCliente INTEGER,
			 Cliente VARCHAR(50),
			 Comprobante VARCHAR(5),
			 NumeroComprobante INTEGER,
			 SaldoDeudor NUMERIC(12,2),
			 SaldoAcreedor NUMERIC(12,2)
			)
INSERT INTO #Auxiliar 
 Select 
	CtaCte.IdCliente,
	CtaCte.Fecha,
	CtaCte.FechaVencimiento,
	Clientes.CodigoCliente,
	Clientes.RazonSocial,
	TiposComprobante.DescripcionAB,
	CtaCte.NumeroComprobante,
	CtaCte.Saldo,
	0
 From CuentasCorrientesDeudores CtaCte
 Left Outer Join Clientes On Clientes.IdCliente=CtaCte.IdCliente
 Left Outer Join TiposComprobante On TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 Where 	((@IdCliente>0 And CtaCte.IdCliente=@IdCliente) Or @IdCliente=-1) And 
	TiposComprobante.Coeficiente=1 And CtaCte.Saldo>0 And CtaCte.IdCliente is not null And 
	(CtaCte.FechaVencimiento is null Or CtaCte.FechaVencimiento<GetDate())
UNION ALL 
 Select 
	CtaCte.IdCliente,
	CtaCte.Fecha,
	CtaCte.FechaVencimiento,
	Clientes.CodigoCliente,
	Clientes.RazonSocial,
	TiposComprobante.DescripcionAB,
	CtaCte.NumeroComprobante,
	0,
	CtaCte.Saldo*-1
 From CuentasCorrientesDeudores CtaCte
 Left Outer Join Clientes On Clientes.IdCliente=CtaCte.IdCliente
 Left Outer Join TiposComprobante On TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 Where 	((@IdCliente>0 And CtaCte.IdCliente=@IdCliente) Or @IdCliente=-1) And 
	TiposComprobante.Coeficiente=-1 And CtaCte.Saldo>0 And CtaCte.IdCliente is not null  
SET NOCOUNT OFF
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='00001111111133'
set @vector_T='00001303445600'
SELECT 
 c_IdCliente,
 1 as [Orden1],
 CodigoCliente as [Orden2],
 1 as [Orden3],
 CodigoCliente as [Codigo],
 Cliente,
 Comprobante as [Comp.],
 NumeroComprobante as [Nro. comp.],
 FechaComprobante as [Fecha comp.],
 FechaVencimiento as [Fecha vto.],
 Convert(Money,SaldoDeudor) as [Imp.vencido],
 Null as [Sdos. no aplicados],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
WHERE SaldoDeudor>0
UNION ALL 
SELECT 
 c_IdCliente,
 1 as [Orden1],
 CodigoCliente as [Orden2],
 2 as [Orden3],
 CodigoCliente as [Codigo],
 Cliente,
 Null as [Comp.],
 Null as [Nro. comp.],
 Null as [Fecha comp.],
 Null as [Fecha vto.],
 Null as [Imp.vencido],
 Convert(Money,SUM(SaldoAcreedor)) as [Sdos. no aplicados],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
WHERE SaldoAcreedor<0
GROUP By c_IdCliente,CodigoCliente,Cliente
UNION ALL 
SELECT 
 c_IdCliente,
 1 as [Orden1],
 CodigoCliente as [Orden2],
 3 as [Orden3],
 CodigoCliente as [Codigo],
 'TOTALES CLIENTE' as [Cliente],
 Null as [Comp.],
 Null as [Nro. comp.],
 Null as [Fecha comp.],
 Null as [Fecha vto.],
 Convert(Money,SUM(SaldoDeudor)) as [Imp.vencido],
 Convert(Money,SUM(SaldoAcreedor)) as [Sdos. no aplicados],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
GROUP By c_IdCliente,CodigoCliente
UNION ALL 
SELECT 
 c_IdCliente,
 1 as [Orden1],
 CodigoCliente as [Orden2],
 4 as [Orden3],
 Null as [Codigo],
 Null as [Cliente],
 Null as [Comp.],
 Null as [Nro. comp.],
 Null as [Fecha comp.],
 Null as [Fecha vto.],
 Null as [Imp.vencido],
 Null as [Sdos. no aplicados],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
GROUP By c_IdCliente,CodigoCliente
UNION ALL 
SELECT 
 0,
 2 as [Orden1],
 Null as [Orden2],
 0 as [Orden3],
 Null as [Codigo],
 'TOTALES GENERALES' as [Cliente],
 Null as [Comp.],
 Null as [Nro. comp.],
 Null as [Fecha comp.],
 Null as [Fecha vto.],
 Convert(Money,SUM(SaldoDeudor)) as [Imp.vencido],
 Convert(Money,SUM(SaldoAcreedor)) as [Sdos. no aplicados],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
ORDER By [Orden1],[Orden2],[Orden3],[Fecha vto.]
DROP TABLE #Auxiliar

































