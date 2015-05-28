
CREATE PROCEDURE [dbo].[DetConciliacionesNoContables_TXConc]

@IdConciliacion int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001661111133'
SET @vector_T='002235599900'

SELECT
 DetConc.IdDetalleConciliacionNoContable,
 DetConc.IdConciliacion,
 DetConc.Detalle,
 DetConc.Ingresos as [Ingresos],
 DetConc.Egresos as [Egresos],
 DetConc.FechaIngreso as [Fec.Ing.],
 DetConc.FechaCaducidad as [Fec.Caduco],
 DetConc.FechaRegistroContable as [Fec.Reg.Cont.],
 DetConc.Ingresos as [IngresosParaCalculo],
 DetConc.Egresos as [EgresosParaCalculo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleConciliacionesNoContables DetConc
WHERE (DetConc.IdConciliacion = @IdConciliacion)
