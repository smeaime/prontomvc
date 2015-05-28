
CREATE Procedure [dbo].[CertificacionesObras_TX_TT]

@IdObra int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111133'
SET @vector_T='0405300'

SELECT TOP 1 
 CertificacionesObras.NumeroCertificado,
 Obras.NumeroObra as [Cod.Obra],
 Obras.Descripcion as [Obra],
 CertificacionesObras.NumeroCertificado as [Nro. certificado], 
 CertificacionesObras.Adjunto1 as [Archivo adjunto],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CertificacionesObras
LEFT OUTER JOIN Obras ON Obras.IdObra = CertificacionesObras.IdObra
WHERE CertificacionesObras.IdObra=@IdObra
GROUP BY CertificacionesObras.IdObra, Obras.NumeroObra, Obras.Descripcion, 
		CertificacionesObras.NumeroCertificado, CertificacionesObras.Adjunto1 
ORDER BY Obras.Descripcion
