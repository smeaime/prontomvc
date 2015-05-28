CREATE Procedure [dbo].[Recepciones_TX_PorIdConDatos]

@IdRecepcion int

AS 

SELECT 
 Recepciones.*,
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+
	IsNull('/'+Convert(varchar,Recepciones.SubNumero),'') as [Recepcion],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'') as [Pedido],
 dbo.Recepciones_Requerimientos(Recepciones.IdRecepcion) as [RM's],
 dbo.Recepciones_Solicitantes(Recepciones.IdRecepcion) as [Solicitantes RM's],
 E1.Nombre as [Realizo1],
 E2.Nombre as [Confecciono],
 E3.Nombre as [Modifico],
 E4.Nombre as [Anulo],
 E5.Nombre as [Comprador],
 Proveedores.RazonSocial as [Proveedor],
 Proveedores.Direccion as [Direccion], 
 Localidades.Nombre as [Localidad], 
 Proveedores.CodigoPostal as [CodigoPostal], 
 Provincias.Nombre as [Provincia], 
 Paises.Descripcion as [Pais], 
 Proveedores.Telefono1 as [Telefono], 
 Proveedores.Fax as [Fax], 
 Proveedores.Email as [Email], 
 Proveedores.Cuit as [Cuit], 
 DescripcionIva.Descripcion as [CondicionIVA]
FROM Recepciones
LEFT OUTER JOIN Pedidos ON Recepciones.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Acopios ON Recepciones.IdAcopio=Acopios.IdAcopio
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Recepciones.Realizo
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Recepciones.IdUsuarioIngreso
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado=Recepciones.IdUsuarioModifico
LEFT OUTER JOIN Empleados E4 ON E4.IdEmpleado=Recepciones.IdUsuarioAnulo
LEFT OUTER JOIN Empleados E5 ON E5.IdEmpleado=Recepciones.IdComprador
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
WHERE (Recepciones.IdRecepcion=@IdRecepcion)