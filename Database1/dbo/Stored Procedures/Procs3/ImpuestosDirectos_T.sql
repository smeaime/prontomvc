





CREATE Procedure [dbo].[ImpuestosDirectos_T]
@IdImpuestoDirecto int
As 
Select *
From ImpuestosDirectos
Where (IdImpuestoDirecto=@IdImpuestoDirecto)





