
CREATE  Procedure [dbo].[AutorizacionesCompra_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111133'
SET @vector_T='0122411131414200'

SELECT 
 AutorizacionesCompra.IdAutorizacionCompra,
 Obras.NumeroObra as [Codigo obra],
 Obras.Descripcion as [Obra],
 AutorizacionesCompra.Numero as Numero,
 AutorizacionesCompra.Fecha as Fecha,
 Proveedores.RazonSocial as [Proveedor],
 E1.Nombre as [Realizada por],
 E2.Nombre as [Liberada por],
 AutorizacionesCompra.Observaciones as [Observaciones],
 E3.Nombre as [Ingreso],
 AutorizacionesCompra.FechaIngreso as [Fecha ingreso],
 E4.Nombre as [Modifico],
 AutorizacionesCompra.FechaModifico as [Fecha modifico],
 (Select Count(*) From DetalleAutorizacionesCompra dac Where dac.IdAutorizacionCompra=AutorizacionesCompra.IdAutorizacionCompra) as [Cant.Items],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AutorizacionesCompra
LEFT OUTER JOIN Proveedores ON AutorizacionesCompra.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Obras ON AutorizacionesCompra.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados E1 ON AutorizacionesCompra.IdRealizo = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON AutorizacionesCompra.IdAprobo = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON AutorizacionesCompra.IdUsuarioIngreso = E3.IdEmpleado
LEFT OUTER JOIN Empleados E4 ON AutorizacionesCompra.IdUsuarioModifico = E4.IdEmpleado
ORDER BY AutorizacionesCompra.Fecha, AutorizacionesCompra.Numero
