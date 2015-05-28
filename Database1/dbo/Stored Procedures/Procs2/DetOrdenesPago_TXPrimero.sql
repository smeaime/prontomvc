CREATE PROCEDURE [dbo].[DetOrdenesPago_TXPrimero]

AS

DECLARE @ImporteAuxiliar numeric(18,2), @BaseCalculoIIBB varchar(20)
SET @ImporteAuxiliar=0.00
SET @BaseCalculoIIBB=''

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000111111111111111111111111111133'
SET @vector_T='000074111312025999993939999993500'

SELECT TOP 1
 DetOP.IdDetalleOrdenPago,
 DetOP.IdOrdenPago,
 DetOP.IdImputacion,
 Case When DetOP.IdImputacion=-2 Then 'CO' Else TiposComprobante.DescripcionAB End as [Comp.],
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),1,15) as [Numero],
 CuentasCorrientesAcreedores.Fecha as [Fecha],
 CuentasCorrientesAcreedores.ImporteTotal as [Imp.],
 CuentasCorrientesAcreedores.Saldo as [Saldo],
 DetOP.Importe,
 @ImporteAuxiliar as [s/impuesto],
 cp.TotalIva1 as [IVA],
 cp.TotalComprobante as [Tot.Comp.],
 Case When cp.BienesOServicios is not null Then cp.BienesOServicios Else Case When Proveedores.BienesOServicios is not null Then Proveedores.BienesOServicios Else Null End End as [B/S],
 DetOP.ImporteRetencionIVA as [Ret.Iva],
 Null as [Ret.Iva en OP],
 cp.IdTipoRetencionGanancia,
 cp.IdIBCondicion,
 @BaseCalculoIIBB as [BaseCalculoIIBB],
 CuentasCorrientesAcreedores.FechaVencimiento,
 cp.FechaComprobante,
 @ImporteAuxiliar as [Gravado IVA],
 cp.CotizacionMoneda,
 cp.PorcentajeIVAParaMonotributistas as [%IVA Mono],
 CuentasCorrientesAcreedores.IdTipoComp as [IdTipoComp],
 CuentasCorrientesAcreedores.IdComprobante as [IdComprobante],
 Polizas.Certificado as [Certif.Poliza],
 Polizas.NumeroEndoso as [Nro.Endoso],
 ib2.Descripcion as [CategoriaIIBB],
 TiposRetencionGanancia.Descripcion as [CategoriaGanancias],
 DetOP.ImporteRetencionSUSS as [Ret.SUSS],
 DetOP.SaldoAFondoDeReparo as [A fondo de reparo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleOrdenesPago DetOP
LEFT OUTER JOIN CuentasCorrientesAcreedores ON CuentasCorrientesAcreedores.IdCtaCte=DetOP.IdImputacion
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CuentasCorrientesAcreedores.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CuentasCorrientesAcreedores.IdComprobante
LEFT OUTER JOIN Proveedores ON cp.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Polizas ON cp.IdPoliza=Polizas.IdPoliza
LEFT OUTER JOIN IBCondiciones ib1 ON ib1.IdIBCondicion=cp.IdIBCondicion
LEFT OUTER JOIN IBCondiciones ib2 ON ib2.IdIBCondicion=DetOP.IdIBCondicion
LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=DetOP.IdTipoRetencionGanancia
WHERE DetOP.IdDetalleOrdenPago=-1