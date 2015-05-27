
CREATE  Procedure [dbo].[Codigos_M]

@IdCodigo int ,
@Descripcion varchar(50),
@Abreviatura varchar(15)

AS

UPDATE Codigos
SET
 Descripcion=@Descripcion,
 Abreviatura=@Abreviatura
WHERE (IdCodigo=@IdCodigo)

RETURN(@IdCodigo)
