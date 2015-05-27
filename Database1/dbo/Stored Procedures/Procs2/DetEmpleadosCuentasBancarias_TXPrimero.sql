CREATE PROCEDURE [dbo].[DetEmpleadosCuentasBancarias_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01133'
SET @vector_T='0GG00'

SELECT TOP 1
 Det.IdDetalleEmpleadoCuentaBancaria,
 Bancos.Nombre as [Banco],
 CuentasBancarias.Cuenta as [Cuenta bancaria],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleEmpleadosCuentasBancarias Det
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=Det.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco