
CREATE Procedure [dbo].[wDetProveedoresContactos_A]

@IdDetalleProveedor int,
@IdProveedor int,
@Contacto varchar(50),
@Puesto varchar(50),
@Telefono varchar(50),
@Email varchar(50)

AS

IF IsNull(@IdDetalleProveedor,0)<=0
    BEGIN
	INSERT INTO DetalleProveedores
	(
	 IdProveedor,
	 Contacto,
	 Puesto,
	 Telefono,
	 Email
	)
	VALUES
	(
	 @IdProveedor,
	 @Contacto,
	 @Puesto,
	 @Telefono,
	 @Email
	)
	
	SELECT @IdDetalleProveedor=@@identity
    END
ELSE
    BEGIN
	UPDATE DetalleProveedores
	SET 
	 IdProveedor=@IdProveedor,
	 Contacto=@Contacto,
	 Puesto=@Puesto,
	 Telefono=@Telefono,
	 Email=@Email
	WHERE (IdDetalleProveedor=@IdDetalleProveedor)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdDetalleProveedor

