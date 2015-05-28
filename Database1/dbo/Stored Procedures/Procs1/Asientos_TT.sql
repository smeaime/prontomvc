
CREATE  Procedure [dbo].[Asientos_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111666111133'
SET @vector_T='05951913554151500'

SELECT 
 Asientos.IdAsiento, 
 Asientos.NumeroAsiento as [Numero asiento], 
 Asientos.IdAsiento as [IdAsi], 
 Asientos.FechaAsiento as [Fecha asiento],
 Asientos.Tipo as [Tipo], 
 Case When Asientos.IdCuentaSubdiario is not null Then Titulos.Titulo Else null End as [Subdiario],
 Case When Asientos.AsientoApertura='NO' Then Null Else Asientos.AsientoApertura End as [Apertura], 
 Case When Asientos.IdCuentaSubdiario is not null Then Titulos.Titulo Else Asientos.Concepto End as [Concepto], 
 (Select Sum(IsNull(DetAsi.Debe,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento) as [Total debe],
 (Select Sum(IsNull(DetAsi.Haber,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento) as [Total haber],
 (IsNull((Select Sum(IsNull(DetAsi.Debe,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento),0) - 
  IsNull((Select Sum(IsNull(DetAsi.Haber,0)) From DetalleAsientos DetAsi Where DetAsi.IdAsiento=Asientos.IdAsiento),0)) as [Diferencia],
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Asientos.IdIngreso) as [Ingreso],
 Asientos.FechaIngreso as [Fecha ingreso],
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Asientos.IdModifico) as [Modifico],
 Asientos.FechaUltimaModificacion as [Fecha ult.mod.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Asientos 
LEFT OUTER JOIN Titulos ON Asientos.IdCuentaSubdiario=Titulos.IdTitulo
ORDER BY Asientos.FechaAsiento,Asientos.NumeroAsiento

