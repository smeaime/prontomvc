CREATE Procedure [dbo].[Subrubros_TT]

AS 

SELECT  
 IdSubrubro,
 Descripcion as [Subrubro],
 Codigo as [Codigo],
 Abreviatura as [Abreviatura]
FROM Subrubros
ORDER by Descripcion
