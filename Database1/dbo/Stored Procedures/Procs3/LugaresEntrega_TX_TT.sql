




CREATE Procedure [dbo].[LugaresEntrega_TX_TT]
@IdLugarEntrega int
AS 
SELECT *
FROM LugaresEntrega
WHERE (IdLugarEntrega=@IdLugarEntrega)




