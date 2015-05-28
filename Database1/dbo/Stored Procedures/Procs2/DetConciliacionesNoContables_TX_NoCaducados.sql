
CREATE PROCEDURE [dbo].[DetConciliacionesNoContables_TX_NoCaducados]

@IdCuentaBancaria int,
@FechaFinal datetime

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001661111133'
SET @vector_T='001225559900'

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
LEFT OUTER JOIN Conciliaciones ON Conciliaciones.IdConciliacion=DetConc.IdConciliacion
WHERE Conciliaciones.IdCuentaBancaria = @IdCuentaBancaria and 
	 DetConc.FechaIngreso<=@FechaFinal and 
	 (DetConc.FechaCaducidad is null or DetConc.FechaCaducidad>@FechaFinal)
