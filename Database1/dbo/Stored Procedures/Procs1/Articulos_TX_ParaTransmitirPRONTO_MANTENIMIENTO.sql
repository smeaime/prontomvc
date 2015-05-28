




CREATE Procedure [dbo].[Articulos_TX_ParaTransmitirPRONTO_MANTENIMIENTO]
AS 
SELECT 
 IdArticulo,
 Codigo,
 NumeroInventario,
 Descripcion,
 IdCuantificacion,
 IdUnidad,
 AlicuotaIVA,
 CostoPPP,
 CostoPPPDolar,
 CostoReposicion,
 CostoReposicionDolar,
 FechaCompra,
 EsConsumible,
 Alquilado
FROM Articulos
WHERE IsNull(ParaPRONTO_MANTENIMIENTO,'NO')='SI' and Codigo is not null




