CREATE PROCEDURE [dbo].[OrdenesCompra_TX_OrdenesAutomaticasPrefacturacion]

@FechaFacturacion datetime,
@Conceptos varchar(100),
@Grupo int

AS

SET NOCOUNT ON

DECLARE @P_IVA1 Numeric(6,2), @VendedorLegales int

SET @P_IVA1=IsNull((Select Parametros.Iva1 From Parametros Where Parametros.IdParametro=1),0)
SET @VendedorLegales=Convert(integer,Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Codigo vendedor para inmovilizar ordenes de compra'),'0'))

CREATE TABLE #Auxiliar1
			(
			 IdDetalleOrdenCompra INTEGER,
			 IdOrdenCompra INTEGER,
			 FechaOrdenCompra DATETIME,
			 FechaComienzoFacturacion DATETIME,
			 NumeroItem INTEGER,
			 IdCliente INTEGER,
			 IdCodigoIva INTEGER,
			 IdArticulo INTEGER,
			 OrigenDescripcion INTEGER,
			 Observaciones NTEXT,
			 Cantidad NUMERIC(18, 2),
			 IdUnidad INTEGER,
			 Precio NUMERIC(18, 2),
			 PorcentajeBonificacion NUMERIC(6, 2),
			 Importe NUMERIC(18, 2),
			 Iva NUMERIC(18, 2),
			 Total NUMERIC(18, 2),
			 FacturacionCompletaMensual VARCHAR(2),
			 Detalle VARCHAR(100)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  doc.IdDetalleOrdenCompra,
  doc.IdOrdenCompra,
  OrdenesCompra.FechaOrdenCompra,
  doc.FechaComienzoFacturacion,
  doc.NumeroItem,
  OrdenesCompra.IdCliente,
  IsNull(Clientes.IdCodigoIva,0),
  doc.IdArticulo,
  doc.OrigenDescripcion,
  doc.Observaciones,
  doc.Cantidad,
  doc.IdUnidad,
  doc.Precio,
  IsNull(doc.PorcentajeBonificacion,0),
  0,
  0,
  0,
  doc.FacturacionCompletaMensual,
  Null
 FROM DetalleOrdenesCompra doc
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
 LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente = Clientes.IdCliente
 LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor = Clientes.Vendedor1
 WHERE IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and 
	IsNull(doc.FacturacionAutomatica,'NO')='SI' and 
	IsNull(doc.FechaComienzoFacturacion,GetDate())<=@FechaFacturacion and 
	IsNull(Obras.Activa,'SI')='SI' and 
	IsNull(Clientes.IdEstado,0)<>2 and
	not Exists (Select Top 1 dfoc.IdDetalleFactura
			From DetalleFacturasOrdenesCompra dfoc
			Left Outer Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			Left Outer Join Facturas fa On fa.IdFactura=df.IdFactura
			Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				IsNull(fa.Anulada,'NO')<>'SI' and 
				Year(fa.FechaFactura)=Year(@FechaFacturacion) and 
				Month(fa.FechaFactura)=Month(@FechaFacturacion)) and 
	(IsNull(doc.CantidadMesesAFacturar,0)=0 or 
	 (IsNull(doc.CantidadMesesAFacturar,0)<>0 and 
	  IsNull((Select Top 1 Count(*)
			From DetalleFacturasOrdenesCompra dfoc
			Left Outer Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			Left Outer Join Facturas fa On fa.IdFactura=df.IdFactura
			Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				IsNull(fa.Anulada,'NO')<>'SI'),0)<IsNull(doc.CantidadMesesAFacturar,0))) and 
	(@Grupo=-1 or 
	 (@Grupo>0 and IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=@Grupo)) and 
	(@VendedorLegales=0 or IsNull(Vendedores.CodigoVendedor,0)<>@VendedorLegales)

UPDATE #Auxiliar1
SET Detalle = 'Fact. proporcional (abonos) desde el '+Convert(varchar,FechaComienzoFacturacion,103)+
		', precio total OC '+Convert(varchar,Precio)
WHERE YEAR(@FechaFacturacion)=YEAR(FechaComienzoFacturacion) and 
	MONTH(@FechaFacturacion)=MONTH(FechaComienzoFacturacion) and 
	(@Conceptos='*' or Patindex('%'+Convert(varchar,IdArticulo)+'%', @Conceptos)<>0) and 
	IsNull(FacturacionCompletaMensual,'NO')<>'SI'

UPDATE #Auxiliar1
SET Precio = Round(Precio / 
			Day(Dateadd(d,-1,Convert(datetime,'1/' + Convert(varchar,Month(Dateadd(m,1,@FechaFacturacion))) + '/' + 
					Convert(varchar,Year(Dateadd(m,1,@FechaFacturacion))),103))) * 
			(Day(Dateadd(d,-1,Convert(datetime,'1/' + Convert(varchar,Month(Dateadd(m,1,@FechaFacturacion))) + '/' + 
					Convert(varchar,Year(Dateadd(m,1,@FechaFacturacion))),103))) - 
			 Day(FechaComienzoFacturacion) + 1) ,2)
WHERE YEAR(@FechaFacturacion)=YEAR(FechaComienzoFacturacion) and 
	MONTH(@FechaFacturacion)=MONTH(FechaComienzoFacturacion) and 
	(@Conceptos='*' or Patindex('%'+Convert(varchar,IdArticulo)+'%', @Conceptos)<>0) and 
	IsNull(FacturacionCompletaMensual,'NO')<>'SI'

UPDATE #Auxiliar1
SET Importe = IsNull(Cantidad,0) * IsNull(Precio,0) * (1-IsNull(PorcentajeBonificacion,0)/100)

UPDATE #Auxiliar1
SET Iva = Importe * @P_IVA1 / 100
WHERE IdCodigoIva<>8 and IdCodigoIva<>9

UPDATE #Auxiliar1
SET Total = Importe + Iva

SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='0000001111111166666133'
Set @vector_T='00000022402D0022222000'

SELECT 
 0 as [K_Id],
 Clientes.RazonSocial as [K_Cliente],
 #Auxiliar1.IdCliente as [K_IdCliente],
 1 as [K_Tipo],
 0 as [K_NumeroOrdenCompra],
 0 as [K_NumeroItem],
 Clientes.RazonSocial as [Cliente],
 Null as [Nro.OC],
 Null as [Fecha OC],
 Null as [Item],
 Null as [Codigo],
 Null as [Descripcion],
 Null as [Cant.],
 Null as [UM],
 Null as [Pr.Un.],
 Null as [% Bon.],
 Null as [Importe],
 Null as [Iva],
 Null as [Total],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
GROUP BY Clientes.RazonSocial, #Auxiliar1.IdCliente

UNION ALL

SELECT 
 #Auxiliar1.IdDetalleOrdenCompra as [K_Id],
 Clientes.RazonSocial as [K_Cliente],
 #Auxiliar1.IdCliente as [K_IdCliente],
 2 as [K_Tipo],
 OrdenesCompra.NumeroOrdenCompra as [K_NumeroOrdenCompra],
 #Auxiliar1.NumeroItem as [K_NumeroItem],
 Null as [Cliente],
 OrdenesCompra.NumeroOrdenCompra as [Nro.OC],
 #Auxiliar1.FechaOrdenCompra as [Fecha OC],
 #Auxiliar1.NumeroItem as [Item],
 Articulos.Codigo as [Codigo],
 Case 	When OrigenDescripcion=1 
	 Then Articulos.Descripcion COLLATE Modern_Spanish_CI_AS
	When OrigenDescripcion=2 
	 Then ltrim(Articulos.Descripcion COLLATE Modern_Spanish_CI_AS)+' '+
		Convert(varchar(200),#Auxiliar1.Observaciones)
	When OrigenDescripcion=3 
	 Then Convert(varchar(500),#Auxiliar1.Observaciones)
 End as [Descripcion],
 #Auxiliar1.Cantidad as [Cant.],
 Unidades.Abreviatura as [UM],
 #Auxiliar1.Precio as [Pr.Un.],
 #Auxiliar1.PorcentajeBonificacion as [% Bon.],
 #Auxiliar1.Importe as [Importe],
 #Auxiliar1.Iva as [Iva],
 #Auxiliar1.Total as [Total],
 #Auxiliar1.Detalle as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN OrdenesCompra ON #Auxiliar1.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad

UNION ALL

SELECT 
 0 as [K_Id],
 Clientes.RazonSocial as [K_Cliente],
 #Auxiliar1.IdCliente as [K_IdCliente],
 3 as [K_Tipo],
 0 as [K_NumeroOrdenCompra],
 0 as [K_NumeroItem],
 '     TOTAL FACTURA CLIENTE' as [Cliente],
 Null as [Nro.OC],
 Null as [Fecha OC],
 Null as [Item],
 Null as [Codigo],
 Null as [Descripcion],
 Null as [Cant.],
 Null as [UM],
 Null as [Pr.Un.],
 Null as [% Bon.],
 SUM(#Auxiliar1.Importe) as [Importe],
 SUM(#Auxiliar1.Iva) as [Iva],
 SUM(#Auxiliar1.Total) as [Total],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
GROUP BY Clientes.RazonSocial, #Auxiliar1.IdCliente

UNION ALL

SELECT 
 0 as [K_Id],
 Clientes.RazonSocial as [K_Cliente],
 #Auxiliar1.IdCliente as [K_IdCliente],
 4 as [K_Tipo],
 0 as [K_NumeroOrdenCompra],
 0 as [K_NumeroItem],
 Null as [Cliente],
 Null as [Nro.OC],
 Null as [Fecha OC],
 Null as [Item],
 Null as [Codigo],
 Null as [Descripcion],
 Null as [Cant.],
 Null as [UM],
 Null as [Pr.Un.],
 Null as [% Bon.],
 Null as [Importe],
 Null as [Iva],
 Null as [Total],
 Null as [Detalle],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
GROUP BY Clientes.RazonSocial, #Auxiliar1.IdCliente

ORDER BY [K_Cliente], [K_IdCliente], [K_Tipo], [K_NumeroOrdenCompra], [K_NumeroItem]

DROP TABLE #Auxiliar1