





























CREATE Procedure [dbo].[RubrosValores_TL]
AS 
SELECT 
IdRubroValor,
Codigo+' - '+Descripcion as [Titulo]
FROM RubrosValores
ORDER by Convert(int,Codigo),Descripcion






























