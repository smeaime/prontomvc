CREATE PROCEDURE [dbo].[DetEmpleadosCuentasBancarias_TX_Det]

@IdEmpleado int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01133'
SET @vector_T='0GG00'

SELECT
 Det.IdDetalleEmpleadoCuentaBancaria,
 Bancos.Nombre as [Banco],
 CuentasBancarias.Cuenta as [Cuenta bancaria],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleEmpleadosCuentasBancarias Det
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=Det.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
WHERE (Det.IdEmpleado = @IdEmpleado)
ORDER BY Bancos.Nombre, CuentasBancarias.Cuenta