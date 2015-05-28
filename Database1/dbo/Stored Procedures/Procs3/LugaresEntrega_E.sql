




CREATE Procedure [dbo].[LugaresEntrega_E]
@IdLugarEntrega int 
AS 
DELETE LugaresEntrega
WHERE (IdLugarEntrega=@IdLugarEntrega)




