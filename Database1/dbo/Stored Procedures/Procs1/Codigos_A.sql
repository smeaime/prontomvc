
CREATE Procedure [dbo].[Codigos_A]

@IdCodigo int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)

AS 

INSERT INTO [Codigos]
(
 Descripcion,
 Abreviatura
)
VALUES
(
 @Descripcion,
 @Abreviatura
)

SELECT @IdCodigo=@@identity
RETURN(@IdCodigo)
