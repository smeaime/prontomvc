





CREATE PROCEDURE [dbo].[CostosImportacion_TXCos]

@IdArticulo int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0011111111111111111111133'
Set @vector_T='0041471111115111111111100'

SELECT
 IdCostoImportacion,
 Cs.IdArticulo,
 Articulos.Codigo as [Codigo impor.],
 Articulos.Descripcion as [Articulo],
 FechaCostoImportacion as [Fecha],
 PosicionesImportacion.CodigoPosicion as [Cod.Posicion],
 PosicionesImportacion.Descripcion as [Posicion],
 Cs.PrecioCF as [Pr.C&F],
 Cs.PorcGastosDespacho as [% Desp.],
 Cs.TotalGastosDespacho as [Gs.Desp.],
 Cs.PorcTotalGastos as [% Gastos],
 Cs.TotalGastos as [Gastos],
 Cs.PrecioTotal as [Pr.Total],
 Cs.Derechos as [% Der.],
 Cs.GastosEstadisticas as [% Gs.Est.],
 Cs.OtrosGastos1 as [% Otros 1],
 Cs.OtrosGastos2 as [% Otros 2],
 Cs.PrecioFOB as [Pr.Com.],
 (Select Monedas.Nombre
	From Monedas
	Where Monedas.IdMoneda=Cs.IdMoneda1) as  [Moneda1],
 FleteMaritimo as [Fl.Mar.],
 (Select Monedas.Nombre
	From Monedas
	Where Monedas.IdMoneda=Cs.IdMoneda2) as  [Moneda2],
 OtrosFletes as [Otr.Fl.],
 (Select Monedas.Nombre
	From Monedas
	Where Monedas.IdMoneda=Cs.IdMoneda3) as  [Moneda3],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CostosImportacion Cs
LEFT OUTER JOIN Articulos ON Cs.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN PosicionesImportacion ON Cs.IdPosicionImportacion = PosicionesImportacion.IdPosicionImportacion
WHERE (Cs.IdArticulo = @IdArticulo)
ORDER by Cs.FechaCostoImportacion





