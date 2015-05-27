
















CREATE Procedure [dbo].[DetConciliacionesNoContables_E]
@IdDetalleConciliacionNoContable int 
As  
Delete [DetalleConciliacionesNoContables]
Where (IdDetalleConciliacionNoContable=@IdDetalleConciliacionNoContable)

















