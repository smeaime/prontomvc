
CREATE Procedure [dbo].[CertificacionesObras_T]

@IdCertificacionObras int

AS 

SELECT*
FROM CertificacionesObras
WHERE (IdCertificacionObras=@IdCertificacionObras)
