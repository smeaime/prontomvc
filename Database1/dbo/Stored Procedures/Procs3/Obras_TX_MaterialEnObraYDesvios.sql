
CREATE Procedure [dbo].[Obras_TX_MaterialEnObraYDesvios]

@IdObra int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdComprobante INTEGER,
			 Tipo VARCHAR(1),
			 Numero VARCHAR(13),
			 Fecha DATETIME,
			 IdArticulo INTEGER,
			 Costo NUMERIC(18,2),
			 CantidadOk NUMERIC(18,2),
			 CantidadDebo NUMERIC(18,2),
			 CantidadMeDeben NUMERIC(18,2),
			 CantidadDevuelta NUMERIC(18,2),
			 IdObraDesvio INTEGER,
			 Observaciones NTEXT
			)
INSERT INTO #Auxiliar1 
 SELECT Det.IdDetalleSalidaMateriales, 'S', 
	Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales), 
	SalidasMateriales.FechaSalidaMateriales,Det.IdArticulo,  IsNull(Det.CostoUnitario,0)*IsNull(Det.CotizacionMoneda,1), 
	Case When Det.IdObra=IsNull(SalidasMateriales.IdObra,0) Then Det.Cantidad Else Null End, 
	Case When IsNull(SalidasMateriales.IdObra,0)=@IdObra and Det.IdObra<>@IdObra Then Det.Cantidad Else Null End, 
	Case When IsNull(SalidasMateriales.IdObra,0)<>@IdObra and Det.IdObra=@IdObra Then Det.Cantidad Else Null End, 
	Null, Case When Det.IdObra<>@IdObra Then Det.IdObra Else Null End, Det.Observaciones
 FROM DetalleSalidasMateriales Det
 LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = Det.IdSalidaMateriales
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Det.IdArticulo
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and (IsNull(SalidasMateriales.IdObra,0)=@IdObra or Det.IdObra=@IdObra) and IsNull(Articulos.Activo,'SI')='SI'

INSERT INTO #Auxiliar1 
 SELECT Det.IdDetalleOtroIngresoAlmacen, 'O', 
	Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen), 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen, Det.IdArticulo, IsNull(Det.CostoUnitario,0), Null, Null, Null, Det.Cantidad, 
	Case When Det.IdObra<>@IdObra Then Det.IdObra Else Null End, Det.Observaciones
 FROM DetalleOtrosIngresosAlmacen Det
 LEFT OUTER JOIN OtrosIngresosAlmacen ON OtrosIngresosAlmacen.IdOtroIngresoAlmacen = Det.IdOtroIngresoAlmacen
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Det.IdArticulo
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and OtrosIngresosAlmacen.IdObra=@IdObra and IsNull(Articulos.Activo,'SI')='SI'

SET NOCOUNT ON

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00111116666666661133'
SET @vector_T='003542D4444444445500'

SELECT 
 #Auxiliar1.IdComprobante as [IdComprobante],
 1 as [K_Orden],
 Case When #Auxiliar1.Tipo='S' Then '1.Sal.Mat.' else '2.Otr.Ing.' End as [Tipo],
 #Auxiliar1.Numero as [Numero],
 #Auxiliar1.Fecha as [Fecha],
 Articulos.Codigo [Codigo], 
 Articulos.Descripcion [Articulo], 
 #Auxiliar1.Costo as [Costo],
 #Auxiliar1.CantidadOk as [Mat.Recibido],
 #Auxiliar1.CantidadOk*#Auxiliar1.Costo as [Precio Total],
 #Auxiliar1.CantidadDebo as [Cantidad],
 #Auxiliar1.CantidadDebo*#Auxiliar1.Costo as [Precio Total],
 #Auxiliar1.CantidadMeDeben as [Cantidad],
 #Auxiliar1.CantidadMeDeben*#Auxiliar1.Costo as [Precio Total],
 #Auxiliar1.CantidadDevuelta as [Cant.Dev.],
 #Auxiliar1.CantidadDevuelta*#Auxiliar1.Costo as [Precio Total],
-- (IsNull(#Auxiliar1.CantidadOk,0)+IsNull(#Auxiliar1.CantidadDebo,0)-IsNull(#Auxiliar1.CantidadDevuelta,0))*#Auxiliar1.Costo as [Imp.Total],
 Obras.NumeroObra as [Obra Desvio],
 #Auxiliar1.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = #Auxiliar1.IdArticulo
LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar1.IdObraDesvio

UNION ALL

SELECT 
 0 as [IdComprobante],
 2 as [K_Orden],
 Null as [Tipo],
 Null as [Numero],
 Null as [Fecha],
 Null [Codigo], 
 Null [Articulo], 
 Null as [Costo],
 Sum(IsNull(#Auxiliar1.CantidadOk,0)) as [Cant.Ok],
 Sum(IsNull(#Auxiliar1.CantidadOk,0)*IsNull(#Auxiliar1.Costo,0)) as [Imp.Ok],
 Sum(IsNull(#Auxiliar1.CantidadDebo,0)) as [Cant.Debo],
 Sum(IsNull(#Auxiliar1.CantidadDebo,0)*IsNull(#Auxiliar1.Costo,0)) as [Imp.Debo],
 Sum(IsNull(#Auxiliar1.CantidadMeDeben,0)) as [Cant.Me Deben],
 Sum(IsNull(#Auxiliar1.CantidadMeDeben,0)*IsNull(#Auxiliar1.Costo,0)) as [Imp.Me Deben],
 Sum(IsNull(#Auxiliar1.CantidadDevuelta,0)) as [Cant.Dev.],
 Sum(IsNull(#Auxiliar1.CantidadDevuelta,0)*IsNull(#Auxiliar1.Costo,0)) as [Imp.Dev.],
-- Sum((IsNull(#Auxiliar1.CantidadOk,0)+IsNull(#Auxiliar1.CantidadDebo,0)-IsNull(#Auxiliar1.CantidadDevuelta,0))*IsNull(#Auxiliar1.Costo,0)) as [Imp.Total],
 Null as [Obra Desvio],
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1

ORDER BY [K_Orden], [Articulo], [Codigo], [Tipo], [Fecha], [Numero]

DROP TABLE #Auxiliar1
