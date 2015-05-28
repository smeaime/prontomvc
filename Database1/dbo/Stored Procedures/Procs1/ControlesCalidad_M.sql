





























CREATE  Procedure [dbo].[ControlesCalidad_M]
@IdControlCalidad int ,
@Descripcion varchar(250),
@Inspeccion varchar(2),
@Abreviatura varchar(2),
@Detalle ntext
AS
Update ControlesCalidad
SET
Descripcion=@Descripcion,
Inspeccion=@Inspeccion,
Abreviatura=@Abreviatura,
Detalle=@Detalle
where (IdControlCalidad=@IdControlCalidad)
Return(@IdControlCalidad)






























