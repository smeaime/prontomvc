





























CREATE Procedure [dbo].[Equipos_T]
@IdEquipo smallint
AS 
SELECT*
FROM Equipos
where (IdEquipo=@IdEquipo)






























