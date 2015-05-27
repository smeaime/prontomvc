
CREATE Procedure [dbo].[FletesPartesDiarios_A]

@IdFleteParteDiario int  output,
@IdFlete int,
@Fecha datetime,
@Cantidad numeric(18,2)

AS 

INSERT INTO [FletesPartesDiarios]
(
 IdFlete,
 Fecha,
 Cantidad
)
VALUES
(
 @IdFlete,
 @Fecha,
 @Cantidad
)

SELECT @IdFleteParteDiario=@@identity
RETURN(@IdFleteParteDiario)
