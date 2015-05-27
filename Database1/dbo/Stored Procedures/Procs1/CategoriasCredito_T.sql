CREATE Procedure [dbo].[CategoriasCredito_T]

@IdCategoriaCredito int

AS 

SELECT *
FROM CategoriasCredito
WHERE (IdCategoriaCredito=@IdCategoriaCredito)