
CREATE Procedure [dbo].[Cuentas_TXCod]
@Codigo varchar(10)
AS 
Select
Cuentas.IdCuenta,
Cuentas.Codigo,
Cuentas.Descripcion
FROM Cuentas 
WHERE (Cuentas.Codigo=@Codigo)
