CREATE Procedure [dbo].[Localidades_TX_TT]

@IdLocalidad smallint

AS 

SELECT
 IdLocalidad,
 Localidades.Nombre as [Localidad],
 Localidades.CodigoPostal as [Codigo postal],
 Provincias.Nombre as [Provincia],
 Paises.Descripcion as [Pais],
 Localidades.CodigoESRI [Cod.ESRI],
 Localidades.Codigo as [Codigo]
FROM Localidades
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=Localidades.IdProvincia
LEFT OUTER JOIN Paises ON Paises.IdPais=Provincias.IdPais
WHERE (IdLocalidad=@IdLocalidad)