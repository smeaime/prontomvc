
CREATE  Procedure [dbo].[CertificacionesObras_ActualizarPorNumeroCertificado]

@NumeroCertificado int,
@Adjunto1 varchar(100)

AS

UPDATE CertificacionesObras
SET Adjunto1=@Adjunto1
WHERE (NumeroCertificado=@NumeroCertificado)
