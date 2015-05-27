CREATE Procedure [dbo].[DetRubrosContables_E]

@IdDetalleRubroContable int  

AS 

DELETE [DetalleRubrosContables]
WHERE (IdDetalleRubroContable=@IdDetalleRubroContable)