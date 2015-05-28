CREATE PROCEDURE [dbo].[Clientes_TX_RankingVentasPorVendedor]

@Año int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 Vendedor VARCHAR(50),
			 Mes INTEGER,
			 Cantidad NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar 
 SELECT Vendedores.Nombre, Month(Facturas.FechaFactura), Det.Cantidad
 FROM DetalleFacturas Det 
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Det.IdFactura
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Facturas.IdCliente
 LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=Clientes.Vendedor1
 WHERE Year(Facturas.FechaFactura)=@Año and IsNull(Facturas.Anulada,'NO')<>'SI'

UNION ALL 

 SELECT Vendedores.Nombre, Month(Devoluciones.FechaDevolucion), Det.Cantidad*-1
 FROM DetalleDevoluciones Det 
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Det.IdDevolucion
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Devoluciones.IdCliente
 LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor=Clientes.Vendedor1
 WHERE Year(Devoluciones.FechaDevolucion)=@Año and IsNull(Devoluciones.Anulada,'NO')<>'SI'

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01666666666666633'
SET @vector_T='01222222222222200'

SELECT 
 0 as [IdReg],
 Vendedor as [Vendedor],
 Sum(Case When Mes=1 Then Cantidad Else 0 End) as [Enero],
 Sum(Case When Mes=2 Then Cantidad Else 0 End) as [Febrero],
 Sum(Case When Mes=3 Then Cantidad Else 0 End) as [Marzo],
 Sum(Case When Mes=4 Then Cantidad Else 0 End) as [Abril],
 Sum(Case When Mes=5 Then Cantidad Else 0 End) as [Mayo],
 Sum(Case When Mes=6 Then Cantidad Else 0 End) as [Junio],
 Sum(Case When Mes=7 Then Cantidad Else 0 End) as [Julio],
 Sum(Case When Mes=8 Then Cantidad Else 0 End) as [Agosto],
 Sum(Case When Mes=9 Then Cantidad Else 0 End) as [Setiembre],
 Sum(Case When Mes=10 Then Cantidad Else 0 End) as [Octubre],
 Sum(Case When Mes=11 Then Cantidad Else 0 End) as [Noviembre],
 Sum(Case When Mes=12 Then Cantidad Else 0 End) as [Diciembre],
 Sum(Cantidad) as [Total],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
GROUP BY Vendedor
ORDER By Vendedor

DROP TABLE #Auxiliar