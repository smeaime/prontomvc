CREATE Procedure [dbo].[CertificacionesObras_TX_DetallePxQ]

@IdCertificacionObras int

AS 

SELECT PxQ.*
FROM CertificacionesObrasPxQ PxQ
WHERE PxQ.IdCertificacionObras=@IdCertificacionObras
ORDER BY PxQ.Año, PxQ.Mes