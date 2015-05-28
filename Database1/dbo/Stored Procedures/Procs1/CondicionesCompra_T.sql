
CREATE Procedure [dbo].[CondicionesCompra_T]
@IdCondicionCompra int
AS 
SELECT *
FROM [Condiciones Compra]
WHERE (IdCondicionCompra=@IdCondicionCompra)
