
CREATE Procedure [dbo].[Subrubros_T]

@IdSubrubro smallint

AS 

SELECT *
FROM Subrubros
WHERE (IdSubrubro=@IdSubrubro)
