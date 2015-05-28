CREATE Procedure [dbo].[CategoriasCredito_TX_TT]

@IdCategoriaCredito int

AS 

SELECT *
FROM CategoriasCredito
WHERE (IdCategoriaCredito=@IdCategoriaCredito)