





























CREATE Procedure [dbo].[DetRequerimientos_TX_Todos]
@IdRequerimiento int
AS 
SELECT *
FROM [DetalleRequerimientos]
where (IdRequerimiento=@IdRequerimiento)
order by DetalleRequerimientos.NumeroItem






























