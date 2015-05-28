































CREATE Procedure [dbo].[DefinicionArticulos_T]
@IdDef int
AS 
SELECT *
FROM DefinicionArticulos
where (IdDef=@IdDef)
order by Orden
































