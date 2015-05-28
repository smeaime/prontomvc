
CREATE Procedure [dbo].[wRubros_A]

@IdRubro int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@IdCuenta int,
@IdCuentaCompras int

AS

IF IsNull(@IdRubro,0)<=0
    BEGIN
	INSERT INTO Rubros
	(
	 Descripcion,
	 Abreviatura,
	 IdCuenta,
	 IdCuentaCompras
	)
	VALUES
	(
	 @Descripcion,
	 @Abreviatura,
	 @IdCuenta,
	 @IdCuentaCompras
	)
	
	SELECT @IdRubro=@@identity
    END
ELSE
    BEGIN
	UPDATE Rubros
	SET 
	 Descripcion=@Descripcion,
	 Abreviatura=@Abreviatura,
	 IdCuenta=@IdCuenta,
	 IdCuentaCompras=@IdCuentaCompras
	WHERE (IdRubro=@IdRubro)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdRubro

