CREATE Procedure [dbo].[Tipos_A]

@IdTipo int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15),
@Codigo int,
@Grupo int

AS 

INSERT INTO [Tipos]
(
 Descripcion,
 Abreviatura,
 Codigo,
 Grupo
)
VALUES
(
 @Descripcion,
 @Abreviatura,
 @Codigo,
 @Grupo
)
SELECT @IdTipo=@@identity

RETURN(@IdTipo)