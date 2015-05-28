CREATE Procedure [dbo].[DetImpuestos_TXPrimero]

AS 

DECLARE @vector_X varchar(30), @vector_T varchar(30)

SET @vector_X='0011111111111133'
SET @vector_T='0055555555555500'

SELECT TOP 1
 di.IdDetalleImpuesto,
 di.IdImpuesto,
 di.Cuota as [Cuota],
 di.Año as [Año],
 di.Importe as [Importe],
 di.Importe as [Capital],
 di.Intereses1 as [Int.Fin.],
 di.Intereses2 as [Int.Resarc.],
 IsNull(di.Importe,0)+IsNull(di.Intereses1,0)+IsNull(di.Intereses2,0) as [Subtotal],
 di.FechaVencimiento1 as [Fecha Vto.1],
 di.FechaVencimiento2 as [Fecha Vto.2],
 di.FechaVencimiento3 as [Fecha Vto.3],
 Null as [Nro.OP],
 Null as [Fecha OP],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleImpuestos di