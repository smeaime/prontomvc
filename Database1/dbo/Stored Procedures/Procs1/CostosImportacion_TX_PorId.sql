





CREATE Procedure [dbo].[CostosImportacion_TX_PorId]

@IdCostoImportacion int

AS 

SELECT
 IdCostoImportacion,
 Cs.IdArticulo,
 Articulos.Codigo as [Codigo impor.],
 Articulos.Descripcion as [Articulo],
 FechaCostoImportacion as [Fecha],
 PosicionesImportacion.CodigoPosicion,
 PosicionesImportacion.Descripcion as [Posicion],
 Cs.PrecioCF,
 Cs.PorcGastosDespacho,
 Cs.TotalGastosDespacho,
 Cs.PorcTotalGastos,
 Cs.TotalGastos,
 Cs.PrecioTotal,
 Cs.Derechos,
 Cs.GastosEstadisticas,
 Cs.OtrosGastos1,
 Cs.OtrosGastos2,
 Cs.PrecioFOB,
 (SELECT Monedas.Nombre
	FROM Monedas
	WHERE Monedas.IdMoneda=Cs.IdMoneda1) as  [Moneda1],
 FleteMaritimo,
 (SELECT Monedas.Nombre
	FROM Monedas
	WHERE Monedas.IdMoneda=Cs.IdMoneda2) as  [Moneda2],
 OtrosFletes,
 (SELECT Monedas.Nombre
	FROM Monedas
	WHERE Monedas.IdMoneda=Cs.IdMoneda3) as  [Moneda3]
FROM CostosImportacion Cs
LEFT OUTER JOIN Articulos ON Cs.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN PosicionesImportacion ON Cs.IdPosicionImportacion = PosicionesImportacion.IdPosicionImportacion
WHERE (IdCostoImportacion=@IdCostoImportacion)





