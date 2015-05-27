
CREATE Procedure [dbo].[UnidadesEmpaque_E]

@IdUnidadEmpaque int  

AS 

DELETE UnidadesEmpaque
WHERE (IdUnidadEmpaque=@IdUnidadEmpaque)
