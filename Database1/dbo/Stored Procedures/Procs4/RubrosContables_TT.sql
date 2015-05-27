CREATE Procedure [dbo].[RubrosContables_TT]

AS 

SELECT
 IdRubroContable,
 Codigo,
 Descripcion as [Rubro],
 Nivel
FROM RubrosContables 
ORDER by Descripcion