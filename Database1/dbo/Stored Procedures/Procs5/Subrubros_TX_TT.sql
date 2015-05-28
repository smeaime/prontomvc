CREATE Procedure [dbo].[Subrubros_TX_TT]

@IdSubrubro smallint

AS 

SELECT 
 IdSubrubro,
 Descripcion as [Subrubro],
 Codigo as [Codigo],
 Abreviatura as [Abreviatura]
FROM Subrubros
WHERE (IdSubrubro=@IdSubrubro)
