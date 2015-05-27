CREATE PROCEDURE [dbo].[OrdenesPago_TXFecha]

@Desde datetime,
@Hasta datetime,
@IdCuentaFF int = Null,
@IdUsuario int = Null

AS

SET @IdCuentaFF=IsNull(@IdCuentaFF,-1)
SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @vector_X varchar(100),@vector_T varchar(100)
SET @vector_X='001111111116666666666616111115111111111111111133'
SET @vector_T='004904122213333323233362205055143452252660005500'

SELECT 
 op.IdOrdenPago, 
 op.IdOPComplementariaFF,
 op.NumeroOrdenPago as [Numero], 
 op.IdOrdenPago as [IdOP], 
 Case When op.Exterior='SI' Then 'PE' Else Null End as [Cod],
 op.FechaOrdenPago as [Fecha Pago], 
 Case When op.Tipo='CC' Then 'Cta. cte.' When op.Tipo='FF' Then 'F. fijo' When op.Tipo='OT' Then 'Otros' Else '' End as [Tipo],
 Case When op.Anulada='SI' 
	Then 'Anulada'
	Else Case When op.Estado='CA' Then 'En caja' When op.Estado='FI' Then 'A la firma' When op.Estado='EN' Then 'Entregado' When op.Estado='CO' Then 'Caja obra' Else '' End
 End as [Estado],
 Proveedores.RazonSocial as [Proveedor],
 IsNull((Select Top 1 dc.NombreAnterior 
			From DetalleCuentas dc 
			Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>op.FechaOrdenPago 
			Order By dc.FechaCambio),Cuentas.Descripcion) as [Cuenta],
 Monedas.Abreviatura as [Mon.],
 Case When op.Efectivo=0 Then Null Else op.Efectivo End as [Efectivo],
 Case When op.Descuentos=0 Then Null Else op.Descuentos End as [Descuentos],
 Case When op.Valores=0 Then Null Else op.Valores End as [Valores],
 op.Documentos,
 op.Acreedores,
 op.RetencionIVA as [Ret.IVA],
 op.RetencionGanancias as [Ret.gan.],
 op.RetencionIBrutos as [Ret.ing.b.],
 op.RetencionSUSS as [Ret.SUSS],
 op.GastosGenerales as [Dev.F.F.],
 Case When op.Tipo='OT' or op.Anulada='SI' Then Null Else op.DiferenciaBalanceo End as [Dif. Balanceo],
 (Select Top 1 OrdenesPago.NumeroOrdenPago From OrdenesPago Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF) as [OP complem. FF],
 op.CotizacionDolar as [Cotiz. dolar],
 E1.Nombre as [Destinatario fondo fijo],
 E2.Nombre as [Confecciono],
 op.FechaIngreso as [Fecha ing.],
 E3.Nombre as [Modifico],
 op.FechaModifico as [Fecha modif.],
 op.Observaciones,
 E4.Nombre as [Anulo],
 op.FechaAnulacion as [Fecha anulacion],
 op.MotivoAnulacion as [Motivo anulacion],
 op.NumeroRendicionFF as [Nro.Rend.FF],
 op.ConfirmacionAcreditacionFF as [FF acreditado],
 C1.Descripcion as [Concepto OP otros],
 C2.Descripcion as [Clasificacion s/canc.],
 op.Detalle as [Detalle],
 Obras.NumeroObra as [Obra],
 op.NumeroReciboProveedor as [Nro. Recibo Proveedor],
 op.FechaReciboProveedor as [Fecha Recibo Proveedor],
 op.TextoAuxiliar1 as [Modalidad],
 op.TextoAuxiliar2 as [Enviar a],
 op.TextoAuxiliar3 as [Auxiliar],
 op.NumeroReciboProveedor as [Nro.Rec.Prov.],
 op.FechaReciboProveedor as [Fecha Rec.Prov.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Conceptos C1 ON op.IdConcepto = C1.IdConcepto
LEFT OUTER JOIN Conceptos C2 ON op.IdConcepto2 = C2.IdConcepto
LEFT OUTER JOIN Empleados E1 ON op.IdEmpleadoFF = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON op.IdUsuarioIngreso = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON op.IdUsuarioModifico = E3.IdEmpleado
LEFT OUTER JOIN Empleados E4 ON op.IdUsuarioAnulo = E4.IdEmpleado
LEFT OUTER JOIN Obras ON op.IdObra = Obras.IdObra
WHERE op.FechaOrdenPago between @Desde and @hasta and 
		(op.Confirmado is null or op.Confirmado<>'NO') and 
		(@IdCuentaFF=-1 or op.IdCuenta=@IdCuentaFF) and 
		(@IdUsuario=-1 or dbo.OrdenesPago_ConCuentasRestringidas(op.IdOrdenPago,@IdUsuario)=0)
ORDER BY op.FechaOrdenPago,op.NumeroOrdenPago