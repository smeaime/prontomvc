




CREATE Procedure [dbo].[RubrosContables_TL]
AS 
SELECT
 IdRubroContable,
 Convert(varchar,IsNull(Codigo,0))+' - '+Descripcion as Titulo
FROM RubrosContables 
WHERE Financiero is null or Financiero<>'SI'
ORDER by Descripcion




