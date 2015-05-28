CREATE  Procedure [dbo].[Conciliaciones_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00111111111111133'
SET @vector_T='00393555355553300'

SELECT 
 Conciliaciones.IdConciliacion,
 Conciliaciones.IdCuentaBancaria,
 Bancos.Nombre as [Banco],
 Conciliaciones.IdConciliacion as [IdAux],
 CuentasBancarias.Cuenta as [Cuenta],
 Conciliaciones.FechaIngreso as [Fecha ing.],
 Conciliaciones.FechaInicial as [Fecha ini.],
 Conciliaciones.FechaFinal as [Fecha final],
 Conciliaciones.Numero as [Resumen],
 Conciliaciones.SaldoInicialResumen as [Sdo. inicial resumen],
 Conciliaciones.SaldoFinalResumen as [Sdo. final resumen],
 Conciliaciones.ImporteAjuste as [Imp. ajuste],
 Conciliaciones.Observaciones as [Observaciones],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=Conciliaciones.IdRealizo) as [Realizo],
 (Select Top 1 Empleados.Nombre From Empleados 
  Where Empleados.IdEmpleado=Conciliaciones.IdAprobo) as [Aprobo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Conciliaciones
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
ORDER BY Bancos.Nombre,CuentasBancarias.Cuenta, Conciliaciones.FechaIngreso,Conciliaciones.Numero