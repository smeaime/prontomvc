CREATE Procedure [dbo].[DetConciliaciones_A]

@IdDetalleConciliacion int output,
@IdConciliacion int,
@IdValor int,
@Conciliado varchar(2),
@Controlado varchar(2),
@ControladoNoConciliado varchar(2)

AS

INSERT INTO [DetalleConciliaciones]
(
 IdConciliacion,
 IdValor,
 Conciliado,
 Controlado,
 ControladoNoConciliado
)
VALUES
(
 @IdConciliacion,
 @IdValor,
 @Conciliado,
 @Controlado,
 @ControladoNoConciliado
)

SELECT @IdDetalleConciliacion=@@identity

RETURN(@IdDetalleConciliacion)