
CREATE  Procedure [dbo].[wProveedores_TX_Busqueda]

@Busqueda varchar(100)

AS 

SELECT 
 Proveedores.*, 
 Localidades.Nombre AS [Localidad], 
 Provincias.Nombre AS [Provincia], 
 Provincias.PlantillaRetencionIIBB,
 Paises.Descripcion AS [Pais], 
 DescripcionIva.Descripcion AS [CondicionIVA], 
 [Estados Proveedores].Descripcion as [Estado],
 [Actividades Proveedores].Descripcion as [Actividad],
 [Condiciones Compra].Descripcion as [CondicionCompra],
 Case When IGCondicion is null or IGCondicion=1
	Then Null
	Else TiposRetencionGanancia.Descripcion 
 End as [CategoriaGanancias],
 Case When IsNull(Proveedores.IBCondicion,1)=1 Then 'Exento'
	When IsNull(Proveedores.IBCondicion,1)=2 Then 'Conv.Mult.'
	When IsNull(Proveedores.IBCondicion,1)=3 Then 'Juris.Local'
	When IsNull(Proveedores.IBCondicion,1)=4 Then 'No alcanzado'
	Else Null
 End as [SituacionIIBB],
 IBCondiciones.Descripcion as [CategoriaIIBB],
 Cuentas.Descripcion as [CuentaContable],
 Monedas.Abreviatura as [MonedaHabitual],
 ImpuestosDirectos.Descripcion as [ImpuestoDirectoSUSS],
 E1.Nombre as [UsuarioIngreso],
 E2.Nombre as [UsuarioModifico]
FROM Proveedores
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Localidades ON Proveedores.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Proveedores.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Proveedores.IdPais = Paises.IdPais
LEFT OUTER JOIN [Estados Proveedores] ON Proveedores.IdEstado = [Estados Proveedores].IdEstado
LEFT OUTER JOIN [Actividades Proveedores] ON Proveedores.IdActividad = [Actividades Proveedores].IdActividad
LEFT OUTER JOIN [Condiciones Compra] ON Proveedores.IdCondicionCompra = [Condiciones Compra].IdCondicionCompra
LEFT OUTER JOIN TiposRetencionGanancia ON Proveedores.IdTipoRetencionGanancia = TiposRetencionGanancia.IdTipoRetencionGanancia
LEFT OUTER JOIN Cuentas ON Proveedores.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN IBCondiciones ON Proveedores.IdIBCondicionPorDefecto = IBCondiciones.IdIBCondicion
LEFT OUTER JOIN Monedas ON Proveedores.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN ImpuestosDirectos ON Proveedores.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
LEFT OUTER JOIN Empleados E1 ON Proveedores.IdUsuarioIngreso = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Proveedores.IdUsuarioModifico = E2.IdEmpleado
WHERE 
--IsNull(Eventual,'NO')<>'SI' and 
Proveedores.RazonSocial like '%'+@Busqueda+'%'
ORDER BY Proveedores.RazonSocial

