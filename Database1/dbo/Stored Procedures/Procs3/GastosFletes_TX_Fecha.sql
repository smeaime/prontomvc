CREATE Procedure [dbo].[GastosFletes_TX_Fecha]

@Desde datetime,
@Hasta datetime,
@Todos int = Null

AS 

SET @Todos=IsNull(@Todos,0)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111116661133'
SET @vector_T='0593D444441100'

SELECT 
 GastosFletes.IdGastoFlete,
 GastosFletes.Fecha as [Fecha],
 GastosFletes.IdGastoFlete as [IdAux1],
 Fletes.Patente as [Patente],
 Articulos.Descripcion as [Concepto],
 GastosFletes.Detalle as [Detalle],
 GastosFletes.Gravado as [Grav.],
 GastosFletes.Importe * IsNull(GastosFletes.SumaResta,1) as [Importe],
 GastosFletes.IVa * IsNull(GastosFletes.SumaResta,1) as [Iva],
 GastosFletes.Total * IsNull(GastosFletes.SumaResta,1) as [Total],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM GastosFletes
LEFT OUTER JOIN Fletes ON Fletes.IdFlete=GastosFletes.IdFlete
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=GastosFletes.IdConcepto
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = GastosFletes.IdPresupuestoObrasNodo
LEFT OUTER JOIN Obras ON Obras.IdObra = GastosFletes.IdObra
WHERE (@Todos=-1 or GastosFletes.Fecha between @Desde and DATEADD(n,1439,@Hasta))
ORDER BY GastosFletes.Fecha, Fletes.Patente