




CREATE Procedure [dbo].[LugaresEntrega_T]
@IdLugarEntrega int
AS 
SELECT *
FROM LugaresEntrega
WHERE (IdLugarEntrega=@IdLugarEntrega)




