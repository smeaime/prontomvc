  
CREATE Procedure [dbo].[wFacturas_TX_PorIdConDatos]  
  
@IdFactura int  
  
AS   
  
SELECT   
 Facturas.*,  
 IsNull(Obras.NumeroObra,'') as [NumeroObra],  
 Obras.NumeroObra+' '+Obras.Descripcion COLLATE DATABASE_DEFAULT as [Obra]   ,  
 Case When IsNull((Select Count(Distinct DetalleRemitos.IdRemito)  
   From DetalleFacturasRemitos Det   
   Left Outer Join DetalleRemitos On Det.IdDetalleRemito = DetalleRemitos.IdDetalleRemito  
   Where Det.IdFactura=@IdFactura),0)<=1   
 Then IsNull((Select Top 1 Convert(varchar,Remitos.NumeroRemito)  
   From DetalleFacturasRemitos Det   
   Left Outer Join DetalleRemitos On Det.IdDetalleRemito = DetalleRemitos.IdDetalleRemito  
   Left Outer Join Remitos On DetalleRemitos.IdRemito = Remitos.IdRemito  
   Where Det.IdFactura=@IdFactura),'')  
 Else 'Varios'  
 End as [Remito],  
 Clientes.CodigoCliente as [CodigoCliente],   
 Clientes.RazonSocial as [Cliente2],   
 DescripcionIva.Descripcion as [CondicionIVA],   
 Clientes.Cuit as [CuitCliente],   
 Monedas.Abreviatura as [Moneda],  
 Vendedores.Nombre as [Vendedor],  
 E1.Nombre  as [Ingreso],  
 Facturas.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Facturas.PuntoVenta)))+Convert(varchar,Facturas.PuntoVenta)+'-'+  
  Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura) as [Numero],  
 cc.Descripcion as [CondicionVenta],  
 Facturas.ImporteTotal-Facturas.ImporteIva1-Facturas.ImporteIva2-Facturas.RetencionIBrutos1-Facturas.RetencionIBrutos2-Facturas.RetencionIBrutos3+  
 IsNull(Facturas.ImporteBonificacion,0)-IsNull(Facturas.IvaNoDiscriminado,0)-IsNull(Facturas.PercepcionIVA,0)-  
 IsNull(Facturas.OtrasPercepciones1,0)-IsNull(Facturas.OtrasPercepciones2,0)-IsNull(Facturas.OtrasPercepciones3,0) as [SubtotalFactura],  
 Facturas.ImporteBonificacion as [Bonificacion],  
 Facturas.ImporteIva1+IsNull(Facturas.IvaNoDiscriminado,0) as [Iva],  
 Facturas.RetencionIBrutos1+Facturas.RetencionIBrutos2+Facturas.RetencionIBrutos3 as [IIBB],  
 IsNull(Facturas.OtrasPercepciones1,0)+IsNull(Facturas.OtrasPercepciones2,0)+IsNull(Facturas.OtrasPercepciones3,0) as [OtrasPercepciones],  
 Facturas.ImporteTotal as [TotalFactura]  
FROM Facturas  
LEFT OUTER JOIN Obras ON Obras.IdObra = Facturas.IdObra  
LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente  
LEFT OUTER JOIN DescripcionIva ON IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva   
LEFT OUTER JOIN Vendedores ON Clientes.Vendedor1 = Vendedores.IdVendedor  
LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda  
LEFT OUTER JOIN Empleados E1 ON Facturas.IdUsuarioIngreso = E1.IdEmpleado  
LEFT OUTER JOIN [Condiciones Compra] cc ON Facturas.IdCondicionVenta=cc.IdCondicionCompra  
WHERE (IdFactura=@IdFactura)  
  
  
