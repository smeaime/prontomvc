
create procedure ProduccionParte_TX_ArticulosPorOrdenPorProcesoParaCombo
@IdProduccionOrden int,
@IdProceso int,
@IdArticulo int=0,
@IdUbicacion int=0


AS 

if @idUbicacion=0 
begin	
	select @idUbicacion=IdUbicacion from produccionprocesos where idProduccionProceso=@idProceso
end

--print @idUbicacion

SELECT 
 --Articulos.IdArticulo,
 Stock.IdStock
	,Articulos.Descripcion + ' Restan: ' 
	+ ltrim(str(Det.Cantidad-isnull(dbo.fProduccionAvanzadoMaterial(@IdProduccionOrden,Det.IdArticulo,det.idcolor),0),6,2)) 
	+'   Stock: ' + ltrim(isnull(str(Stock.IdStock),'0')) COLLATE DATABASE_DEFAULT 
	+'   Partida: ' + ltrim(Stock.Partida) --ltrim(isnull(str(Stock.Partida),'-')) --esta linea tiene problemas, no se si de collation o qué 
	+' '+ltrim(isnull(Ubicaciones.Descripcion,''))  COLLATE DATABASE_DEFAULT 
--	+' '+ltrim(isnull(str(Ubicaciones.Descripcion),''))  COLLATE DATABASE_DEFAULT  --esta linea tambien conflictiva
		as [Titulo]


,Stock.IdArticulo
,Stock.Partida
,Stock.IdUbicacion
,Colores.Descripcion as color
,DetFicha.Tolerancia
,Det.Cantidad as TotalEsperado
, ltrim(str(Det.Cantidad-isnull(dbo.fProduccionAvanzadoMaterial(@IdProduccionOrden,Det.IdArticulo,det.idcolor),0),6,2)) as [Restan]
, ltrim(isnull(str(Stock.IdStock),'0')) as [Stock]
, ltrim(Stock.Partida) as Partida
--, ltrim(isnull(str(Ubicaciones.Descripcion),'')) as Ubicacion
,ltrim(isnull(Ubicaciones.Descripcion,'')) as Ubicacion

FROM Stock 
LEFT OUTER JOIN Ubicaciones ON Ubicaciones.IdUbicacion = Stock.IdUbicacion
RIGHT OUTER JOIN DetalleProduccionOrdenes Det ON Stock.IdArticulo = Det.IdArticulo
left JOIN DetalleProduccionFichas DetFicha ON Stock.IdArticulo = DetFicha.IdArticulo 
left join ProduccionFichas CabFicha on CabFicha.idProduccionFicha=DetFicha.idProduccionFicha
left join ProduccionOrdenes CabOP on Det.idProduccionOrden=CabOP.idProduccionOrden
left join colores  ON Det.IdColor = colores.IdColor
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
WHERE Det.IdProduccionOrden=@IdProduccionOrden 
and (Det.IdProduccionProceso=@IdProceso or Det.IdProduccionProceso is null)
and not Stock.idStock is null
and cabficha.idArticuloAsociado=CabOP.idArticuloGenerado
and (stock.Idubicacion=@IdUbicacion or @IdUbicacion=0 or @IdUbicacion is null or stock.idUbicacion is null) --  Parte de Producción/Pesaje: sólo deberé poder ver el stock por Partida disponible para la “ubicación” correspondiente a ese Proceso.
and (stock.IdArticulo=@IdArticulo or @IdArticulo=0) 
--and (stock.partida=det.partida or det.partida is null) --   Parte de Producción/Pesaje:  cuando en  la OP al artículo se le asoció la partida de origen, no debe permitir ver otra.

--and isnull(dbo.fProduccionAvanzadoMaterial(@IdProduccionOrden,Det.IdArticulo),0)<Det.Cantidad
ORDER by Det.IdProduccionProceso

