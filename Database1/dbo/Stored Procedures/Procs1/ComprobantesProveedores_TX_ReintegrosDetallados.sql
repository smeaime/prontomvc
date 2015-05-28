


CREATE  Procedure [dbo].[ComprobantesProveedores_TX_ReintegrosDetallados]

AS 

Declare @IdCuentaReintegros int
Set @IdCuentaReintegros=IsNull((Select Top 1 Parametros.IdCuentaReintegros
				From Parametros Where Parametros.IdParametro=1),0)

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='01111111111133'
Set @vector_T='00936412201100'

SELECT 
 cp.IdComprobanteProveedor as [IdAux1], 
 TiposComprobante.DescripcionAB as [Tipo],
 cp.NumeroReferencia as [IdAux2], 
 cp.NumeroReferencia as [Nro.interno],
 Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
	Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,cp.NumeroComprobante2)))+
	Convert(varchar,cp.NumeroComprobante2),1,20) as [Numero],
 cp.FechaComprobante as [Fecha comp.], 
 Proveedores.RazonSocial as [Proveedor], 
 cp.ReintegroImporte*cp.CotizacionMoneda as [Importe],
 Null as [Reintegro],
 '$' as [Mon.],
 cp.ReintegroDespacho as [Despacho],
 Cuentas.Descripcion as [Cuenta],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ComprobantesProveedores cp
LEFT OUTER JOIN Proveedores ON cp.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Monedas ON cp.ReintegroIdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Cuentas ON cp.ReintegroIdCuenta = Cuentas.IdCuenta
WHERE IsNull(cp.Confirmado,'NO')<>'NO' and cp.ReintegroIdCuenta is not null

UNION ALL 

SELECT 
 Recibos.IdComprobanteProveedorReintegro as [IdAux1], 
 'RE' as [Tipo],
 cp.NumeroReferencia as [IdAux2], 
 Null as [Nro.interno],
 Substring(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+
	Convert(varchar,Recibos.PuntoVenta)+'-'+
	Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+
	Convert(varchar,Recibos.NumeroRecibo),1,20) as [Numero],
 Recibos.FechaRecibo as [Fecha comp.], 
 Null as [Proveedor], 
 Null as [Importe],
 Recibos.Valores*Recibos.CotizacionMoneda as [Reintegro],
/*
 IsNull((Select Sum(IsNull(Haber,0)-IsNull(Debe,0))
	 From Subdiarios
	 Where Subdiarios.IdCuenta=@IdCuentaReintegros and 
		Subdiarios.IdTipoComprobante=2 and 
		Subdiarios.IdComprobante=Recibos.IdRecibo),0) as [Reintegro],
*/
 '$' as [Mon.],
 cp.ReintegroDespacho as [Despacho],
 Null as [Cuenta],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recibos
LEFT OUTER JOIN ComprobantesProveedores cp ON Recibos.IdComprobanteProveedorReintegro = cp.IdComprobanteProveedor
LEFT OUTER JOIN Monedas ON Recibos.IdMoneda = Monedas.IdMoneda
WHERE Recibos.IdComprobanteProveedorReintegro is not null

ORDER BY [IdAux2],[Nro.interno] DESC


