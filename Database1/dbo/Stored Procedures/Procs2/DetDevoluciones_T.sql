






























CREATE Procedure [dbo].[DetDevoluciones_T]
@IdDetalleDevolucion int
AS 
SELECT *
FROM DetalleDevoluciones
where (IdDetalleDevolucion=@IdDetalleDevolucion)































