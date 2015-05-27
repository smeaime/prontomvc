





CREATE Procedure [dbo].[PosicionesImportacion_TT]

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111133'
set @vector_T='085055500'

SELECT 
 IdPosicionImportacion,
 CodigoPosicion as [Codigo],
 PosicionesImportacion.Descripcion,
 Derechos as [% Der.],
 GastosEstadisticas as [% Gs.Est.],
 OtrosGastos1 as [% Otr.Gs.1],
 OtrosGastos2 as [% Otr.Gs.2],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PosicionesImportacion 
ORDER BY PosicionesImportacion.Descripcion





