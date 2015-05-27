
CREATE Procedure [dbo].[ProntoIni_TX_Todo]

@IdUsuario int = Null,
@IdProntoIniClave int = Null

AS 

SET @IdUsuario=IsNull(@IdUsuario,-1)
SET @IdProntoIniClave=IsNull(@IdProntoIniClave,-1)

SELECT 
 IsNull(ProntoIni.IdProntoIni,0) as [IdProntoIni],
 Empleados.IdEmpleado,
 Empleados.Nombre as [Usuario],
 IsNull(ProntoIni.IdProntoIniClave,0) as [IdProntoIniClave],
 IsNull(ProntoIniClaves.Clave,'') as [Clave],
 IsNull(ProntoIni.Valor,'') as [Valor]
FROM Empleados
LEFT OUTER JOIN ProntoIni ON ProntoIni.IdUsuario=Empleados.IdEmpleado
LEFT OUTER JOIN ProntoIniClaves ON ProntoIniClaves.IdProntoIniClave=ProntoIni.IdProntoIniClave
WHERE (@IdUsuario=-1 or Empleados.IdEmpleado=@IdUsuario) and 
	(@IdProntoIniClave=-1 or ProntoIni.IdProntoIniClave=@IdProntoIniClave)
ORDER BY Empleados.Nombre, Empleados.IdEmpleado, ProntoIniClaves.Clave
