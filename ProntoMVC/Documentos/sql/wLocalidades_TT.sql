--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////

IF EXISTS ( SELECT  *
            FROM    dbo.sysobjects
            WHERE   id = OBJECT_ID(N'[dbo].[wLocalidades_TT]')
                    AND OBJECTPROPERTY(id, N'IsProcedure') = 1 ) 
    DROP PROCEDURE wLocalidades_TT
go

CREATE  PROCEDURE [dbo].wLocalidades_TT
AS 
    SELECT  IdLocalidad,
            Localidades.Nombre AS [Localidad],
            Localidades.CodigoPostal AS [Codigo postal],
            Provincias.Nombre AS [Provincia],
            Paises.Descripcion AS [Pais],
            CodigoONCAA as CodigoONCAA, CodigoWilliams,CodigoLosGrobo,CodigoAFIP,
			Partidos.Nombre AS [Partido]
			,CodigoCGG
			--,partidos.idpartido
    FROM    Localidades
            LEFT OUTER JOIN Provincias ON Provincias.IdProvincia = Localidades.IdProvincia
            LEFT OUTER JOIN Paises ON Paises.IdPais = Provincias.IdPais
			LEFT OUTER JOIN Partidos ON Partidos.IdPartido= Localidades.IdPartido
    ORDER BY Localidades.Nombre

go

wLocalidades_TT
--select * from localidades
--select * from partidos
--/////////////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////////////
