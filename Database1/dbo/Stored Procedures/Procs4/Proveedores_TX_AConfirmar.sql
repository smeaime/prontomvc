




















CREATE  Procedure [dbo].[Proveedores_TX_AConfirmar]
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111111111111111133'
set @vector_T='05555555555555555555555500'
SELECT 
		Proveedores.IdProveedor, 
		Proveedores.RazonSocial as [Razon social], 
		Proveedores.CodigoEmpresa as [Codigo],
		Proveedores.Direccion, 
		Localidades.Nombre AS [Localidad], 
		Proveedores.CodigoPostal as [Cod.postal], 
		Provincias.Nombre AS [Provincia], 
		Paises.Descripcion AS [Pais], 
		Proveedores.Telefono1 as [Telefono], 
		Proveedores.Telefono2 as [Telef.adic.],
		Proveedores.Fax, 
		Proveedores.Email, 
		Proveedores.Cuit, 
		DescripcionIva.Descripcion AS [Condicion IVA], 
		Proveedores.Contacto, 
		Proveedores.FechaAlta as [Fecha de alta], 
		Proveedores.FechaUltimaCompra as [Fec.ult.compra],
		[Estados Proveedores].Descripcion as Estado,
		[Actividades Proveedores].Descripcion as [Actividad principal],
		[Condiciones Compra].Descripcion as [Cond. de compra],
		Proveedores.PaginaWeb as [Pagina Web],
		Proveedores.Habitual,
		Proveedores.NombreFantasia as [Nombre de fantasia], 
		Proveedores.Observaciones,
		@Vector_T as Vector_T,
		@Vector_X as Vector_X
FROM Proveedores
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
LEFT OUTER JOIN [Estados Proveedores] ON Proveedores.IdEstado = [Estados Proveedores].IdEstado
LEFT OUTER JOIN [Actividades Proveedores] ON Proveedores.IdActividad = [Actividades Proveedores].IdActividad
LEFT OUTER JOIN [Condiciones Compra] ON Proveedores.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
WHERE Eventual is null and Confirmado='NO'
ORDER BY Proveedores.RazonSocial




















