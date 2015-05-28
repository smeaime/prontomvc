
CREATE Procedure [dbo].[DefinicionArticulos_TX_Art]

@IdRubro int,
@IdSubrubro int,
@Campo varchar(50) = Null

AS

SET @Campo=IsNull(@Campo,'')

SELECT *
FROM DefinicionArticulos
WHERE IdRubro=@IdRubro and IdSubrubro=@IdSubrubro and 
	(@Campo='' or Campo=@Campo)
ORDER BY Orden
