CREATE Procedure [dbo].[Cargos_A]

@IdCargo int  output,
@Descripcion varchar(50)

AS 

INSERT INTO [Cargos]
(
 Descripcion
)
VALUES
(
 @Descripcion
)

SELECT @IdCargo=@@identity

RETURN(@IdCargo)