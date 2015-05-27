CREATE Procedure [dbo].[Requerimientos_RegistrarImpresion]

@IdRequerimiento int,
@Marca varchar(2),
@DetalleImputacion varchar(50) = Null,
@Detalle varchar(50) = Null,
@Observaciones varchar(4000) = Null

AS

SET @DetalleImputacion=IsNull(@DetalleImputacion,'')
SET @Detalle=IsNull(@Detalle,'')
SET @Observaciones=IsNull(@Observaciones,'')

IF @Marca<>''
	UPDATE Requerimientos
	SET Impresa=@Marca
	WHERE (IdRequerimiento=@IdRequerimiento)

IF @DetalleImputacion<>''
	UPDATE Requerimientos
	SET DetalleImputacion=@DetalleImputacion
	WHERE (IdRequerimiento=@IdRequerimiento)

IF @Detalle<>''
	UPDATE Requerimientos
	SET Detalle=@Detalle
	WHERE (IdRequerimiento=@IdRequerimiento)

IF @Observaciones<>''
	UPDATE Requerimientos
	SET Observaciones=@Observaciones
	WHERE (IdRequerimiento=@IdRequerimiento)

RETURN(@IdRequerimiento)