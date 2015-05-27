CREATE Procedure [dbo].[Subcontratos_TX_EtapasParaCombo]

@NumeroSubcontrato int

AS 

SELECT IdSubcontrato, IsNull(Item COLLATE Modern_Spanish_CI_AS+' ','') + Descripcion as [Titulo]
FROM Subcontratos
WHERE NumeroSubcontrato=@NumeroSubcontrato
ORDER BY Item, IdSubcontrato