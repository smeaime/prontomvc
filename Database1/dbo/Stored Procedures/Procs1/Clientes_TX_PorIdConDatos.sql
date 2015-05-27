CREATE  Procedure [dbo].[Clientes_TX_PorIdConDatos]

@IdCliente int,
@IdVendedor int = Null,
@Formato varchar(1) = Null

AS 

SET @IdVendedor=IsNull(@IdVendedor,-1)
SET @Formato=IsNull(@Formato,'1')

SELECT 
 Clientes.*, 
 Case When @Formato='1' Then Clientes.RazonSocial+IsNull(' ('+Clientes.Codigo Collate modern_spanish_ci_as +')','') Else Clientes.RazonSocial End as [Titulo],
 Localidades.Nombre as [Localidad],
 Provincias.Nombre as [Provincia],
 Paises.Descripcion as [Pais], 
 IsNull(Paises.Codigo2,'') as [PaisCodigo2], 
 IsNull(Paises.Cuit,'') as [CuitPais], 
 DescripcionIva.Descripcion as [CondicionIVA]
FROM Clientes 
LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad = Localidades.IdLocalidad
LEFT OUTER JOIN Provincias ON Clientes.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Clientes.IdPais = Paises.IdPais
LEFT OUTER JOIN DescripcionIva ON Clientes.IdCodigoIva = DescripcionIva.IdCodigoIva 
WHERE (@IdCliente=-1 or IdCliente=@IdCliente) and (@IdVendedor=-1 or Clientes.Vendedor1=@IdVendedor)
ORDER BY Clientes.RazonSocial
