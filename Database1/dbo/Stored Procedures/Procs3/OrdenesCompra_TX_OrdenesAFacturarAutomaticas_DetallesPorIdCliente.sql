CREATE PROCEDURE [dbo].[OrdenesCompra_TX_OrdenesAFacturarAutomaticas_DetallesPorIdCliente]

@IdCliente int,
@IdObra int, 
@IdUnidadOperativa int, 
@FechaFacturacion datetime,
@Conceptos varchar(100),
@SoloAbonos varchar(2),
@Grupo int,
@OCSeleccionadas varchar(1)

AS

DECLARE @VendedorLegales int

SET @VendedorLegales=Convert(integer,Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Codigo vendedor para inmovilizar ordenes de compra'),'0'))

SELECT 
 doc.*,
 Articulos.Codigo as [CodigoArticulo],
 Clientes.OperacionesMercadoInternoEntidadVinculada as [OperacionesMercadoInternoEntidadVinculada],
 Rubros.IdTipoOperacion as [IdTipoOperacion]
FROM DetalleOrdenesCompra doc
LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
LEFT OUTER JOIN Articulos ON doc.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Vendedores ON Vendedores.IdVendedor = Clientes.Vendedor1
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
WHERE 
	OrdenesCompra.IdCliente=@IdCliente and 
	IsNull(OrdenesCompra.Anulada,'NO')<>'SI' and 
	IsNull(doc.FacturacionAutomatica,'NO')='SI' and 
	IsNull(doc.FechaComienzoFacturacion,GetDate())<=@FechaFacturacion and 
	IsNull(Obras.Activa,'SI')='SI' and 
	IsNull(Clientes.IdEstado,0)<>2 and

	Case When IsNull(OrdenesCompra.AgrupacionFacturacion,1)=2 Then IsNull(OrdenesCompra.IdObra,0) Else 0 End=@IdObra and 

	Case When IsNull(OrdenesCompra.AgrupacionFacturacion,1)=3 Then IsNull(Obras.IdUnidadOperativa,0) Else 0 End=@IdUnidadOperativa and 

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

	(@OCSeleccionadas='*' or 
	 (@OCSeleccionadas='S' and IsNull(OrdenesCompra.SeleccionadaParaFacturacion,'NO')='SI')) and 

	(@VendedorLegales=0 or IsNull(Vendedores.CodigoVendedor,0)<>@VendedorLegales)