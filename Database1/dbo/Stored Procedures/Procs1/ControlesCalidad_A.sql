

CREATE Procedure [dbo].[ControlesCalidad_A]
@IdControlCalidad int  output,
@Descripcion varchar(250),
@Inspeccion varchar(2),
@Abreviatura varchar(2),
@Detalle ntext
AS 
INSERT INTO [ControlesCalidad]
(
 Descripcion,
 Inspeccion,
 Abreviatura,
 Detalle
)
VALUES 
(
 @Descripcion,
 @Inspeccion,
 @Abreviatura,
 @Detalle
)
SELECT @IdControlCalidad=@@identity
RETURN(@IdControlCalidad)

