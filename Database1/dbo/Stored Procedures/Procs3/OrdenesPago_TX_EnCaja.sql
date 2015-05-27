CREATE PROCEDURE [dbo].[OrdenesPago_TX_EnCaja]

@Estado varchar(2) = Null,
@IdUsuario int = Null

AS

SET @Estado=IsNull(@Estado,'CA')
SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00111111111666666666661611111133'
SET @vector_T='00490412221333332323336225200000'

SELECT 
 op.IdOrdenPago, 
 op.IdOPComplementariaFF,
 op.NumeroOrdenPago as [Orden en caja], 
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
 Case When op.Tipo='OT' or op.Anulada='SI' Then Null Else op.DiferenciaBalanceo End as [Dif. Balanceo],
 (Select Top 1 OrdenesPago.NumeroOrdenPago From OrdenesPago Where OrdenesPago.IdOrdenPago=op.IdOPComplementariaFF) as [OP complem. FF],
 op.CotizacionDolar as [Cotiz. dolar],
 Empleados.Nombre as [Destinatario fondo fijo],
 op.Observaciones as [Observaciones], 
 Obras.NumeroObra as [Obra],
 op.TextoAuxiliar1 as [Modalidad],
 op.TextoAuxiliar2 as [Enviar a],
 op.TextoAuxiliar3 as [Auxiliar],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesPago op
LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Empleados ON op.IdEmpleadoFF = Empleados.IdEmpleado
LEFT OUTER JOIN Monedas ON op.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Obras ON op.IdObra = Obras.IdObra
WHERE op.Estado=@Estado and (op.Anulada is null or op.Anulada<>'SI') and  
		(op.Confirmado is null or op.Confirmado<>'NO') and 
		(@IdUsuario=-1 or dbo.OrdenesPago_ConCuentasRestringidas(op.IdOrdenPago,@IdUsuario)=0)
ORDER BY op.FechaOrdenPago,op.NumeroOrdenPago