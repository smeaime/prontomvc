





























CREATE Procedure [dbo].[EjerciciosPeriodos_TX_PorEjercicio]
@Ejercicio int
AS 
Select *
FROM EjerciciosPeriodos
where Ejercicio=@Ejercicio






























