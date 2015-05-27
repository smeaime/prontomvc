CREATE PROCEDURE [dbo].[OrdenesCompra_TX_OrdenesAFacturarAutomaticas_PorCliente]

@FechaFacturacion datetime,
@Conceptos varchar(100),
@SoloAbonos varchar(2),
@Grupo int,
@OCSeleccionadas varchar(1)

AS

SET NOCOUNT ON

DECLARE @VendedorLegales int

SET @VendedorLegales=Convert(integer,Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Codigo vendedor para inmovilizar ordenes de compra'),'0'))

CREATE TABLE #Auxiliar1
			(
			 IdCliente INTEGER,
			 IdObra INTEGER,
			 IdUnidadOperativa INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  OrdenesCompra.IdCliente,
  Case 	When IsNull(OrdenesCompra.AgrupacionFacturacion,1)=2 Then IsNull(OrdenesCompra.IdObra,0)
	Else 0
  End,
  Case 	When IsNull(OrdenesCompra.AgrupacionFacturacion,1)=3 Then IsNull(Obras.IdUnidadOperativa,0)
	Else 0
  End
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
	OrdenesCompra.IdCliente is not null and 
	(@Conceptos='*' or 
		(@SoloAbonos='SI' and Patindex('%'+Convert(varchar,doc.IdArticulo)+'%', @Conceptos)<>0)  or 
		(@SoloAbonos='NO' and Patindex('%'+Convert(varchar,doc.IdArticulo)+'%', @Conceptos)=0) ) and 
	not Exists (Select Top 1 dfoc.IdDetalleFactura
			From DetalleFacturasOrdenesCompra dfoc
			Left Outer Join DetalleFacturas df On df.IdDetalleFactura=dfoc.IdDetalleFactura
			Left Outer Join Facturas fa On fa.IdFactura=df.IdFactura
			Where dfoc.IdDetalleOrdenCompra=doc.IdDetalleOrdenCompra and 
				IsNull(fa.Anulada,'NO')<>'SI' and 
				Year(fa.FechaFactura)=Year(@FechaFacturacion) and 
				Month(fa.FechaFactura)=Month(@FechaFacturacion)) and 
	(@Grupo=-1 or 
	 (@Grupo>0 and IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=@Grupo)) and 
	(@OCSeleccionadas='*' or 
	 (@OCSeleccionadas='S' and IsNull(OrdenesCompra.SeleccionadaParaFacturacion,'NO')='SI')) and
	(@VendedorLegales=0 or IsNull(Vendedores.CodigoVendedor,0)<>@VendedorLegales)

SET NOCOUNT OFF

SELECT 
 #Auxiliar1.IdCliente,
 #Auxiliar1.IdObra,
 #Auxiliar1.IdUnidadOperativa,
 Clientes.RazonSocial,
 Clientes.IdCodigoIva,
 Clientes.IdCondicionVenta,
 Clientes.IBCondicion,
 Clientes.IdIBCondicionPorDefecto,
 Clientes.IdIBCondicionPorDefecto2,
 Clientes.IdIBCondicionPorDefecto3,
 Clientes.PorcentajeIBDirecto,
 Clientes.FechaInicioVigenciaIBDirecto,
 Clientes.FechaFinVigenciaIBDirecto
FROM #Auxiliar1 
LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra=Obras.IdObra
LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
GROUP BY #Auxiliar1.IdCliente, #Auxiliar1.IdObra, #Auxiliar1.IdUnidadOperativa, 
	Clientes.RazonSocial, Clientes.IdCodigoIva, Clientes.IdCondicionVenta, 
	Clientes.IBCondicion, Clientes.IdIBCondicionPorDefecto,
	Clientes.IdIBCondicionPorDefecto2, Clientes.IdIBCondicionPorDefecto3, 
	Clientes.PorcentajeIBDirecto, Clientes.FechaInicioVigenciaIBDirecto,
	Clientes.FechaFinVigenciaIBDirecto
ORDER BY Clientes.RazonSocial, #Auxiliar1.IdObra, #Auxiliar1.IdUnidadOperativa 

DROP TABLE #Auxiliar1