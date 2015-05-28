





















CREATE Procedure [dbo].[PlazosFijos_TL]
AS 
SELECT 
 IdPlazoFijo,
 Bancos.Nombre+' - Certif.: '+Convert(varchar,NumeroCertificado1) as [Titulo]
FROM PlazosFijos
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=PlazosFijos.IdBanco
ORDER by [Titulo]






















