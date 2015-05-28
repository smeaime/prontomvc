
CREATE Procedure [dbo].[wImpuestosDirectos_TL]
AS 
SELECT IdImpuestoDirecto, Descripcion as [Titulo]
FROM ImpuestosDirectos
ORDER BY Descripcion

