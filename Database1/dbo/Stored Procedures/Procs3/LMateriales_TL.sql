





























CREATE Procedure [dbo].[LMateriales_TL]
AS 
Select 
IdLMateriales,
'LM : '+LMateriales.Nombre+' ('+Convert(varchar,LMateriales.NumeroLMateriales)+') - Obra : '+Obras.NumeroObra+' - Equ.: '+Equipos.tag as [Titulo]
FROM LMateriales
LEFT OUTER JOIN Obras ON LMateriales.IdObra=Obras.IdObra
LEFT OUTER JOIN Equipos ON LMateriales.IdEquipo=Equipos.IdEquipo
ORDER BY Titulo






























