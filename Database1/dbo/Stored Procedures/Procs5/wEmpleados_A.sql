
CREATE Procedure [dbo].[wEmpleados_A]

@IdEmpleado int  output,
@Legajo int,
@Nombre varchar(50)

AS

IF IsNull(@IdEmpleado,0)<=0
    BEGIN
	INSERT INTO Empleados
	(
	 Legajo,
	 Nombre
	)
	VALUES
	(
	 @Legajo,
	 @Nombre
	)
	
	SELECT @IdEmpleado=@@identity
    END
ELSE
    BEGIN
	UPDATE Empleados
	SET 
	 Legajo=@Legajo,
	 Nombre=@Nombre
	WHERE (IdEmpleado=@IdEmpleado)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdEmpleado

