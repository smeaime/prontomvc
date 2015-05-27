
CREATE PROCEDURE [dbo].[Recibos_TX_PorCobrador]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdRecibo INTEGER,
			 IdMoneda INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT Recibos.IdRecibo, Recibos.IdMoneda, IsNull(Recibos.Deudores,0)
 FROM Recibos
 WHERE Recibos.FechaRecibo between @Desde and @hasta and 
	IsNull(Recibos.Anulado,'NO')<>'SI' and Recibos.IdCliente is not null

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30),@vector_E varchar(200)
SET @vector_X='000000111111633'
SET @vector_T='000000040E00200'

SELECT 
 0 as [IdAux1],
 1 as [IdAux2],
 Vendedores.Nombre as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 Null as [IdAux6],
 Vendedores.Nombre as [Vendedor],
 Null as [Fecha], 
 Null as [Cliente],
 Null as [Recibo],
 Null as [Mon.],
 Null as [Cambio],
 Null as [Importe $],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON #Auxiliar1.IdRecibo = Recibos.IdRecibo
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
LEFT OUTER JOIN Vendedores ON Clientes.Cobrador = Vendedores.IdVendedor
GROUP BY Vendedores.Nombre

UNION ALL

SELECT 
 #Auxiliar1.IdRecibo as [IdAux1],
 2 as [IdAux2],
 Vendedores.Nombre as [IdAux3],
 Recibos.IdMoneda as [IdAux4],
 0 as [IdAux5],
 Recibos.FechaRecibo as [IdAux6],
 Null as [Vendedor],
 Recibos.FechaRecibo as [Fecha], 
 Convert(varchar,Clientes.CodigoCliente)+' '+Clientes.RazonSocial as [Cliente],
 Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+
	Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recibos.NumeroRecibo)))+
	Convert(varchar,Recibos.NumeroRecibo) as [Recibo],
 Monedas.Abreviatura as [Mon.],
 Case When Recibos.IdMoneda<>1 Then 'Cot. '+Convert(varchar,IsNull(Recibos.CotizacionMoneda,0)) Else Null End as [Cambio],
 #Auxiliar1.Importe*Recibos.CotizacionMoneda as [Importe $],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON #Auxiliar1.IdRecibo = Recibos.IdRecibo
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Vendedores ON Clientes.Cobrador = Vendedores.IdVendedor

UNION ALL

SELECT 
 0 as [IdAux1],
 3 as [IdAux2],
 Vendedores.Nombre as [IdAux3],
 Null as [IdAux4],
 0 as [IdAux5],
 Null as [IdAux6],
 Null as [Vendedor],
 Null as [Fecha], 
 Null as [Cliente],
 Null as [Recibo],
 Null as [Mon.],
 'TOTAL' as [Cambio],
 Sum(#Auxiliar1.Importe*Recibos.CotizacionMoneda) as [Importe $],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Recibos ON #Auxiliar1.IdRecibo = Recibos.IdRecibo
LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
LEFT OUTER JOIN Vendedores ON Clientes.Cobrador = Vendedores.IdVendedor
GROUP BY Vendedores.Nombre

ORDER BY [IdAux3], [IdAux2], [IdAux6], [IdAux1]

DROP TABLE #Auxiliar1
