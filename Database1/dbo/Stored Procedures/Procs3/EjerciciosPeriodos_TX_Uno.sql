





























CREATE Procedure [dbo].[EjerciciosPeriodos_TX_Uno]
@Fecha datetime
AS 
Select *
FROM EjerciciosPeriodos
where @Fecha between FechaInicio and FechaFinalizacion






























