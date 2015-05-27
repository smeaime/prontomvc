
CREATE  Procedure [dbo].[LiquidacionesFletes_TXFecha]

@Desde datetime,
@Hasta datetime

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111133'
SET @vector_T='039342413E2353500'

SELECT 
 LiquidacionesFletes.IdLiquidacionFlete as [IdLiquidacionFlete],
 Transportistas.RazonSocial as [Transportista],
 LiquidacionesFletes.IdLiquidacionFlete as [IdAux],
 LiquidacionesFletes.NumeroLiquidacion as [Numero],
 LiquidacionesFletes.FechaLiquidacion as [Fecha],
 LiquidacionesFletes.Anulada as [Anulada],
 LiquidacionesFletes.FechaAnulacion as [Fecha anulacion],
 E1.Nombre as [Anulo],
 LiquidacionesFletes.MotivoAnulacion as [Motivo anulacion],
 (Select Top 1 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
  From ComprobantesProveedores cp 
  Where cp.IdLiquidacionFlete=LiquidacionesFletes.IdLiquidacionFlete) as [Factura],
 (Select Top 1 Proveedores.RazonSocial
  From ComprobantesProveedores cp 
  Left Outer Join Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
  Where cp.IdLiquidacionFlete=LiquidacionesFletes.IdLiquidacionFlete) as [Proveedor],
 LiquidacionesFletes.Total as [Importe],
 Transportistas.Cuit as [Cuit], 
 DescripcionIva.Descripcion as [CondicionIVA], 
 LiquidacionesFletes.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM LiquidacionesFletes
LEFT OUTER JOIN Transportistas ON Transportistas.IdTransportista = LiquidacionesFletes.IdTransportista
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = LiquidacionesFletes.IdUsuarioAnulo
LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva = Transportistas.IdCodigoIva
WHERE LiquidacionesFletes.FechaLiquidacion between @Desde and @hasta 
ORDER BY LiquidacionesFletes.FechaLiquidacion, LiquidacionesFletes.NumeroLiquidacion
