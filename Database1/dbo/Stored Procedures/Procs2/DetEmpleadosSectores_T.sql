CREATE Procedure [dbo].[DetEmpleadosSectores_T]

@IdDetalleEmpleadoSector int

AS 

SELECT *
FROM [DetalleEmpleadosSectores]
WHERE (IdDetalleEmpleadoSector=@IdDetalleEmpleadoSector)