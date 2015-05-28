CREATE Procedure [dbo].[DetEmpleadosSectores_E]

@IdDetalleEmpleadoSector int  

AS 

DELETE [DetalleEmpleadosSectores]
WHERE (IdDetalleEmpleadoSector=@IdDetalleEmpleadoSector)