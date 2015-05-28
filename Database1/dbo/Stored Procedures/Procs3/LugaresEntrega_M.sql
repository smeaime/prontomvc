
CREATE  Procedure [dbo].[LugaresEntrega_M]

@IdLugarEntrega int ,
@Descripcion varchar(50),
@Detalle ntext

AS

UPDATE LugaresEntrega
SET
 Descripcion=@Descripcion,
 Detalle=@Detalle
WHERE (IdLugarEntrega=@IdLugarEntrega)

RETURN(@IdLugarEntrega)
