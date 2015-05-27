
CREATE Procedure [dbo].[Ubicaciones_TT]

AS 

SELECT 
 Ubicaciones.IdUbicacion,
 Ubicaciones.Descripcion as [Ubicacion],
 Ubicaciones.IdUbicacion as [Codigo],
 Depositos.Descripcion as [Deposito],
 Ubicaciones.Estanteria,
 Ubicaciones.Modulo,
 Ubicaciones.Gabeta
FROM Ubicaciones
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito=Ubicaciones.IdDeposito
ORDER by  Ubicaciones.Descripcion
