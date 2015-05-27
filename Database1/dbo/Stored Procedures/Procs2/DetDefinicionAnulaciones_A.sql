


CREATE Procedure [dbo].[DetDefinicionAnulaciones_A]
@IdDetalleDefinicionAnulacion int  output,
@IdDefinicionAnulacion int,
@IdEmpleado int,
@IdCargo int,
@IdSector int,
@Administradores varchar(2)
As 
Insert into [DetalleDefinicionAnulaciones]
(
 IdDefinicionAnulacion,
 IdEmpleado,
 IdCargo,
 IdSector,
 Administradores
)
Values
(
 @IdDefinicionAnulacion,
 @IdEmpleado,
 @IdCargo,
 @IdSector,
 @Administradores
)
Select @IdDetalleDefinicionAnulacion=@@identity
Return(@IdDetalleDefinicionAnulacion)


