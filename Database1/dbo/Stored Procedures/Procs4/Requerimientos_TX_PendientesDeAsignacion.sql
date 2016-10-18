
[Requerimientos_TX_PendientesDeAsignacion]

select top 10 * from valessalida order by idvalesalida desc

select top 10 * from detallerequerimientos where iddetallerequerimiento=48866 order by iddetallerequerimiento desc






declare @Depositos varchar(100) = Null

SET NOCOUNT ON

IF @Depositos is null or Len(@Depositos)=0
	SET @Depositos='-1'

DECLARE @IdObraStockDisponible int, @IdDepositoCentral int, @FirmasLiberacion int, @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @IdObraStockDisponible=IsNull((Select Top 1 IdObraStockDisponible From Parametros Where IdParametro=1),0)
SET @IdDepositoCentral=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdDepositoCentral'),-1)
SET @FirmasLiberacion=IsNull((Select Top 1 Convert(integer,Valor) From Parametros2 Where Campo='AprobacionesRM'),1)
SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar3 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdArticulo) ON [PRIMARY]

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleRequerimiento INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecibida NUMERIC(18,2),
			 CantidadVales NUMERIC(18,2),
			 CantidadEnStock NUMERIC(18,2),
			 IdDetalleRecepcion INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetReq.IdDetalleRequerimiento,
  (Select Sum(IsNull(DetallePedidos.Cantidad,0)) 
	From DetallePedidos 
	Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')), 
  (Select Sum(IsNull(DetRec.CantidadCC,0)) 
	From DetalleRecepciones DetRec 
	Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
	Where DetRec.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' and IsNull(DetRec.IdDetalleSalidaMateriales,0)=0), 
  (Select Sum(IsNull(DetalleValesSalida.Cantidad,0)) 
	From DetalleValesSalida 
	Where DetalleValesSalida.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetalleValesSalida.Estado is null or DetalleValesSalida.Estado<>'AN')), 
  Case When IsNull(Articulos.RegistrarStock,'SI')='SI'
	Then (Select Sum(IsNull(Stock.CantidadUnidades,0)) From Stock 
		Left Outer Join Ubicaciones On Stock.IdUbicacion = Ubicaciones.IdUbicacion
		Where DetReq.IdArticulo=Stock.IdArticulo)
	Else Null
  End, 
  (Select Top 1 DetRec.IdDetalleRecepcion
	From DetalleRecepciones DetRec
	Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
	Where DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' and IsNull(DetRec.IdDetalleSalidaMateriales,0)=0
	Order By Recepciones.NumeroRecepcionAlmacen desc)
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Articulos ON DetReq.IdArticulo = Articulos.IdArticulo
 WHERE ((@FirmasLiberacion=1 and Requerimientos.Aprobo is not null) or (@FirmasLiberacion>1 and Requerimientos.Aprobo2 is not null)) and 
	IsNull(DetReq.Cumplido,'NO')<>'AN' and 
	IsNull(Requerimientos.Cumplido,'NO')<>'AN' and 
	IsNull(Requerimientos.Confirmado,'SI')='SI' and 
	(@Depositos='-1' or 
	 Patindex('%('+Convert(varchar,
			IsNull((Select Top 1 Ubicaciones.IdDeposito
					From DetalleRecepciones DetRec
					Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
					Left Outer Join Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
					Where DetRec.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI'),0))+')%', @Depositos)<>0 or 
	 Exists(Select Top 1 Depositos.IdDeposito From Depositos Where Requerimientos.IdObra = Depositos.IdObra and Patindex('%('+Convert(varchar,Depositos.IdDeposito)+')%', @Depositos)<>0)) and 
	(IsNull(Requerimientos.CircuitoFirmasCompleto,'')='SI' or Not Exists(Select Top 1 * From DetalleAutorizaciones da Left Outer Join Autorizaciones On Autorizaciones.IdAutorizacion=da.IdAutorizacion Where Autorizaciones.IdFormulario=3)) and 
	(DetReq.TipoDesignacion is not null and 
		(DetReq.TipoDesignacion='S/D' or 
		 (DetReq.TipoDesignacion='REC' and Requerimientos.IdObra<>@IdObraStockDisponible) or 
		 (DetReq.TipoDesignacion='STK' and DetReq.Cantidad > IsNull((Select Sum(IsNull(DetalleValesSalida.Cantidad,0)) From DetalleValesSalida Where DetalleValesSalida.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento and (DetalleValesSalida.Estado is null or DetalleValesSalida.Estado<>'AN')),0))))



select * from #Auxiliar1 order by IdDetalleRequerimiento





IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
  BEGIN
	SET @sql1='Select Distinct a.IdArticulo, a.Descripcion, a.NumeroInventario 
			From DetalleRequerimientos dr 
			Left Outer Join Requerimientos On dr.IdRequerimiento = Requerimientos.IdRequerimiento
			Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos a On IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino) = a.IdArticulo
			Where dr.IdDetalleRequerimiento in (Select IdDetalleRequerimiento From #Auxiliar1) and a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar3 
	 SELECT DISTINCT a.IdArticulo, a.Descripcion, a.NumeroInventario
	 FROM DetalleRequerimientos dr
	 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN Articulos a ON IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino) = a.IdArticulo
	 WHERE a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI'  and dr.IdDetalleRequerimiento in (Select IdDetalleRequerimiento From #Auxiliar1)
  END

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111111111111111133'
SET @vector_T='029999H101115511F413213525252D00'

SELECT 
 DetReq.IdDetalleRequerimiento,
 Requerimientos.NumeroRequerimiento as [Req.Nro.],
 DetReq.IdDetalleRequerimiento as [IdAux1],
 DetReq.IdRequerimiento as [IdAux2],
 IsNull(Requerimientos.IdObra,LMateriales.IdObra) as [IdAux3],
 DetReq.TipoDesignacion as [IdAux4],
 DetReq.NumeroItem as [Item],
 DetReq.Cantidad as [Cant.],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad en],
 #Auxiliar1.CantidadVales as [Vales],
 #Auxiliar1.CantidadPedida as [Cant.Ped.],
 #Auxiliar1.CantidadRecibida as [Recibido],
 Case When DetReq.TipoDesignacion='REC' 
	Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,IsNull(Recepciones.SubNumero,0)),1,20) 
	Else Null 
 End as [Recepcion],
 Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,IsNull(Recepciones.SubNumero,0)),1,20) as [Ult.Recepcion],
 #Auxiliar1.CantidadEnStock as [En stock],
 A1.StockMinimo as [Stk.min.],
 A1.Descripcion as [Articulo],
 DetReq.FechaEntrega as [F.entrega],
 E2.Nombre as [Solicito],
 Case When IsNull(Requerimientos.TipoRequerimiento,'')='OP'
	 Then IsNull(Requerimientos.TipoRequerimiento,'')+Convert(varchar,IsNull(' - '+(Select Top 1 A.NumeroInventario From Articulos A Where DetReq.IdEquipoDestino=A.IdArticulo),''))
	When IsNull(Requerimientos.TipoRequerimiento,'')='OT' or IsNull(Requerimientos.TipoRequerimiento,'')='ST'
	 Then IsNull(Requerimientos.TipoRequerimiento,'')+Convert(varchar,IsNull(' - '+(Select Top 1 OT.NumeroOrdenTrabajo From OrdenesTrabajo OT Where Requerimientos.IdOrdenTrabajo=OT.IdOrdenTrabajo),''))
	Else IsNull(Requerimientos.TipoRequerimiento,'')
 End as [Tipo Req.],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 DetReq.Cumplido as [Cump.],
 DetReq.Recepcionado as [Recepcionado],
 DetReq.Observaciones as [Observaciones item], --Replace(Convert(varchar(1000),DetReq.Observaciones),'\','') as [Observaciones item],
 Depositos.Descripcion as [Deposito],
 DetReq.ObservacionesFirmante as [Observaciones firmante],
 E3.Nombre as [Firmante observo],
 DetReq.FechaUltimaObservacionFirmante as [Fecha ult.observacion],
 #Auxiliar3.NumeroInventario as [Cod.Eq.Destino],
 #Auxiliar3.Descripcion as [Equipo destino],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DetalleRequerimientos DetReq ON #Auxiliar1.IdDetalleRequerimiento = DetReq.IdDetalleRequerimiento
LEFT OUTER JOIN Articulos A1 ON DetReq.IdArticulo = A1.IdArticulo
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN DetalleLMateriales ON DetReq.IdDetalleLMateriales = DetalleLMateriales.IdDetalleLMateriales
LEFT OUTER JOIN LMateriales ON DetalleLMateriales.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN Empleados E1 ON DetReq.IdComprador = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON DetReq.IdFirmanteObservo = E3.IdEmpleado
LEFT OUTER JOIN Cuentas ON DetReq.IdCuenta = Cuentas.IdCuenta
LEFT OUTER JOIN Unidades ON DetReq.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras ON IsNull(Requerimientos.IdObra,LMateriales.IdObra) = Obras.IdObra
LEFT OUTER JOIN DetalleRecepciones DetRec ON #Auxiliar1.IdDetalleRecepcion = DetRec.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN Ubicaciones ON DetRec.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdArticulo = IsNull(DetReq.IdEquipoDestino,Requerimientos.IdEquipoDestino)
/*
WHERE (DetReq.TipoDesignacion is not null and 
		(DetReq.TipoDesignacion='S/D' or 
		 (DetReq.TipoDesignacion='REC' and Requerimientos.IdObra<>@IdObraStockDisponible) or 
		 (DetReq.TipoDesignacion='STK' and DetReq.Cantidad > IsNull(#Auxiliar1.CantidadVales,0))))
*/
ORDER BY Requerimientos.NumeroRequerimiento, DetReq.NumeroItem

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar3