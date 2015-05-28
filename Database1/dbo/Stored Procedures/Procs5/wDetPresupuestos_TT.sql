
CREATE Procedure [dbo].[wDetPresupuestos_TT]

@IdPresupuesto int

AS 

Select Det.*
,Articulos.Descripcion as [Articulo]

FROM DetallePresupuestos Det
--LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
--LEFT OUTER JOIN CuentasGastos ON (Det.IdCuentaGasto = CuentasGastos.IdCuentaGasto)
--LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Obras ON Cab.IdObra = Obras.IdObra
--LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
--LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
--LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
--LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
--LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
--LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
--LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
--LEFT OUTER JOIN Proveedores ON DetReq.IdProveedor = Proveedores.IdProveedor
WHERE IdPresupuesto=@IdPresupuesto

