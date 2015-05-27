
CREATE  Procedure [dbo].[PlazosEntrega_M]

@IdPlazoEntrega int ,
@Descripcion varchar(50),
@Detalle ntext

AS

UPDATE PlazosEntrega
SET
 Descripcion=@Descripcion,
 Detalle=@Detalle
WHERE (IdPlazoEntrega=@IdPlazoEntrega)

RETURN(@IdPlazoEntrega)
