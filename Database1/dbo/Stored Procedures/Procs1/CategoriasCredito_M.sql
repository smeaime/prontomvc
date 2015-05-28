CREATE  Procedure [dbo].[CategoriasCredito_M]

@IdCategoriaCredito int ,
@Descripcion varchar(50),
@Codigo int,
@Importe numeric(18,2)

AS

UPDATE CategoriasCredito
SET
 Descripcion=@Descripcion,
 Codigo=@Codigo,
 Importe=@Importe
WHERE (IdCategoriaCredito=@IdCategoriaCredito)

RETURN(@IdCategoriaCredito)