CREATE Procedure [dbo].[CertificacionesObras_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011133'
SET @vector_T='040500'

SELECT 
 CertificacionesObras.NumeroProyecto,
 Obras.NumeroObra as [Cod.Obra],
 Obras.Descripcion as [Obra],
 CertificacionesObras.NumeroProyecto as [Nro. proyecto], 
-- CertificacionesObras.Adjunto1 as [Archivo adjunto],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CertificacionesObras
LEFT OUTER JOIN Obras ON Obras.IdObra = CertificacionesObras.IdObra
GROUP BY CertificacionesObras.IdObra, Obras.NumeroObra, Obras.Descripcion, CertificacionesObras.NumeroProyecto
ORDER BY Obras.Descripcion, CertificacionesObras.NumeroProyecto