CREATE Procedure [dbo].[Proveedores_TX_Comprobantes_Modelo3]

@FechaDesde datetime,
@FechaHasta datetime

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111133'
SET @vector_T='0F914411132100'

SELECT  
 DetCP.IdDetalleComprobanteProveedor,
 TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
	Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 DetCP.IdDetalleComprobanteProveedor as [IdAux],
 cp.NumeroReferencia as [Nro.Ref.],
 cp.FechaRecepcion as [Fecha recep.],
 cp.FechaComprobante as [Fecha comp.],
 Proveedores.RazonSocial as [Proveedor],
 RubrosContables.Descripcion as [Rubro],
 DescripcionIva.Descripcion as [Condicion Iva],
 Cuentas.Codigo as [Cod.Cta.],
 Cuentas.Descripcion as [Cuenta],
 Obras.NumeroObra+' - '+Obras.Descripcion as [Obra],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleComprobantesProveedores DetCP 
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=cp.IdProveedor
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetCP.IdRubroContable
LEFT OUTER JOIN Obras ON Obras.IdObra=DetCP.IdObra
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
WHERE cp.FechaRecepcion between @FechaDesde and @FechaHasta and cp.IdProveedor is not null 
ORDER BY cp.FechaRecepcion, [Comprobante]