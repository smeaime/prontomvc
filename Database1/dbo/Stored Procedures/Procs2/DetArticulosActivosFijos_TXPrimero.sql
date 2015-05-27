







CREATE PROCEDURE [dbo].[DetArticulosActivosFijos_TXPrimero]

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='00111611111133'
Set @vector_T='00454566243800'

SELECT TOP 1
 DetAFijos.IdDetalleArticuloActivosFijos,
 DetAFijos.IdArticulo,
 DetAFijos.Fecha as [Fecha],
 Case 	When DetAFijos.TipoConcepto='A' Then 'Adquisición'
	When DetAFijos.TipoConcepto='M' Then 'Mejora'
	When DetAFijos.TipoConcepto='B' Then 'Baja'
	When DetAFijos.TipoConcepto='R' Then 'Revaluo'
	 Else Null
 End as [Tipo concepto],
 DetAFijos.Detalle as [Detalle],
 DetAFijos.Importe,
 DetAFijos.ModificacionVidaUtilImpositiva as [Mod. vida util imp.],
 DetAFijos.ModificacionVidaUtilContable as [Mod. vida util cont.],
 Revaluos.Descripcion as [Revaluo],
 Revaluos.FechaRevaluo as [Fecha rev.],
 DetAFijos.ImporteRevaluo as [Imp.Revaluo],
 DetAFijos.VidaUtilRevaluo as [Vida util revaluo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleArticulosActivosFijos DetAFijos
LEFT OUTER JOIN Revaluos ON Revaluos.IdRevaluo=DetAFijos.IdRevaluo






