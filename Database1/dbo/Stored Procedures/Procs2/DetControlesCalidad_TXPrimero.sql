

CREATE PROCEDURE [dbo].[DetControlesCalidad_TXPrimero]

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0011111133'
Set @vector_T='0044444000'

SELECT TOP 1
 DetCal.IdDetalleControlCalidad,
 DetCal.IdRecepcion,
 DetCal.fecha as [Fecha],
 DetCal.Cantidad as [Cantidad],
 DetCal.CantidadRechazada as [Cant.rech.],
 MotivosRechazo.Descripcion as [Motivo],
 DetCal.Trasabilidad,
 DetCal.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleControlesCalidad DetCal
LEFT OUTER JOIN MotivosRechazo ON DetCal.IdMotivoRechazo=MotivosRechazo.IdMotivoRechazo

