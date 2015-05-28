CREATE Procedure [dbo].[DetRubrosContables_T]

@IdDetalleRubroContable int

AS 

SELECT *
FROM [DetalleRubrosContables]
WHERE (IdDetalleRubroContable=@IdDetalleRubroContable)