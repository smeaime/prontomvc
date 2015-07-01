--/////////////////////////////////////////////////////////////////////////////////////////////


IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wFacturas_TXFecha]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wFacturas_TXFecha
go


 CREATE PROCEDURE [dbo].[wFacturas_TXFecha]  
  
@Desde datetime,  
@Hasta datetime,  
@IdAbonos varchar(100)  
  
AS  
  
DECLARE @vector_X varchar(50),@vector_T varchar(50)  
SET @vector_X='0111111111111111111111111111111111133'  
SET @vector_T='00912114055BB544444425126703433533400'   
  
SELECT   
 Facturas.IdFactura,   
 Facturas.TipoABC as [A/B/E],  
 Facturas.IdFactura as [IdAux],   
 Facturas.PuntoVenta as [Pto.vta.],   
 Facturas.NumeroFactura as [Factura],   
 Facturas.Anulada as [Anulada],  
 Clientes.CodigoCliente as [Cod.Cli.],   
 Clientes.RazonSocial as [Cliente],   
 DescripcionIva.Descripcion as [Condicion IVA],   
 Clientes.Cuit as [Cuit],   
 Facturas.FechaFactura as [Fecha Factura],   
 dbo.Facturas_OrdenesCompra(Facturas.IdFactura) as [Ordenes de compra],  
 dbo.Facturas_Remitos(Facturas.IdFactura) as [Remitos],  
 Facturas.ImporteTotal-Facturas.ImporteIva1-Facturas.ImporteIva2-Facturas.RetencionIBrutos1-Facturas.RetencionIBrutos2-Facturas.RetencionIBrutos3+  
 IsNull(Facturas.ImporteBonificacion,0)-IsNull(Facturas.IvaNoDiscriminado,0)-IsNull(Facturas.PercepcionIVA,0) as [Subtotal],  
 Facturas.ImporteBonificacion as [Bonificacion],  
 Facturas.ImporteIva1+IsNull(Facturas.IvaNoDiscriminado,0) as [Iva],  
 Facturas.AjusteIva as [Ajuste IVA],  
 Facturas.RetencionIBrutos1+Facturas.RetencionIBrutos2+Facturas.RetencionIBrutos3 as [IIBB],  
 Facturas.PercepcionIVA as [Perc.IVA],  
 Facturas.ImporteTotal as [Total factura],  
 Monedas.Abreviatura as [Mon.],  
 Clientes.Telefono as [Telefono del cliente],   
 Vendedores.Nombre as [Vendedor],  
 Empleados.Nombre  as [Ingreso],  
 Facturas.FechaIngreso as [Fecha ingreso],  
 Obras.NumeroObra as [Obra (x defecto)],  
 Provincias.Nombre as [Provincia destino],  
 (Select Count(*) From DetalleFacturas df Where df.IdFactura=Facturas.IdFactura) as [Cant.Items],  
 (Select Count(*) From DetalleFacturas df Where df.IdFactura=Facturas.IdFactura and Patindex('%'+Convert(varchar,df.IdArticulo)+'%', @IdAbonos)<>0) as [Cant.Abonos],  
 'Grupo '+Convert(varchar,  
 (Select Top 1 oc.Agrupacion2Facturacion   
 From DetalleFacturasOrdenesCompra dfoc   
 Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra  
 Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra  
 Where dfoc.IdFactura=Facturas.IdFactura)) as [Grupo facturacion automatica],  
 Facturas.ActivarRecuperoGastos as [Act.Rec.Gtos.],  
 Case When IsNull(ContabilizarAFechaVencimiento,'NO')='NO' Then Facturas.FechaFactura Else Facturas.FechaVencimiento End as [Fecha Contab.],  
 Facturas.CAE as [CAE],  
 Facturas.RechazoCAE as [Rech.CAE],  
 Facturas.FechaVencimientoORechazoCAE as [Fecha vto.CAE],  
 isnull(Facturas.FueEnviadoCorreoConFacturaElectronica,'NO') as FueEnviadoCorreoConFacturaElectronica,
 
 
(select count (*) -- idfactura,idnotacredito 
from [DetalleNotasCreditoImputaciones] 
inner join  CuentasCorrientesDeudores 
	on CuentasCorrientesDeudores.IdCtaCte=[DetalleNotasCreditoImputaciones].idImputacion and IdTipoComp=1 
inner join  Facturas FACSUB
	on CuentasCorrientesDeudores.IdComprobante=Facturas.idfactura and IdTipoComp=1
where FACSUB.idfactura=Facturas.idfactura) as TieneNotaDeCredito
,

 
 @Vector_T as Vector_T,  
 @Vector_X as Vector_X  
 
 
FROM Facturas   
LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente  
LEFT OUTER JOIN DescripcionIva ON IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva   
--LEFT OUTER JOIN Vendedores ON Clientes.Vendedor1 = Vendedores.IdVendedor  
LEFT OUTER JOIN Vendedores ON Facturas.IdVendedor = Vendedores.IdVendedor  
LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda  
LEFT OUTER JOIN Obras ON Facturas.IdObra = Obras.IdObra  
LEFT OUTER JOIN Provincias ON Facturas.IdProvinciaDestino = Provincias.IdProvincia  
LEFT OUTER JOIN Empleados ON Facturas.IdUsuarioIngreso = Empleados.IdEmpleado  
WHERE Facturas.FechaFactura between @Desde and @hasta and IsNull(FacturaContado,'NO')='NO'  
ORDER BY Facturas.FechaFactura,Facturas.NumeroFactura  
go



[wFacturas_TXFecha] '1/1/2015','1/1/2016',null


--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////


--select idfactura,
--(
--select count (*) -- idfactura,idnotacredito 
--from [DetalleNotasCreditoImputaciones] 
--inner join  CuentasCorrientesDeudores 
--	on CuentasCorrientesDeudores.IdCtaCte=[DetalleNotasCreditoImputaciones].idImputacion and IdTipoComp=1 
--inner join  Facturas 
--	on CuentasCorrientesDeudores.IdComprobante=Facturas.idfactura and IdTipoComp=1
--where idfactura=idfactura) as TieneNotaDeCredito

--from facturas 


