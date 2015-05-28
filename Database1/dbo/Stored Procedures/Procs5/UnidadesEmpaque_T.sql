
CREATE Procedure [dbo].[UnidadesEmpaque_T]

@IdUnidadEmpaque int

AS 

SELECT *
FROM UnidadesEmpaque
WHERE (IdUnidadEmpaque=@IdUnidadEmpaque)
