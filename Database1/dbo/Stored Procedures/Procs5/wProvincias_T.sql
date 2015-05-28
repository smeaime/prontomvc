
CREATE Procedure [dbo].[wProvincias_T]

@IdProvincia int = Null

AS 

SET @IdProvincia=IsNull(@IdProvincia,-1)

IF @IdProvincia=-2
	SELECT 
	 Provincias.IdProvincia as [IdProvincia],
	 Provincias.Nombre as [Provincia],
	 Paises.Descripcion as [Pais]
	FROM Provincias
	LEFT OUTER JOIN Paises ON Provincias.IdPais=Paises.IdPais
	ORDER BY Provincias.Nombre
ELSE
	SELECT 
	 Provincias.*,
	 Paises.Descripcion as [Pais]
	FROM Provincias
	LEFT OUTER JOIN Paises ON Provincias.IdPais=Paises.IdPais
	WHERE @IdProvincia=-1 or Provincias.IdProvincia=@IdProvincia
	ORDER BY Provincias.Nombre

