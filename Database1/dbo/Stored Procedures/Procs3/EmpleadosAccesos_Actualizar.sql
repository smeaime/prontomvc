CREATE Procedure [dbo].[EmpleadosAccesos_Actualizar]

@IdEmpleadoAcceso int output,
@IdEmpleado int,
@Nodo varchar(50),
@Acceso bit,
@Nivel int

AS

IF @Acceso=1 and @Nivel=0
	Delete From EmpleadosAccesos
	Where IdEmpleadoAcceso=@IdEmpleadoAcceso
ELSE
   Begin
	If @IdEmpleadoAcceso=-1
	   Begin
		Insert into EmpleadosAccesos
		(IdEmpleado, Nodo, Acceso, Nivel)
		Values
		(@IdEmpleado, @Nodo, @Acceso, @Nivel)
		Select @IdEmpleadoAcceso=@@identity
	  End
	Else
		Update EmpleadosAccesos
		Set 
		 IdEmpleado=@IdEmpleado,
		 Nodo=@Nodo,
		 Acceso=@Acceso,
		 Nivel=@Nivel
		Where (IdEmpleadoAcceso=@IdEmpleadoAcceso)
   End

RETURN(@IdEmpleadoAcceso)