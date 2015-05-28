
CREATE Procedure [dbo].[Cuentas_TX_AsientoAperturaEjercicio]

@NumeroAsientoCierre int

AS 

DECLARE @IdAsiento int

SET @IdAsiento=IsNull((Select Top 1 IdAsiento From Asientos Where NumeroAsiento=@NumeroAsientoCierre and Substring(IsNull(Tipo,''),1,3)='CIE' Order By FechaAsiento Desc),0)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011166133'
SET @vector_T='055555900'

SELECT 
 DetAsi.IdCuenta,
 Cuentas.Codigo,
 Cuentas.Jerarquia,
 Cuentas.Descripcion as [Cuenta],
 DetAsi.Haber as [Debe],
 DetAsi.Debe as [Haber],
 IsNull((Select Top 1 IsNull(Cajas.IdMoneda,0) 
	 From Cajas
	 Where Cajas.IdCuenta=DetAsi.IdCuenta and Cajas.IdCuenta is not null),0) as [IdMonedaCaja],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleAsientos DetAsi
LEFT OUTER JOIN Asientos ON Asientos.IdAsiento = DetAsi.IdAsiento
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetAsi.IdCuenta
WHERE Asientos.IdAsiento=@IdAsiento
ORDER BY Jerarquia
