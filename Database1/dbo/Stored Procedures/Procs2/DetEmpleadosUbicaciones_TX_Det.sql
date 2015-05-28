CREATE PROCEDURE [dbo].[DetEmpleadosUbicaciones_TX_Det]

@IdEmpleado int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00133'
SET @vector_T='00500'

SELECT
 deu.IdDetalleEmpleadoUbicacion,
 deu.IdEmpleado,
 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
	IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleEmpleadosUbicaciones deu
LEFT OUTER JOIN Ubicaciones ON deu.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE (deu.IdEmpleado = @IdEmpleado)
ORDER BY [Ubicacion]