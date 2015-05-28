CREATE Procedure [dbo].[DetEmpleadosSectores_A]

@IdDetalleEmpleadoSector int  output,
@IdEmpleado int,
@FechaCambio Datetime,
@IdSectorNuevo int

AS 

INSERT INTO [DetalleEmpleadosSectores]
(
 IdEmpleado,
 FechaCambio,
 IdSectorNuevo
)
VALUES
(
 @IdEmpleado,
 @FechaCambio,
 @IdSectorNuevo
)

SELECT @IdDetalleEmpleadoSector=@@identity

RETURN(@IdDetalleEmpleadoSector)