


CREATE PROCEDURE [dbo].ProduccionOrdenes_TX_ProcesosArticulosPendientes
    
AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
SET @vector_X='0111111111111133'
SET @vector_T='011D999999191900'

select  DETPROC.IdProduccionOrden ,
		CABOP.NumeroOrdenProduccion as [OP],
		ProduccionProcesos.descripcion as Proceso,
		articulos.descripcion as Articulo,
		DETPROC.idproduccionpartequecerroesteproceso as CerroProceso ,
		
		DETART.idproduccionpartequecerroesteinsumo as CerroInsumo,
		DETART.idarticulo,
		DETPROC.idproduccionproceso,
		iddetalleproduccionordenproceso,
		iddetalleproduccionorden,
		
		Colores.Descripcion as Color,
		DETART.IdColor,
		
		 ltrim(str(DETART.Cantidad-isnull(dbo.fProduccionAvanzadoMaterialPorIdDetalle(DETART.IdDetalleProduccionOrden),0),6,2)) as [Restan]
		 
		 ,isnull(detproc.orden, isnull(detficha.orden,detficha.iddetalleproduccionficha )) as orden

		
		
		 ,@Vector_T as Vector_T,		 @Vector_X as Vector_X
from DetalleProduccionOrdenProcesos DETPROC

left join DetalleProduccionOrdenes  DETART  on DETPROC.IdProduccionOrden=DETART.IdProduccionOrden and DETART.IdProduccionProceso=DETPROC.IdProduccionProceso
left JOIN Articulos ON DETART.IdArticulo = Articulos.IdArticulo
left JOIN ProduccionProcesos ON  DETPROC.IdProduccionProceso = ProduccionProcesos.IdProduccionProceso
LEFT OUTER JOIN ProduccionOrdenes CABOP ON  CABOP.IdProduccionOrden = DETPROC.IdProduccionOrden
LEFT OUTER JOIN Colores ON DETART.idColor = Colores.IdColor

LEFT OUTER JOIN dbo.ProduccionFichas CABFICHA ON cabop.IdArticuloGenerado=cabFICHA.IdArticuloAsociado  and cabop.idcolor=cabficha.idcolor and cabficha.EstaActiva='SI'
LEFT OUTER JOIN dbo.DetalleProduccionFichas DETFICHA ON cabFICHA.IdProduccionFicha=DETFICHA.idproduccionficha AND DETFICHA.IdArticulo=DETART.IdArticulo and DETART.idcolor=DETFICHA.idcolor


--LEFT OUTER JOIN Unidades ON ProduccionPartes.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Articulos Maquinas ON ProduccionPartes.IdMaquina = Articulos.IdArticulo
where 
	DETPROC.idproduccionpartequecerroesteproceso is null --el proceso no esta terminado
	and DETART.idproduccionpartequecerroesteinsumo is null --el articulo asociado al proceso no esta terminado
	and (CABOP.Cerro is null and CABOP.anulada is null and CABOP.aprobo is not null)

	--and (DETART.idarticulo is null OR DETART.Cantidad-isnull(dbo.fProduccionAvanzadoMaterialPorIdDetalle(CABOP.IdProduccionOrden,DETART.IdArticulo),0) > 0) --no es consumo o ya se llegó al total

order by CABOP.idproduccionorden, DETPROC.Iddetalleproduccionordenproceso,DETART.iddetalleproduccionorden
	
