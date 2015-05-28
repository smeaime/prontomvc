
CREATE  Procedure [dbo].[OrdenesPago_TX_AConfirmar]

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='001111111116666666666616133'
Set @vector_T='004904132213333323233362200'

SELECT 
 op.IdOrdenPago, 
 op.IdOPComplementariaFF,
 op.NumeroOrdenPago as [Numero], 
 op.IdOrdenPago as [IdOP], 
 Case 	When op.Exterior='SI' Then 'PE'
	Else Null
 End as [Cod],
 op.FechaOrdenPago as [Fecha Pago], 
 Case 	When op.Tipo='CC' Then 'Cta. cte.' 
	When op.Tipo='FF' Then 'F. fijo' 
	When op.Tipo='OT' Then 'Otros' 
	Else ''
 End as [Tipo],
 'A Confirmar' as [Est.],
 Proveedores.RazonSocial as [Proveedor],
 IsNull((Select Top 1 dc.NombreAnterior 
	From DetalleCuentas dc 
	Where dc.IdCuenta=Cuentas.IdCuenta and dc.FechaCambio>op.FechaOrdenPago 
	Order By dc.FechaCambio),Cuentas.Descripcion) AS [Cuenta],
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
 Case 	When op.Tipo='OT' Then Null
	Else op.DiferenciaBalanceo
 End as [Dif. Balanceo],
 (Select Top 1 OrdenesPago.NumeroOrdenPago From OrdenesPago
  Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF) as [OP complem. FF],
 op.CotizacionDolar as [Cotiz. dolar],
 Empleados.Nombre as [Destinatario fondo fijo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
WHERE op.Confirmado is not null and op.Confirmado='NO'
ORDER BY op.FechaOrdenPago,op.NumeroOrdenPago
