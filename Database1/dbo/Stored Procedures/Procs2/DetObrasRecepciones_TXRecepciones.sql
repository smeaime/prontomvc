




CREATE PROCEDURE [dbo].[DetObrasRecepciones_TXRecepciones]

@IdObra int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111133'
Set @vector_T='03435343400'

SELECT
 DetRec.IdDetalleObraRecepcion,
 DetRec.NumeroRecepcion as [Numero],
 DetRec.FechaRecepcion as [Fecha],
 DetRec.TipoRecepcion as [Tipo],
 DetRec.Detalle as [Detalle],
 (Select Top 1 Empleados.Nombre From Empleados 
	Where Empleados.IdEmpleado=DetRec.IdRealizo) as [Realizo],
 DetRec.FechaRealizo as [Fecha realizo],
 (Select Top 1 Empleados.Nombre From Empleados 
	Where Empleados.IdEmpleado=DetRec.IdAprobo) as [Aprobo],
 DetRec.FechaAprobo as [Fecha aprobo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasRecepciones DetRec
WHERE (DetRec.IdObra = @IdObra)
ORDER by DetRec.FechaRecepcion





