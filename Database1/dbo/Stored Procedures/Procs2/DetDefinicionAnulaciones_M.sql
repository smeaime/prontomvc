


CREATE Procedure [dbo].[DetDefinicionAnulaciones_M]
@IdDetalleDefinicionAnulacion int,
@IdDefinicionAnulacion int,
@IdEmpleado int,
@IdCargo int,
@IdSector int,
@Administradores varchar(2)
As
Update [DetalleDefinicionAnulaciones]
Set 
 IdDefinicionAnulacion=@IdDefinicionAnulacion,
 IdEmpleado=@IdEmpleado,
 IdCargo=@IdCargo,
 IdSector=@IdSector,
 Administradores=@Administradores
Where (IdDetalleDefinicionAnulacion=@IdDetalleDefinicionAnulacion)
Return(@IdDetalleDefinicionAnulacion)


