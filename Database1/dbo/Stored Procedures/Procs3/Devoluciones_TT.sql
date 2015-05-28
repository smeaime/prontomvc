CREATE  Procedure [dbo].[Devoluciones_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111111133'
SET @vector_T='0091341140554462422300'

SELECT 
	Devoluciones.IdDevolucion, 
	Devoluciones.TipoABC as [A/B/E],
	Devoluciones.IdDevolucion as [IdAux1],
	Devoluciones.PuntoVenta as [Pto.vta.], 
	Devoluciones.NumeroDevolucion as [Devolucion], 
	Devoluciones.FechaDevolucion as [Fecha dev.],
	Devoluciones.Anulada as [Anulada],
	Clientes.CodigoCliente as [Cod.Cli.], 
	Clientes.RazonSocial as [Cliente], 
	DescripcionIva.Descripcion as [Condicion IVA], 
	Clientes.Cuit as [Cuit], 
	(Devoluciones.ImporteTotal-Devoluciones.ImporteIva1-Devoluciones.ImporteIva2-Devoluciones.RetencionIBrutos1-Devoluciones.RetencionIBrutos2-
		Case When Devoluciones.RetencionIBrutos3 is null then 0 else Devoluciones.RetencionIBrutos3 end) as [Neto gravado],
	Devoluciones.ImporteIva1 as [Iva],
	Devoluciones.RetencionIBrutos1 as [IIBB],
	Devoluciones.ImporteTotal as [Total devolucion],
	Facturas.NumeroFactura as [S/Factura], 
	Facturas.FechaFactura as [Fecha Fac.], 
	Facturas.NumeroRemito as [Remito], 
	Facturas.NumeroPedido as [Pedido], 
	Vendedores.Nombre as [Vendedor],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM Devoluciones 
LEFT OUTER JOIN Clientes ON Devoluciones.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN DescripcionIva ON IsNull(Devoluciones.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Facturas ON Devoluciones.IdFactura = Facturas.IdFactura
LEFT OUTER JOIN Vendedores ON Devoluciones.IdVendedor = Vendedores.IdVendedor
ORDER BY Devoluciones.NumeroDevolucion