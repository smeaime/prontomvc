CREATE Procedure [dbo].[Conciliaciones_E]

@IdConciliacion int  

AS

DELETE Conciliaciones
WHERE (IdConciliacion=@IdConciliacion)