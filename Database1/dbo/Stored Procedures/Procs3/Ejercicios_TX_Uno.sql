















CREATE Procedure [dbo].[Ejercicios_TX_Uno]
@Ejercicio int,
@IdCuenta int
AS 
Select *
FROM Ejercicios
where Ejercicio=@Ejercicio and IdCuenta=@IdCuenta















