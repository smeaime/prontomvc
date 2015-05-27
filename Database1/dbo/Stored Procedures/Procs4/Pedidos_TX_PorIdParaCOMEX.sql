


CREATE  Procedure [dbo].[Pedidos_TX_PorIdParaCOMEX]

@IdPedido int

AS 

SELECT 
 Pedidos.IdPedido,
 (Select Top 1 Empresa.Nombre From Empresa Where IdEmpresa=1) as [Empresa],
 Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+
	Convert(varchar,Pedidos.NumeroPedido)+'-'+
	Substring('00',1,2-Len(Convert(varchar,IsNull(Pedidos.SubNumero,0))))+
	Convert(varchar,IsNull(Pedidos.SubNumero,0)) as [Pedido],
 Pedidos.FechaPedido [Fecha],
 Proveedores.RazonSocial as [Proveedor],
 Proveedores.Direccion as [Direccion],
 Localidades.Nombre AS [Localidad], 
 Proveedores.CodigoPostal as [Codigo postal], 
 Provincias.Nombre AS [Provincia], 
 Paises.Descripcion AS [Pais], 
 Proveedores.Telefono1 as [Telefono], 
 Proveedores.Fax as [Fax],  
 Proveedores.Email as [Email],  
 Proveedores.Contacto as [Contacto]
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
WHERE (Pedidos.IdPedido = @IdPedido)
ORDER BY Pedidos.FechaPedido, Pedidos.NumeroPedido, Pedidos.SubNumero


