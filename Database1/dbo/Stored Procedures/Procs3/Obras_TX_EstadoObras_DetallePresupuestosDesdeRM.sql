
CREATE PROCEDURE [dbo].[Obras_TX_EstadoObras_DetallePresupuestosDesdeRM]

@IdDetalleRequerimiento as int

AS 

SELECT
 Convert(varchar,Presupuestos.Numero)+'/'+Convert(varchar,Presupuestos.SubNumero) as [Numero],
 Proveedores.RazonSocial as [Proveedor], 
 Presupuestos.FechaIngreso as [Fecha], 
 DetPre.ImporteTotalItem as [Importe],
 Comparativas.Numero as [NumeroComparativa],
 Comparativas.Fecha as [FechaComparativa]
FROM DetallePresupuestos DetPre
LEFT OUTER JOIN Presupuestos ON DetPre.IdPresupuesto = Presupuestos.IdPresupuesto
LEFT OUTER JOIN Proveedores ON Presupuestos.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN DetalleComparativas Det ON DetPre.IdDetallePresupuesto = Det.IdDetallePresupuesto
LEFT OUTER JOIN Comparativas ON Det.IdComparativa = Comparativas.IdComparativa
WHERE DetPre.IdDetalleRequerimiento=@IdDetalleRequerimiento
