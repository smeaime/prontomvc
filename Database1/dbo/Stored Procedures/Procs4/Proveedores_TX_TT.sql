
CREATE  Procedure [dbo].[Proveedores_TX_TT]

@IdProveedor int

AS 

DECLARE @vector_X varchar(100), @vector_T varchar(100)
SET @vector_X='01111111111111111111111111111111111111111611111133'
SET @vector_T='05141011201251255013252215523366445514144533000000'

SELECT 
 Proveedores.IdProveedor, 
 Proveedores.RazonSocial as [Razon social], 
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.Direccion, 
 Localidades.Nombre as [Localidad], 
 Proveedores.CodigoPostal as [Cod.postal], 
 Provincias.Nombre as [Provincia], 
 Paises.Descripcion as [Pais], 
 Proveedores.Telefono1 as [Telefono], 
 Proveedores.Telefono2 as [Telef.adic.],
 Proveedores.Fax as [Fax], 
 Proveedores.Email as [Email], 
 Proveedores.Cuit as [Cuit], 
 DescripcionIva.Descripcion as [Condicion IVA], 
 Proveedores.Contacto as [Contacto], 
 Proveedores.FechaAlta as [Fecha de alta], 
 Proveedores.FechaUltimaCompra as [Fec.ult.compra],
 [Estados Proveedores].Descripcion as Estado,
 [Actividades Proveedores].Descripcion as [Actividad principal],
 [Condiciones Compra].Descripcion as [Cond. de compra],
 Proveedores.PaginaWeb as [Pagina Web],
 Proveedores.Habitual as [Habitual], 
 Proveedores.NombreFantasia as [Nombre comercial], 
 Proveedores.Nombre1 as [Datos adicionales 1], 
 Proveedores.Nombre2 as [Datos adicionales 2], 
 Proveedores.Observaciones,
 Proveedores.CodigoPresto as [Cod.PRESTO],
 Case When IGCondicion is null or IGCondicion=1 Then 'NO' Else 'SI' End as [Insc.Gan.],
 Case When IGCondicion is null or IGCondicion=1 Then Null Else TiposRetencionGanancia.Descripcion End as [Categoria ganancias],
 C1.Descripcion as [Cuenta contable],
 Case When IsNull(Proveedores.IBCondicion,1)=1 Then 'Exento'
	When IsNull(Proveedores.IBCondicion,1)=2 Then 'Conv.Mult.'
	When IsNull(Proveedores.IBCondicion,1)=3 Then 'Juris.Local'
	When IsNull(Proveedores.IBCondicion,1)=4 Then 'No alcanzado'
	Else Null
 End as [Categoria IIBB],
 Proveedores.FechaLimiteExentoIIBB as [Fec.Lim.Ex.IIBB],
 Proveedores.IBNumeroInscripcion as [Nro.Insc.IIBB],
 IBCondiciones.Descripcion as [Condicion IIBB],
 FechaUltimaPresentacionDocumentacion as [Fecha pres.],
 Proveedores.CodigoSituacionRetencionIVA as [Cod.Sit.Ret.IVA],
 E1.Nombre as [Ingreso],
 Proveedores.FechaIngreso as [Fecha ing.],
 E2.Nombre as [Modifico],
 Proveedores.FechaModifico as [Fecha modif.],
 Proveedores.SujetoEmbargado as [Embargo IIBB],
 Proveedores.SaldoEmbargo as [Sdo.Embargo IIBB],
 Proveedores.Calificacion as [Calif.],
 C2.Descripcion as [Cuenta p/provision],
 Proveedores.ArchivoAdjunto1 as [Archivo adjunto 1],
 Proveedores.ArchivoAdjunto2 as [Archivo adjunto 2],
 Proveedores.ArchivoAdjunto3 as [Archivo adjunto 3],
 Proveedores.ArchivoAdjunto4 as [Archivo adjunto 4],
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
LEFT OUTER JOIN TiposRetencionGanancia ON Proveedores.IdTipoRetencionGanancia = TiposRetencionGanancia.IdTipoRetencionGanancia
LEFT OUTER JOIN Cuentas C1 ON Proveedores.IdCuenta = C1.IdCuenta
LEFT OUTER JOIN Cuentas C2 ON Proveedores.IdCuentaProvision = C2.IdCuenta
LEFT OUTER JOIN IBCondiciones ON Proveedores.IdIBCondicionPorDefecto = IBCondiciones.IdIBCondicion
LEFT OUTER JOIN Empleados E1 ON Proveedores.IdUsuarioIngreso = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Proveedores.IdUsuarioModifico = E2.IdEmpleado
WHERE Eventual is null And IdProveedor=@IdProveedor