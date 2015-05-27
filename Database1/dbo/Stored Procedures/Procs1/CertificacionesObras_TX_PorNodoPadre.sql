CREATE Procedure [dbo].[CertificacionesObras_TX_PorNodoPadre]

@IdNodoPadre int

AS 

SELECT *
FROM CertificacionesObras 
WHERE IsNull(idNodoPadre,0)=@IdNodoPadre
ORDER BY TipoNodo, Descripcion, IdCertificacionObras