CREATE  Procedure [dbo].[PresupuestoObrasRedeterminaciones_TX_TT]

@IdPresupuestoObraRedeterminacion int

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111133'
SET @vector_T='0199D118300'

SELECT 
 PresupuestoObrasRedeterminaciones.IdPresupuestoObraRedeterminacion,
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 PresupuestoObrasRedeterminaciones.IdPresupuestoObraRedeterminacion as [IdAux],
 PresupuestoObrasRedeterminaciones.IdObra as [IdAux1],
 IsNull(p1.Item+' ','') + IsNull(p2.Descripcion+' - ', '') + IsNull(p1.Descripcion, Obras.Descripcion) as [Etapa padre], 
 PresupuestoObrasRedeterminaciones.Mes as [Mes],
 PresupuestoObrasRedeterminaciones.Año as [Año],
 PresupuestoObrasRedeterminaciones.NumeroCertificado as [Numero de certificado],
 PresupuestoObrasRedeterminaciones.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PresupuestoObrasRedeterminaciones
LEFT OUTER JOIN Obras ON Obras.IdObra = PresupuestoObrasRedeterminaciones.IdObra
LEFT OUTER JOIN PresupuestoObrasNodos p1 ON p1.IdPresupuestoObrasNodo=PresupuestoObrasRedeterminaciones.IdPresupuestoObrasNodo
LEFT OUTER JOIN PresupuestoObrasNodos p2 ON p2.IdPresupuestoObrasNodo=p1.IdNodoPadre
WHERE (PresupuestoObrasRedeterminaciones.IdPresupuestoObraRedeterminacion=@IdPresupuestoObraRedeterminacion)