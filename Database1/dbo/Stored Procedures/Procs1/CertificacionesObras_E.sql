
CREATE Procedure [dbo].[CertificacionesObras_E]

@IdCertificacionObras int  

AS 

DELETE CertificacionesObras
WHERE (IdCertificacionObras=@IdCertificacionObras)
