





CREATE Procedure [dbo].[ImpuestosDirectos_E]
@IdImpuestoDirecto int  
As 
Delete ImpuestosDirectos
Where (IdImpuestoDirecto=@IdImpuestoDirecto)





