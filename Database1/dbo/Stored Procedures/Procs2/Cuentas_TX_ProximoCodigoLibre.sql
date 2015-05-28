






























CREATE  Procedure [dbo].[Cuentas_TX_ProximoCodigoLibre]
AS 
DECLARE @count INT
SET @count = 1000
WHILE @count < 8999
BEGIN
   SET @count = @count + 1
   IF NOT EXISTS (Select Cuentas.IdCuenta 
			From Cuentas
			Where Cuentas.Codigo=@count)
      BREAK
END
SELECT @count as [Proximo codigo libre]






























