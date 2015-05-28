CREATE Procedure [dbo].[DetPlazosFijosRubrosContables_BorrarPorIdPlazoFijo]

@IdPlazoFijo int  

AS

DELETE DetallePlazosFijosRubrosContables
WHERE (IdPlazoFijo=@IdPlazoFijo)