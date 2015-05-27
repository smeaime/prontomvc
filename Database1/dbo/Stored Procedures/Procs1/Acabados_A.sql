CREATE Procedure [dbo].[Acabados_A]

@IdAcabado int  output,
@Descripcion varchar(50),
@Abreviatura varchar(15)

AS 

INSERT INTO [Acabados]
(
 Descripcion,
 Abreviatura
)
VALUES
(
 @Descripcion,
 @Abreviatura
)

SELECT @IdAcabado=@@identity

RETURN(@IdAcabado)