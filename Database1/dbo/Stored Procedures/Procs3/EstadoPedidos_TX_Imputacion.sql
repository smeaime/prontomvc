





























CREATE Procedure [dbo].[EstadoPedidos_TX_Imputacion]
@IdEstado int
AS 
SELECT *
FROM EstadoPedidos
where (IdEstado=@IdEstado)






























