CREATE  Procedure [dbo].[TiposCompra_M]

@IdTipoCompra int ,
@Descripcion varchar(100),
@Modalidad varchar(2)

AS

UPDATE TiposCompra
SET 
 Descripcion=@Descripcion,
 Modalidad=@Modalidad
WHERE (IdTipoCompra=@IdTipoCompra)

RETURN(@IdTipoCompra)