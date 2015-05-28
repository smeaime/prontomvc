CREATE  Procedure [dbo].[wOrdenesPago_TX_PorIdConDatos]

@IdOrdenPago int

AS 

SELECT 
 op.*, 
 Case When op.Tipo='CC' Then 'Cta. cte.' When op.Tipo='FF' Then 'F. fijo' When op.Tipo='OT' Then 'Otros' Else '' End as [Tipo1],
 Case When op.Anulada='SI' Then 'Anulada'
	Else Case When op.Estado='CA' Then 'En caja' When op.Estado='FI' Then 'A la firma' When op.Estado='EN' Then 'Entregado' Else '' End
 End as [Estado1],
 Proveedores.RazonSocial as [Proveedor],
 Cuentas.Descripcion as [Cuenta],
 Monedas.Abreviatura as [Moneda],
 Case When op.Tipo='OT' or op.Anulada='SI' Then Null Else op.DiferenciaBalanceo End as [DiferenciaBalanceo1],
 (Select Top 1 op2.NumeroOrdenPago From OrdenesPago op2 Where op2.IdOrdenPago=op.IdOPComplementariaFF) as [NumeroOrdenPagoComplementaraFF],
 E1.Nombre as [DestinatarioFF1],
 E2.Nombre as [Confecciono],
 E3.Nombre as [Modifico],
 E4.Nombre as [Anulo],
 C1.Descripcion as [ConceptoOPOtros],
 C2.Descripcion as [ClasificacionSinCanc],
 Obras.NumeroObra as [Obra]
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
WHERE (IdOrdenPago=@IdOrdenPago)
