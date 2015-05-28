CREATE Procedure [dbo].[CertificacionesObrasDatos_T]

@IdCertificacionObraDatos int

AS 

SELECT*
FROM CertificacionesObrasDatos
WHERE (IdCertificacionObraDatos=@IdCertificacionObraDatos)