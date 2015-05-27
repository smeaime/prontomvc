CREATE  Procedure [dbo].[Pedidos_TX_CambiosCostos]

@NumeroPedido int, 
@NumeroItemPedido int,
@PedidoExterior varchar(2) = Null

AS 

SET NOCOUNT ON

SET @PedidoExterior=IsNull(@PedidoExterior,'NO')

DECLARE @IdPedido int, @IdDetallePedido int, @IdDetalleRequerimiento int, @IdRequerimiento int, @IdObra int, @Anulado varchar(2)

SET @IdPedido=IsNull((Select Top 1 IdPedido From Pedidos Where NumeroPedido=@NumeroPedido and IsNull(PedidoExterior,'NO')=@PedidoExterior),0)
SET @Anulado=IsNull((Select Top 1 Cumplido From Pedidos Where NumeroPedido=@NumeroPedido),'')
SET @IdDetallePedido=IsNull((Select Top 1 IdDetallePedido From DetallePedidos Where IdPedido=@IdPedido and NumeroItem=@NumeroItemPedido),0)
SET @IdDetalleRequerimiento=IsNull((Select Top 1 IdDetalleRequerimiento From DetallePedidos Where IdDetallePedido=@IdDetallePedido),0)
SET @IdRequerimiento=IsNull((Select Top 1 IdRequerimiento From DetalleRequerimientos Where IdDetalleRequerimiento=@IdDetalleRequerimiento),0)
SET @IdObra=IsNull((Select Top 1 IdObra From Requerimientos Where IdRequerimiento=@IdRequerimiento),0)

CREATE TABLE #Auxiliar1 
			(
			 Orden INTEGER,
			 IdDetallePedido INTEGER,
			 IdDetalleRecepcion INTEGER,
			 IdDetalleValeSalida INTEGER,
			 IdDetalleSalidaMateriales INTEGER
			)
