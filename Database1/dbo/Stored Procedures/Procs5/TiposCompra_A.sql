CREATE Procedure [dbo].[TiposCompra_A]

@IdTipoCompra int  output,
@Descripcion varchar(100),
@Modalidad varchar(2)

AS

INSERT INTO [TiposCompra]
(
 Descripcion,
 Modalidad
)
VALUES
(
 @Descripcion,
 @Modalidad
)

SELECT @IdTipoCompra=@@identity

RETURN(@IdTipoCompra)