
CREATE  Procedure [dbo].[Clientes_TT]

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111111111111111133'
SET @vector_T='05120211555514521162222514142200'

SELECT 
 Clientes.IdCliente, 
 Clientes.RazonSocial as [Razon social],
 Clientes.Codigo as [Codigo],
 Clientes.Direccion, 
 L1.Nombre as [Localidad], 
 Clientes.CodigoPostal, 
 P1.Nombre as [Provincia], 
 Paises.Descripcion as [Pais], 
 Clientes.Telefono, 
 Clientes.Fax, 
 Clientes.Email, 
 Clientes.Cuit, 
 DescripcionIva.Descripcion as [Condicion IVA], 
 Clientes.FechaAlta as [Fecha alta], 
 Clientes.Contacto,
 Clientes.DireccionEntrega as [Direccion de entrega], 
 L2.Nombre as [Localidad (entrega)], 
 P2.Nombre as [Provincia (entrega)],
 Clientes.CodigoPresto as [Codigo PRESTO],
 V1.Nombre as [Vendedor], 
 V2.Nombre as [Cobrador], 
 [Estados Proveedores].Descripcion as [Estado],
 Clientes.NombreFantasia as [Nombre comercial],
 Clientes.Observaciones,
 E1.Nombre as [Ingreso],
 Clientes.FechaIngreso as [Fecha ing.],
 E2.Nombre as [Modifico],
 Clientes.FechaModifico as [Fecha modif.],
 C1.Descripcion as [Cuenta contable],
 C2.Descripcion as [Cuenta contable (ext.)],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Clientes 
LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Localidades L1 ON Clientes.IdLocalidad = L1.IdLocalidad
LEFT OUTER JOIN Localidades L2 ON Clientes.IdLocalidadEntrega = L2.IdLocalidad
LEFT OUTER JOIN Provincias P1 ON Clientes.IdProvincia = P1.IdProvincia
LEFT OUTER JOIN Provincias P2 ON Clientes.IdProvincia = P2.IdProvincia
LEFT OUTER JOIN Vendedores V1 ON Clientes.Vendedor1 = V1.IdVendedor
LEFT OUTER JOIN Vendedores V2 ON Clientes.Cobrador = V2.IdVendedor
LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
LEFT OUTER JOIN Empleados E1 ON Clientes.IdUsuarioIngreso = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Clientes.IdUsuarioModifico = E2.IdEmpleado
LEFT OUTER JOIN [Estados Proveedores] ON Clientes.IdEstado = [Estados Proveedores].IdEstado
LEFT OUTER JOIN Cuentas C1 ON Clientes.IdCuenta = C1.IdCuenta
LEFT OUTER JOIN Cuentas C2 ON Clientes.IdCuentaMonedaExt = C2.IdCuenta
WHERE IsNull(Clientes.Confirmado,'SI')='SI'
ORDER BY Clientes.RazonSocial
