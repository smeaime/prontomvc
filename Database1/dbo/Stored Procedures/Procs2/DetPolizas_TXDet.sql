CREATE Procedure [dbo].[DetPolizas_TXDet]

@IdPoliza int

AS 

DECLARE @vector_X varchar(30), @vector_T varchar(30), @Tipo varchar(10)

SET @Tipo=IsNull((Select Top 1 Tipo From Polizas Where IdPoliza=@IdPoliza),'')

SET @vector_X='0011111133'
IF @Tipo='OBRAS'
	SET @vector_T='0009999500'
ELSE
	SET @vector_T='00E12E1500'

SELECT
 DetallePolizas.IdDetallePoliza,
 DetallePolizas.IdPoliza,
 IsNull(Articulos.Descripcion,O1.Descripcion) as [Bien asegurado],
 Articulos.Codigo as [Nro.OP],
 Articulos.NumeroPatente as [Patente],
 O2.Descripcion as [Obra actual],
 DetallePolizas.EnUsoPor as [En uso por],
 DetallePolizas.ImporteAsegurado as [Importe asegurado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePolizas
LEFT OUTER JOIN Polizas ON Polizas.IdPoliza=DetallePolizas.IdPoliza
LEFT OUTER JOIN Obras O1 ON O1.IdObra=DetallePolizas.IdBienAsegurado and @Tipo='OBRAS'
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetallePolizas.IdBienAsegurado and @Tipo='EQUIPOS'
LEFT OUTER JOIN Obras O2 ON O2.IdObra=DetallePolizas.IdObraActual and @Tipo='EQUIPOS'
WHERE (DetallePolizas.IdPoliza = @IdPoliza)
ORDER BY [Bien asegurado]