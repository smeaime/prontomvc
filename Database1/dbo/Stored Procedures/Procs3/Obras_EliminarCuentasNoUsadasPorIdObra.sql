CREATE Procedure [dbo].[Obras_EliminarCuentasNoUsadasPorIdObra]

@IdObra int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdObra INTEGER,
			 IdCuenta INTEGER,
			 Registros1 INTEGER,
			 Registros2 INTEGER,
			 Registros3 INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Cuentas.IdObra,
  Cuentas.IdCuenta,
  (Select Count(*) From Subdiarios Where Cuentas.IdCuenta=Subdiarios.IdCuenta),
  (Select Count(*) From DetalleAsientos Where Cuentas.IdCuenta=DetalleAsientos.IdCuenta),
  0
 FROM Cuentas
 WHERE Cuentas.IdObra is not null and Cuentas.IdObra=@IdObra

UPDATE #Auxiliar1
SET Registros3=IsNull(Registros1,0)+IsNull(Registros2,0)

DELETE FROM Cuentas 
WHERE (Cuentas.IdTipoCuenta=2 or Cuentas.IdTipoCuenta=4) and  
	(Select #Auxiliar1.Registros3 From #Auxiliar1 Where Cuentas.IdCuenta=#Auxiliar1.IdCuenta) is not null and 
	(Select #Auxiliar1.Registros3 From #Auxiliar1 Where Cuentas.IdCuenta=#Auxiliar1.IdCuenta)=0

DECLARE @CuentasResiduales int
SET @CuentasResiduales=IsNull((Select Count(*) From Cuentas Where (IdTipoCuenta=2 or IdTipoCuenta=4) and IdObra is not null and IdObra=@IdObra),0)
IF @CuentasResiduales=0
	DELETE FROM Cuentas 
	WHERE IdTipoCuenta=1 and IdObra is not null and IdObra=@IdObra

DROP TABLE #Auxiliar1

SET NOCOUNT OFF
