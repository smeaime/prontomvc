
CREATE Procedure [dbo].[Subrubros_TX_PorId]

@IdSubrubro smallint

AS 

SELECT *
FROM Subrubros
WHERE (IdSubrubro=@IdSubrubro)
