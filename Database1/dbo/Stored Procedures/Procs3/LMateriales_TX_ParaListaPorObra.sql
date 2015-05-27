





























CREATE Procedure [dbo].[LMateriales_TX_ParaListaPorObra]
@IdObra int
AS 
Select 
IdLMateriales,
'LM : '+LMateriales.Nombre+' ('+Convert(varchar,LMateriales.NumeroLMateriales)+') -  '+Obras.NumeroObra+' - '+Equipos.Tag  as [Titulo]
FROM LMateriales
LEFT OUTER JOIN Obras ON LMateriales.IdObra=Obras.IdObra
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
WHERE LMateriales.IdObra=@IdObra
ORDER BY Titulo






























