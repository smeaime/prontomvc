CREATE  Procedure [dbo].[Proveedores_TX_ConDatos]

@IdProveedor int

AS 

SELECT 
 Proveedores.*, 
 Localidades.Nombre AS [Localidad], 
 Provincias.Nombre AS [Provincia], 
 Provincias.PlantillaRetencionIIBB,
 Paises.Descripcion AS [Pais], 
 DescripcionIva.Descripcion AS [CondicionIVA], 
 [Estados Proveedores].Descripcion as [Estado],
 [Actividades Proveedores].Descripcion as [ActividadPrincipal],
 IsNull([Actividades Proveedores].Agrupacion1,0) as [ActividadPrincipalGrupo],
 [Condiciones Compra].Descripcion as [CondicionCompra]
FROM Proveedores
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
LEFT OUTER JOIN [Estados Proveedores] ON Proveedores.IdEstado = [Estados Proveedores].IdEstado
LEFT OUTER JOIN [Actividades Proveedores] ON Proveedores.IdActividad = [Actividades Proveedores].IdActividad
LEFT OUTER JOIN [Condiciones Compra] ON Proveedores.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
WHERE Eventual is null And IdProveedor=@IdProveedor