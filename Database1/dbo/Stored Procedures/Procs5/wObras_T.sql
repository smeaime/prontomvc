
CREATE Procedure [dbo].[wObras_T]

@IdObra int = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)

SELECT 
 Obras.*,
 Clientes.RazonSocial as [Cliente],
 UnidadesOperativas.Descripcion as [UnidadOperativa],
 E1.Nombre as [JefeObra],
 E2.Nombre as [SubjefeObra],
 E3.Nombre as [JefeRegionalObra],
 Articulos.Descripcion as [ArticuloAsociado],
 Localidades.Nombre as [Localidad], 
 Provincias.Nombre as [Provincia], 
 Paises.Descripcion as [Pais], 
 Cuentas.Codigo as [CodigoCuentaFF],
 Monedas.Abreviatura as [MonedaValorObra],
 GruposObras.Descripcion as [GrupoObra]
FROM Obras
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Empleados E1 ON Obras.IdJefe = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Obras.IdSubjefe = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON Obras.IdJefeRegional = E3.IdEmpleado
LEFT OUTER JOIN UnidadesOperativas ON Obras.IdUnidadOperativa = UnidadesOperativas.IdUnidadOperativa
LEFT OUTER JOIN Articulos ON Obras.IdArticuloAsociado = Articulos.IdArticulo
LEFT OUTER JOIN Localidades ON Obras.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Obras.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Obras.IdPais = Paises.IdPais
LEFT OUTER JOIN Cuentas ON Obras.IdCuentaContableFF = Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON Obras.IdMonedaValorObra = Monedas.IdMoneda
LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
WHERE @IdObra=-1 or Obras.IdObra=@IdObra
ORDER BY Obras.NumeroObra

