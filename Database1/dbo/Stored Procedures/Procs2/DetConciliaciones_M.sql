CREATE Procedure [dbo].[DetConciliaciones_M]

@IdDetalleConciliacion int,
@IdConciliacion int,
@IdValor int,
@Conciliado varchar(2),
@Controlado varchar(2),
@ControladoNoConciliado varchar(2)

AS

UPDATE [DetalleConciliaciones]
SET 
 IdConciliacion=@IdConciliacion,
 IdValor=@IdValor,
 Conciliado=@Conciliado,
 Controlado=@Controlado,
 ControladoNoConciliado=@ControladoNoConciliado
WHERE (IdDetalleConciliacion=@IdDetalleConciliacion)

RETURN(@IdDetalleConciliacion)