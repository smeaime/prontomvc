
CREATE Procedure [dbo].[Ubicaciones_TX_TT]

@IdUbicacion int

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
WHERE (IdUbicacion=@IdUbicacion)
