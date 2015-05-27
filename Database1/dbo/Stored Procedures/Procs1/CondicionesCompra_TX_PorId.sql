






























CREATE Procedure [dbo].[CondicionesCompra_TX_PorId]
@IdCondicionCompra int
AS 
SELECT *
FROM [Condiciones Compra]
where (IdCondicionCompra=@IdCondicionCompra)