IF @Anulado<>'AN'
    BEGIN
	INSERT INTO #Auxiliar1 
	(Orden, IdDetallePedido) VALUES (1, @IdDetallePedido)
	
	INSERT INTO #Auxiliar1 
	 SELECT 2, Null, dr.IdDetalleRecepcion, Null, Null
	 FROM DetalleRecepciones dr 
	 LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = dr.IdRecepcion
	 WHERE IsNull(Recepciones.Anulada,'')<>'SI' and dr.IdDetallePedido=@IdDetallePedido
	
	INSERT INTO #Auxiliar1 
	 SELECT 3, Null, Null, dvs.IdDetalleValeSalida, Null 
	 FROM DetalleValesSalida dvs 
	 LEFT OUTER JOIN ValesSalida ON ValesSalida.IdValeSalida = dvs.IdValeSalida
	 WHERE IsNull(dvs.Estado,'')<>'AN' and IsNull(ValesSalida.Cumplido,'')<>'AN' and dvs.IdDetalleRequerimiento=@IdDetalleRequerimiento
	
	INSERT INTO #Auxiliar1 
	 SELECT 4, Null, Null, Null ,dsm.IdDetalleSalidaMateriales 
	 FROM DetalleSalidasMateriales dsm 
	 LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
	 WHERE IsNull(SalidasMateriales.Anulada,'')<>'SI' and 
			dsm.IdDetalleValeSalida In (Select A1.IdDetalleValeSalida From #Auxiliar1 A1 Where A1.IdDetalleValeSalida is not null)
	
	INSERT INTO #Auxiliar1 
	 SELECT 5, Null, dr.IdDetalleRecepcion, Null, Null
	 FROM DetalleRecepciones dr 
	 LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = dr.IdRecepcion
	 WHERE IsNull(Recepciones.Anulada,'')<>'SI' and dr.IdDetalleSalidaMateriales In (Select A1.IdDetalleSalidaMateriales From #Auxiliar1 A1 Where A1.IdDetalleSalidaMateriales is not null)
	
	INSERT INTO #Auxiliar1 
	 SELECT 6, Null, Null, Null ,dsm.IdDetalleSalidaMateriales 
	 FROM DetalleSalidasMateriales dsm 
	 LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = dsm.IdSalidaMateriales
	 WHERE IsNull(SalidasMateriales.Anulada,'')<>'SI' and 
			dsm.IdDetalleRecepcion In (Select A1.IdDetalleRecepcion From #Auxiliar1 A1 Where A1.IdDetalleRecepcion is not null)
    END

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111133'
SET @vector_T='0499999D422E330004500'

SELECT 
 #Auxiliar1.Orden as [Orden], 
 Case When #Auxiliar1.IdDetallePedido is not null Then 'Pedido'
	When #Auxiliar1.IdDetalleRecepcion is not null Then 'Recepcion'
	When #Auxiliar1.IdDetalleValeSalida is not null Then 'Vale Salida'
	When #Auxiliar1.IdDetalleSalidaMateriales is not null Then 'Salida Material'
	Else Null 
 End as [Tipo],
 #Auxiliar1.IdDetallePedido as [IdDetallePedido], 
 #Auxiliar1.IdDetalleRecepcion as [IdDetalleRecepcion], 
 #Auxiliar1.IdDetalleValeSalida as [IdDetalleValeSalida], 
 #Auxiliar1.IdDetalleSalidaMateriales as [IdDetalleSalidaMateriales], 
 M1.IdMoneda as [IdMoneda],
 Case When #Auxiliar1.IdDetallePedido is not null 
		Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
	When #Auxiliar1.IdDetalleRecepcion is not null 
		Then Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+IsNull(' / '+Convert(varchar,Recepciones.SubNumero),'')
	When #Auxiliar1.IdDetalleValeSalida is not null 
		Then Substring('00000000',1,8-Len(Convert(varchar,ValesSalida.NumeroValeSalida)))+Convert(varchar,ValesSalida.NumeroValeSalida)
	When #Auxiliar1.IdDetalleSalidaMateriales is not null 
		Then Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)
	Else Null 
 End as [Numero],
 IsNull(Pedidos.FechaPedido,IsNull(Recepciones.FechaRecepcion,IsNull(ValesSalida.FechaValeSalida,SalidasMateriales.FechaSalidaMateriales))) as [Fecha],
 Obras.NumeroObra as [Obra],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Material],
 Case When #Auxiliar1.IdDetallePedido is not null Then DetallePedidos.CostoOriginal
	When #Auxiliar1.IdDetalleRecepcion is not null Then DetalleRecepciones.CostoOriginal
	When #Auxiliar1.IdDetalleSalidaMateriales is not null Then DetalleSalidasMateriales.CostoOriginal
	Else Null 
 End as [Precio Orig.],
 M2.Abreviatura as [Mon.Orig.],
 Case When #Auxiliar1.IdDetallePedido is not null Then DetallePedidos.Precio
	When #Auxiliar1.IdDetalleRecepcion is not null Then DetalleRecepciones.CostoUnitario
	When #Auxiliar1.IdDetalleSalidaMateriales is not null Then DetalleSalidasMateriales.CostoUnitario
	Else Null 
 End as [Precio Unit.],
 M1.Abreviatura as [Mon.],
 Empleados.Nombre as [Usuario ult. modif.],
 IsNull(DetallePedidos.FechaModificacionCosto,IsNull(DetalleRecepciones.FechaModificacionCosto,DetalleSalidasMateriales.FechaModificacionCosto)) as [Fecha ult. modif.],
 IsNull(DetallePedidos.ObservacionModificacionCosto,IsNull(DetalleRecepciones.ObservacionModificacionCosto,DetalleSalidasMateriales.ObservacionModificacionCosto)) as [Observaciones ult. modif.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido=#Auxiliar1.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetallePedidos.IdPedido
LEFT OUTER JOIN DetalleRecepciones ON DetalleRecepciones.IdDetalleRecepcion=#Auxiliar1.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=DetalleRecepciones.IdRecepcion
LEFT OUTER JOIN DetalleValesSalida ON DetalleValesSalida.IdDetalleValeSalida=#Auxiliar1.IdDetalleValeSalida
LEFT OUTER JOIN ValesSalida ON ValesSalida.IdValeSalida=DetalleValesSalida.IdValeSalida
LEFT OUTER JOIN DetalleSalidasMateriales ON DetalleSalidasMateriales.IdDetalleSalidaMateriales=#Auxiliar1.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales=DetalleSalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Monedas M1 ON M1.IdMoneda=IsNull(Pedidos.IdMoneda,IsNull(DetalleRecepciones.IdMoneda,DetalleSalidasMateriales.IdMoneda))
LEFT OUTER JOIN Monedas M2 ON M2.IdMoneda=IsNull(Pedidos.IdMonedaOriginal,IsNull(DetalleRecepciones.IdMonedaOriginal,DetalleSalidasMateriales.IdMonedaOriginal))
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=IsNull(DetallePedidos.IdArticulo,IsNull(DetalleRecepciones.IdArticulo,IsNull(DetalleValesSalida.IdArticulo,DetalleSalidasMateriales.IdArticulo)))
LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(DetalleRecepciones.IdObra,IsNull(ValesSalida.IdObra,IsNull(DetalleSalidasMateriales.IdObra,@IdObra)))
LEFT OUTER JOIN Empleados ON Empleados.IdEmpleado=IsNull(DetallePedidos.IdUsuarioModificoCosto,IsNull(DetalleRecepciones.IdUsuarioModificoCosto,DetalleSalidasMateriales.IdUsuarioModificoCosto))
ORDER BY #Auxiliar1.Orden, #Auxiliar1.IdDetallePedido, #Auxiliar1.IdDetalleRecepcion, #Auxiliar1.IdDetalleValeSalida, #Auxiliar1.IdDetalleSalidaMateriales

DROP TABLE #Auxiliar1