CREATE Procedure [dbo].[CertificacionesObras_TX_EtapasParaCombo]

@NumeroProyecto int

AS 

SELECT IdCertificacionObras, IsNull(Item COLLATE Modern_Spanish_CI_AS+' ','') + Descripcion as [Titulo]
FROM CertificacionesObras
WHERE NumeroProyecto=@NumeroProyecto
ORDER BY Item, IdCertificacionObras