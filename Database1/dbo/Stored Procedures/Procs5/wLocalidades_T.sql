
CREATE Procedure [dbo].[wLocalidades_T]

@IdLocalidad int = Null

AS 

SET @IdLocalidad=IsNull(@IdLocalidad,-1)

IF @IdLocalidad=-2
	SELECT 
	 Localidades.IdLocalidad as [IdLocalidad],
	 Localidades.Nombre as [Localidad],
	 Provincias.Nombre as [Provincia],
	 Paises.Descripcion as [Pais]
	FROM Localidades
	LEFT OUTER JOIN Provincias ON Localidades.IdProvincia=Provincias.IdProvincia
	LEFT OUTER JOIN Paises ON Provincias.IdPais=Paises.IdPais
	ORDER BY Localidades.Nombre
ELSE
	SELECT 
	 Localidades.*,
	 Provincias.Nombre as [Provincia],
	 Provincias.IdPais as [IdPais],
	 Paises.Descripcion as [Pais]
	FROM Localidades
	LEFT OUTER JOIN Provincias ON Localidades.IdProvincia=Provincias.IdProvincia
	LEFT OUTER JOIN Paises ON Provincias.IdPais=Paises.IdPais
	WHERE @IdLocalidad=-1 or Localidades.IdLocalidad=@IdLocalidad
	ORDER BY Localidades.Nombre

