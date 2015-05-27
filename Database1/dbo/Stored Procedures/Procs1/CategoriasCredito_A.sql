CREATE Procedure [dbo].[CategoriasCredito_A]

@IdCategoriaCredito int  output,
@Descripcion varchar(50),
@Codigo int,
@Importe numeric(18,2)

AS 

INSERT INTO [CategoriasCredito]
(
 Descripcion,
 Codigo,
 Importe
)
VALUES
(
 @Descripcion,
 @Codigo,
 @Importe
)

SELECT @IdCategoriaCredito=@@identity

RETURN(@IdCategoriaCredito)