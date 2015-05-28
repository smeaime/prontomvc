
CREATE Procedure [dbo].[wPaises_T]

@IdPais int = Null

AS 

SET @IdPais=IsNull(@IdPais,-1)

IF @IdPais=-2
	SELECT 
	 Paises.IdPais as [IdPais],
	 Paises.Descripcion as [Pais]
	FROM Paises
	ORDER BY Paises.Descripcion
ELSE
	SELECT Paises.*
	FROM Paises
	WHERE @IdPais=-1 or Paises.IdPais=@IdPais
	ORDER BY Paises.Descripcion

