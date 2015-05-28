
CREATE Procedure [dbo].[Clausulas_A]

@IdClausula int  output,
@Descripcion varchar(200),
@Orden int

AS 

INSERT INTO [Clausulas]
(
 Descripcion,
 Orden
)
VALUES
(
 @Descripcion,
 @Orden
)

SELECT @IdClausula=@@identity
RETURN(@IdClausula)
