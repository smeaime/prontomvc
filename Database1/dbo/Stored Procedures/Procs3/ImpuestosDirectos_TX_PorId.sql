





CREATE Procedure [dbo].[ImpuestosDirectos_TX_PorId]
@IdImpuestoDirecto int
As 
Select *
From ImpuestosDirectos
Where (IdImpuestoDirecto=@IdImpuestoDirecto)





