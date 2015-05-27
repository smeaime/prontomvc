
CREATE  Procedure [dbo].[Clientes_TX_TT]

@IdCliente int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='01111111111111111111111111111133'
Set @vector_T='05120211555514521162222514142200'

SELECT 
 Clientes.IdCliente, 
 Clientes.RazonSocial as [Razon social],
 Clientes.Codigo as [Codigo],
 Clientes.Direccion, 
 (Select Localidades.Nombre From Localidades 
  Where Clientes.IdLocalidad=Localidades.IdLocalidad) as [Localidad], 
 Clientes.CodigoPostal, 
 (Select Provincias.Nombre From Provincias 
  Where Clientes.IdProvincia=Provincias.IdProvincia) as [Provincia], 
 Paises.Descripcion as [Pais], 
 Clientes.Telefono, 
 Clientes.Fax, 
 Clientes.Email, 
 Clientes.Cuit, 
 DescripcionIva.Descripcion as [Condicion IVA], 
 Clientes.FechaAlta as [Fecha alta], 
 Clientes.Contacto,
 Clientes.DireccionEntrega as [Direccion de entrega], 
 (Select Localidades.Nombre From Localidades 
  Where Clientes.IdLocalidadEntrega=Localidades.IdLocalidad) AS [Localidad (entrega)], 
 (Select Provincias.Nombre From Provincias 
  Where Clientes.IdProvinciaEntrega=Provincias.IdProvincia) AS [Provincia (entrega)],
 Clientes.CodigoPresto as [Codigo PRESTO],
 (Select Vendedores.Nombre From Vendedores 
  Where Clientes.Vendedor1=Vendedores.IdVendedor) as [Vendedor], 
 (Select Vendedores.Nombre From Vendedores 
  Where Clientes.Cobrador=Vendedores.IdVendedor) as [Cobrador], 
 [Estados Proveedores].Descripcion as [Estado],
 Clientes.NombreFantasia as [Nombre comercial],
 Clientes.Observaciones,
 (Select Top 1 Empleados.Nombre From Empleados
  Where Clientes.IdUsuarioIngreso = Empleados.IdEmpleado) as [Ingreso],
 Clientes.FechaIngreso as [Fecha ing.],
 (Select Top 1 Empleados.Nombre From Empleados
  Where Clientes.IdUsuarioModifico = Empleados.IdEmpleado) as [Modifico],
 Clientes.FechaModifico as [Fecha modif.],
 C1.Descripcion as [Cuenta contable],
 C2.Descripcion as [Cuenta contable (ext.)],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Clientes 
LEFT OUTER JOIN DescripcionIva ON 	Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
LEFT OUTER JOIN [Estados Proveedores] ON Clientes.IdEstado = [Estados Proveedores].IdEstado
LEFT OUTER JOIN Cuentas C1 ON Clientes.IdCuenta = C1.IdCuenta
LEFT OUTER JOIN Cuentas C2 ON Clientes.IdCuentaMonedaExt = C2.IdCuenta
WHERE (IdCliente=@IdCliente)
