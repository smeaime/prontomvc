
















CREATE Procedure [dbo].[DetConciliacionesNoContables_T]
@IdDetalleConciliacionNoContable int
AS 
SELECT *
FROM [DetalleConciliacionesNoContables]
WHERE (IdDetalleConciliacionNoContable=@IdDetalleConciliacionNoContable)

















