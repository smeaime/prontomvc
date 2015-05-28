CREATE Procedure [dbo].[SubcontratosDatos_T]

@IdSubcontratoDatos int

AS 

SELECT*
FROM SubcontratosDatos
WHERE (IdSubcontratoDatos=@IdSubcontratoDatos)