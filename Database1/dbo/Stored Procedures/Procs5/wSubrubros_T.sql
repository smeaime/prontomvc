
CREATE Procedure [dbo].[wSubrubros_T]

@IdSubrubro int = Null

AS 

SET @IdSubrubro=IsNull(@IdSubrubro,-1)

IF @IdSubrubro=-2
	SELECT 
	 Subrubros.IdSubrubro as [IdSubrubro],
	 Subrubros.Descripcion as [Subrubro],
	 Subrubros.Abreviatura as [Abrev.]
	FROM Subrubros
	ORDER BY Subrubros.Descripcion
ELSE
	SELECT Subrubros.*
	FROM Subrubros
	WHERE @IdSubrubro=-1 or Subrubros.IdSubrubro=@IdSubrubro
	ORDER BY Subrubros.Descripcion

