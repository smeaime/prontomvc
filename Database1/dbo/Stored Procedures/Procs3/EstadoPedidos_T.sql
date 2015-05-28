





























CREATE Procedure [dbo].[EstadoPedidos_T]
@IdEstado int
AS 
SELECT *
FROM EstadoPedidos
where (IdEstado=@IdEstado)






























