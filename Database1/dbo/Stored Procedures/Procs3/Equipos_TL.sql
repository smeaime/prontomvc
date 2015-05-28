





























CREATE Procedure [dbo].[Equipos_TL]
AS 
Select 
IdEquipo,
'[ '+Tag+' ]  '+Descripcion as [Titulo]
FROM Equipos 
ORDER By Tag






























