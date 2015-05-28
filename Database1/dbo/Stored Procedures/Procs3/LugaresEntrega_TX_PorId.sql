




CREATE Procedure [dbo].[LugaresEntrega_TX_PorId]
@IdLugarEntrega int
AS 
SELECT *
FROM LugaresEntrega
WHERE (IdLugarEntrega=@IdLugarEntrega)




