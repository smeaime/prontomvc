CREATE  Procedure [dbo].[Transportistas_TX_TT]

@IdTransportista int

AS 

SELECT 
 Transportistas.IdTransportista, 
 Transportistas.RazonSocial, 
 Transportistas.Codigo,
 Transportistas.Direccion, 
 Localidades.Nombre AS [Localidad], 
 Transportistas.CodigoPostal, 
 Provincias.Nombre AS [Provincia], 
 Paises.Descripcion AS [Pais], 
 Transportistas.Telefono, 
 Transportistas.Fax, 
 Transportistas.Email, 
 Transportistas.Cuit, 
 DescripcionIva.Descripcion AS [Condicion IVA], 
 Transportistas.Contacto,
 Transportistas.Horario,
 Transportistas.Celular
FROM Transportistas 
LEFT OUTER JOIN DescripcionIva ON 	Transportistas.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Localidades ON Transportistas.IdLocalidad = Localidades.IdLocalidad 
LEFT OUTER JOIN Provincias ON Transportistas.IdProvincia = Provincias.IdProvincia
LEFT OUTER JOIN Paises ON Transportistas.IdPais = Paises.IdPais
WHERE (IdTransportista=@IdTransportista)
ORDER BY Transportistas.RazonSocial