
CREATE  PROCEDURE [dbo].wLocalidades_TT
AS 
    SELECT  IdLocalidad,
            Localidades.Nombre AS [Localidad],
            Localidades.CodigoPostal AS [Codigo postal],
            Provincias.Nombre AS [Provincia],
            Paises.Descripcion AS [Pais],
            CodigoONCAA as CodigoONCAA, CodigoWilliams,CodigoLosGrobo,
			Partidos.Nombre AS [Partido]
			--,partidos.idpartido
    FROM    Localidades
            LEFT OUTER JOIN Provincias ON Provincias.IdProvincia = Localidades.IdProvincia
            LEFT OUTER JOIN Paises ON Paises.IdPais = Provincias.IdPais
			LEFT OUTER JOIN Partidos ON Partidos.IdPartido= Localidades.IdPartido
    ORDER BY Localidades.Nombre

