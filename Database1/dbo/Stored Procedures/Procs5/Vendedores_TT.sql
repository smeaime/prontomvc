CREATE  Procedure [dbo].[Vendedores_TT]

AS 

SELECT 
 Vendedores.IdVendedor as [IdVendedor],
 Vendedores.CodigoVendedor as [Codigo Vendedor], 
 Vendedores.Nombre as [Razon Social], 
 Vendedores.Direccion as [Direccion], 
 Localidades.Nombre as [Localidad], 
 Vendedores.CodigoPostal as [Codigo Postal], 
 Provincias.Nombre as [Provincia], 
 Vendedores.Telefono as [Telefono], 
 Vendedores.Fax as [Fax], 
 Vendedores.Email as [Email], 
 Vendedores.Comision as [Comision],
 Vendedores.Cuit as [Cuit],
 Vendedores.TodasLasZonas as [Todas las zonas ?],
 Vendedores.EmiteComision as [Emite comision ?]
FROM Vendedores
LEFT OUTER JOIN Localidades ON Localidades.IdLocalidad=Vendedores.IdLocalidad
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=Vendedores.IdProvincia
ORDER BY Vendedores.Nombre