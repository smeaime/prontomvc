


CREATE Procedure [dbo].[ImpuestosDirectos_TX_PorGrupoConCertificado]
@Grupo int
As 
Select * 
From ImpuestosDirectos
Where Grupo=@Grupo and IsNull(ProximoNumeroCertificado,0)>0


