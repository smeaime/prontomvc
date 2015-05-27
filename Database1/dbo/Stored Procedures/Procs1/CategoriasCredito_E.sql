CREATE Procedure [dbo].[CategoriasCredito_E]

@IdCategoriaCredito int 

AS 

DELETE CategoriasCredito
WHERE (IdCategoriaCredito=@IdCategoriaCredito)