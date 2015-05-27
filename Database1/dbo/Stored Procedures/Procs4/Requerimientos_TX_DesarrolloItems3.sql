
CREATE Procedure [dbo].[Requerimientos_TX_DesarrolloItems3]

@Desde datetime,
@Hasta datetime,
@IdObra int = Null,
@IdComprobanteProveedor int = Null

AS

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @IdComprobanteProveedor=IsNull(@IdComprobanteProveedor,-1)

CREATE TABLE #Auxiliar210 (IdDetalleRequerimiento INTEGER)
CREATE TABLE #Auxiliar21 (IdDetalleRequerimiento INTEGER)
CREATE TABLE #Auxiliar22 (IdDetalleRecepcion INTEGER)
CREATE TABLE #Auxiliar230 (IdDetallePedido INTEGER)
CREATE TABLE #Auxiliar23 (IdDetallePedido INTEGER)
CREATE TABLE #Auxiliar24 (IdDetalleRequerimiento INTEGER, CantidadOtrasRecepciones NUMERIC(18,2))
IF @IdComprobanteProveedor>0
   BEGIN
	INSERT INTO #Auxiliar210 
	 SELECT Det1.IdDetalleRequerimiento
	 FROM DetalleComprobantesProveedores Det
	 LEFT OUTER JOIN DetalleRecepciones Det1 ON Det1.IdDetalleRecepcion = Det.IdDetalleRecepcion
	 WHERE Det.IdDetalleRecepcion is not null and Det1.IdDetalleRequerimiento is not null and Det.IdComprobanteProveedor=@IdComprobanteProveedor
	UNION ALL
	 SELECT Det1.IdDetalleRequerimiento
	 FROM DetalleComprobantesProveedores Det
	 LEFT OUTER JOIN DetallePedidos Det1 ON Det1.IdDetallePedido = Det.IdDetallePedido
	 WHERE Det.IdDetallePedido is not null and Det1.IdDetalleRequerimiento is not null and Det.IdComprobanteProveedor=@IdComprobanteProveedor

	INSERT INTO #Auxiliar21 
	 SELECT DISTINCT IdDetalleRequerimiento
	 FROM #Auxiliar210

	INSERT INTO #Auxiliar22 
	 SELECT DISTINCT Det.IdDetalleRecepcion
	 FROM DetalleComprobantesProveedores Det
	 WHERE Det.IdDetalleRecepcion is not null and Det.IdComprobanteProveedor=@IdComprobanteProveedor

	INSERT INTO #Auxiliar230 
	 SELECT Det1.IdDetallePedido
	 FROM DetalleComprobantesProveedores Det
	 LEFT OUTER JOIN DetalleRecepciones Det1 ON Det1.IdDetalleRecepcion = Det.IdDetalleRecepcion
	 WHERE Det.IdDetalleRecepcion is not null and Det1.IdDetallePedido is not null and Det.IdComprobanteProveedor=@IdComprobanteProveedor
	UNION ALL
	 SELECT Det.IdDetallePedido
	 FROM DetalleComprobantesProveedores Det
	 WHERE Det.IdDetallePedido is not null and Det.IdComprobanteProveedor=@IdComprobanteProveedor

	INSERT INTO #Auxiliar23 
	 SELECT DISTINCT IdDetallePedido
	 FROM #Auxiliar230

	INSERT INTO #Auxiliar24 
	 SELECT Aux.IdDetalleRequerimiento, 
			IsNull((Select Sum(IsNull(Cantidad,0)) From DetalleRecepciones Det
					Left Outer Join Recepciones On Det.IdRecepcion = Recepciones.IdRecepcion					Where IsNull(Recepciones.Anulada,'')<>'SI' and Det.IdDetalleRequerimiento=Aux.IdDetalleRequerimiento and 
							Not Det.IdDetalleRecepcion in (Select #Auxiliar22.IdDetalleRecepcion From #Auxiliar22)),0)
	 FROM #Auxiliar21 Aux
   END

CREATE TABLE #Auxiliar1 (IdDetalleRequerimiento INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleRequerimiento) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT DetReq.IdDetalleRequerimiento
 FROM DetalleRequerimientos DetReq
 LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
 WHERE Requerimientos.Aprobo is not null and IsNull(Requerimientos.Confirmado,'')<>'NO' and IsNull(Requerimientos.Cumplido,'')<>'AN' and 
	(Requerimientos.FechaRequerimiento Between @Desde And @Hasta) and (@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	(@IdComprobanteProveedor=-1 or DetReq.IdDetalleRequerimiento in (Select #Auxiliar21.IdDetalleRequerimiento From #Auxiliar21))

CREATE TABLE #Auxiliar2 
			(
			 IdDetalleRequerimiento INTEGER,
			 IdDetalleRecepcion INTEGER,
			 IdDetalleComprobanteProveedor INTEGER,
			 IdDetalleSalidaMateriales INTEGER,
			 IdDetallePedido INTEGER
			)
CREATE TABLE #Auxiliar3 
			(
			 Renglon INTEGER,
			 IdDetalleRequerimiento INTEGER,
			 IdDetalleRecepcion INTEGER,
			 IdDetalleComprobanteProveedor INTEGER,
			 IdDetalleSalidaMateriales INTEGER,
			 IdDetallePedido INTEGER
			)
CREATE TABLE #Auxiliar11 (IdDetalleRecepcion INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (IdDetalleRecepcion) ON [PRIMARY]
CREATE TABLE #Auxiliar12 (IdDetalleComprobanteProveedor INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar12 ON #Auxiliar12 (IdDetalleComprobanteProveedor) ON [PRIMARY]
CREATE TABLE #Auxiliar13 (IdDetalleSalidaMateriales INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar13 ON #Auxiliar13 (IdDetalleSalidaMateriales) ON [PRIMARY]
CREATE TABLE #Auxiliar14 (IdDetallePedido INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar14 ON #Auxiliar14 (IdDetallePedido) ON [PRIMARY]

DECLARE @IdDetalleRequerimiento int, @IdDetalleRecepcion int, @IdDetalleComprobanteProveedor int, @IdDetalleSalidaMateriales int, 
	@IdDetallePedido int, @Renglon int, @UltimoRenglon int

/*  CURSOR  */
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRequerimiento FROM #Auxiliar1 ORDER BY IdDetalleRequerimiento
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @UltimoRenglon=1

	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 
	 SELECT @UltimoRenglon, @IdDetalleRequerimiento, Null, Null, Null, Null

	--RECEPCIONES
	TRUNCATE TABLE #Auxiliar11
	INSERT INTO #Auxiliar11 
	 SELECT Det.IdDetalleRecepcion
	 FROM DetalleRecepciones Det
	 LEFT OUTER JOIN Recepciones ON Det.IdRecepcion = Recepciones.IdRecepcion	 WHERE Det.IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'')<>'SI' and 
		(@IdComprobanteProveedor=-1 or Det.IdDetalleRecepcion in (Select #Auxiliar22.IdDetalleRecepcion From #Auxiliar22))

	DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRecepcion FROM #Auxiliar11 ORDER BY IdDetalleRecepcion
	OPEN Cur1
	FETCH NEXT FROM Cur1 INTO @IdDetalleRecepcion
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		SET @Renglon=IsNull((Select Top 1 Renglon From #Auxiliar3 Where IdDetalleRecepcion is null Order By Renglon),0)
		IF @Renglon=0
		   BEGIN
			SET @UltimoRenglon=@UltimoRenglon+1
			INSERT INTO #Auxiliar3 
			 SELECT @UltimoRenglon, @IdDetalleRequerimiento, @IdDetalleRecepcion, Null, Null, Null
		   END
		ELSE
		   BEGIN
			UPDATE #Auxiliar3 SET IdDetalleRecepcion=@IdDetalleRecepcion WHERE Renglon=@Renglon
		   END
		FETCH NEXT FROM Cur1 INTO @IdDetalleRecepcion
	   END
	CLOSE Cur1
	DEALLOCATE Cur1

	--COMPROBANTES PROVEEDORES
	TRUNCATE TABLE #Auxiliar12
	INSERT INTO #Auxiliar12 
	 SELECT DISTINCT Det.IdDetalleComprobanteProveedor
	 FROM DetalleComprobantesProveedores Det
	 LEFT OUTER JOIN DetalleRecepciones Det1 ON Det1.IdDetalleRecepcion = Det.IdDetalleRecepcion
	 LEFT OUTER JOIN DetallePedidos Det2 ON Det2.IdDetallePedido = Det.IdDetallePedido
	 WHERE ((Det.IdDetalleRecepcion is not null and Det1.IdDetalleRequerimiento=@IdDetalleRequerimiento) or 
			(Det.IdDetallePedido is not null and Det2.IdDetalleRequerimiento=@IdDetalleRequerimiento)) and 
		(@IdComprobanteProveedor=-1 or Det.IdComprobanteProveedor=@IdComprobanteProveedor)

	DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleComprobanteProveedor FROM #Auxiliar12 ORDER BY IdDetalleComprobanteProveedor
	OPEN Cur1
	FETCH NEXT FROM Cur1 INTO @IdDetalleComprobanteProveedor
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		SET @Renglon=IsNull((Select Top 1 Renglon From #Auxiliar3 Where IdDetalleComprobanteProveedor is null Order By Renglon),0)
		IF @Renglon=0
		   BEGIN
			SET @UltimoRenglon=@UltimoRenglon+1
			INSERT INTO #Auxiliar3 
			 SELECT @UltimoRenglon, @IdDetalleRequerimiento, Null, @IdDetalleComprobanteProveedor, Null, Null
		   END
		ELSE
		   BEGIN
			UPDATE #Auxiliar3 SET IdDetalleComprobanteProveedor=@IdDetalleComprobanteProveedor WHERE Renglon=@Renglon
		   END
		FETCH NEXT FROM Cur1 INTO @IdDetalleComprobanteProveedor
	   END
	CLOSE Cur1
	DEALLOCATE Cur1

	--SALIDA DE MATERIALES
	TRUNCATE TABLE #Auxiliar13
	INSERT INTO #Auxiliar13 
	 SELECT Det.IdDetalleSalidaMateriales
	 FROM DetalleSalidasMateriales Det
	 LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = Det.IdSalidaMateriales
	 LEFT OUTER JOIN DetalleValesSalida Det1 ON Det1.IdDetalleValeSalida = Det.IdDetalleValeSalida
	 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and Det1.IdDetalleRequerimiento=@IdDetalleRequerimiento

	DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleSalidaMateriales FROM #Auxiliar13 ORDER BY IdDetalleSalidaMateriales
	OPEN Cur1
	FETCH NEXT FROM Cur1 INTO @IdDetalleSalidaMateriales
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		SET @Renglon=IsNull((Select Top 1 Renglon From #Auxiliar3 Where IdDetalleSalidaMateriales is null Order By Renglon),0)
		IF @Renglon=0
		   BEGIN
			SET @UltimoRenglon=@UltimoRenglon+1
			INSERT INTO #Auxiliar3 
			 SELECT @UltimoRenglon, @IdDetalleRequerimiento, Null, Null, @IdDetalleSalidaMateriales, Null
		   END
		ELSE
		   BEGIN
			UPDATE #Auxiliar3 SET IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales WHERE Renglon=@Renglon
		   END
		FETCH NEXT FROM Cur1 INTO @IdDetalleSalidaMateriales
	   END
	CLOSE Cur1
	DEALLOCATE Cur1

	--PEDIDOS
	TRUNCATE TABLE #Auxiliar14
	INSERT INTO #Auxiliar14 
	 SELECT Det.IdDetallePedido
	 FROM DetallePedidos Det
	 LEFT OUTER JOIN Pedidos ON Det.IdPedido = Pedidos.IdPedido
	 WHERE Det.IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Pedidos.Cumplido,'NO')<>'AN' and 
		(@IdComprobanteProveedor=-1 or Det.IdDetallePedido in (Select #Auxiliar23.IdDetallePedido From #Auxiliar23))

	DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido FROM #Auxiliar14 ORDER BY IdDetallePedido
	OPEN Cur1
	FETCH NEXT FROM Cur1 INTO @IdDetallePedido
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		SET @Renglon=IsNull((Select Top 1 Renglon From #Auxiliar3 Where IdDetallePedido is null Order By Renglon),0)
		IF @Renglon=0
		   BEGIN
			SET @UltimoRenglon=@UltimoRenglon+1
			INSERT INTO #Auxiliar3 
			 SELECT @UltimoRenglon, @IdDetalleRequerimiento, Null, Null, Null, @IdDetallePedido
		   END
		ELSE
		   BEGIN
			UPDATE #Auxiliar3 SET IdDetallePedido=@IdDetallePedido WHERE Renglon=@Renglon
		   END
		FETCH NEXT FROM Cur1 INTO @IdDetallePedido
	   END
	CLOSE Cur1
	DEALLOCATE Cur1

	INSERT INTO #Auxiliar2 
	 SELECT IdDetalleRequerimiento, IdDetalleRecepcion, IdDetalleComprobanteProveedor, IdDetalleSalidaMateriales, IdDetallePedido
	 FROM #Auxiliar3

	FETCH NEXT FROM Cur INTO @IdDetalleRequerimiento
   END
CLOSE Cur
DEALLOCATE Cur

TRUNCATE TABLE _TempEstadoRMs
INSERT INTO _TempEstadoRMs SELECT *, Null, Null, Null, Null FROM #Auxiliar2

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13
DROP TABLE #Auxiliar14
DROP TABLE #Auxiliar210
DROP TABLE #Auxiliar21
DROP TABLE #Auxiliar22
DROP TABLE #Auxiliar230
DROP TABLE #Auxiliar23

SET NOCOUNT OFF

SELECT 
 _TempEstadoRMs.IdDetalleRequerimiento as [IdDetalleRequerimiento],
 DetRM.NumeroItem as [ItemRM],
 Requerimientos.NumeroRequerimiento as [NumeroRM],
 Requerimientos.FechaRequerimiento as [FechaRM],
 (Select Top 1 IsNull(E.Iniciales,E.Nombre)+' '+Convert(varchar,ac.FechaAutorizacion,103) From AutorizacionesPorComprobante ac 
	Left Outer Join Empleados E On E.IdEmpleado=ac.IdAutorizo
	Where ac.IdFormulario=3 and ac.IdComprobante=DetRM.IdRequerimiento and ac.OrdenAutorizacion=1) as [AutorizoRM],
-- E1.Nombre as [AutorizoRM],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 (Select Top 1 Presupuestos.Numero From DetallePresupuestos dp 
	Left Outer Join Presupuestos On Presupuestos.IdPresupuesto=dp.IdPresupuesto
	Where dp.IdDetalleRequerimiento=_TempEstadoRMs.IdDetalleRequerimiento) as [SolicitudCotizacion],
 Pedidos.NumeroPedido as [NumeroPE],
 DetPE.Cantidad as [CantidadPE],
 DetPE.Precio as [ImporteUnitarioPE],
 (DetPE.Cantidad*DetPE.Precio)-IsNull(DetPE.ImporteBonificacion,0) as [ImporteTotalPE],
 (Select Top 1 IsNull(E.Iniciales,E.Nombre)+' '+Convert(varchar,ac.FechaAutorizacion,103) From AutorizacionesPorComprobante ac 
	Left Outer Join Empleados E On E.IdEmpleado=ac.IdAutorizo
	Where ac.IdFormulario=4 and ac.IdComprobante=DetPE.IdPedido and ac.OrdenAutorizacion=1) as [AutorizoPE],
-- E3.Nombre as [AutorizoPE],
 DetCP.Importe as [ImporteCP],
 DetCP.Cantidad as [CantidadCP],
 Recepciones.NumeroRecepcionAlmacen as [NumeroRE],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2) as [NumeroRemitoRE],
 DetRE.Cantidad as [CantidadRE],
 U1.Abreviatura as [UnidadRE],
 Cuentas.Descripcion as [Cuenta],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 #Auxiliar24.CantidadOtrasRecepciones as [CantidadOtrasRecepciones]
FROM _TempEstadoRMs
LEFT OUTER JOIN DetalleRequerimientos DetRM ON DetRM.IdDetalleRequerimiento=_TempEstadoRMs.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetRM.IdRequerimiento=Requerimientos.IdRequerimiento
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Requerimientos.Aprobo
LEFT OUTER JOIN Unidades U1 ON U1.IdUnidad=DetRM.IdUnidad
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=DetRM.IdArticulo
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=IsNull(Articulos.IdCuentaCompras,Rubros.IdCuentaCompras)
LEFT OUTER JOIN DetalleRecepciones DetRE ON DetRE.IdDetalleRecepcion=_TempEstadoRMs.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion=DetRE.IdRecepcion
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Recepciones.Realizo
LEFT OUTER JOIN Unidades U2 ON U2.IdUnidad=DetRE.IdUnidad
LEFT OUTER JOIN DetalleComprobantesProveedores DetCP ON DetCP.IdDetalleComprobanteProveedor=_TempEstadoRMs.IdDetalleComprobanteProveedor
LEFT OUTER JOIN ComprobantesProveedores ON ComprobantesProveedores.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores P1 ON P1.IdProveedor=ComprobantesProveedores.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON P2.IdProveedor=ComprobantesProveedores.IdProveedorEventual
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=ComprobantesProveedores.IdMoneda
LEFT OUTER JOIN DetalleSalidasMateriales DetSM ON DetSM.IdDetalleSalidaMateriales=_TempEstadoRMs.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales=DetSM.IdSalidaMateriales
LEFT OUTER JOIN DetallePedidos DetPE ON DetPE.IdDetallePedido=_TempEstadoRMs.IdDetallePedido
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=DetPE.IdPedido
LEFT OUTER JOIN Empleados E3 ON Pedidos.Aprobo=E3.IdEmpleado
LEFT OUTER JOIN Obras ON Obras.IdObra=DetCP.IdObra
LEFT OUTER JOIN #Auxiliar24 ON #Auxiliar24.IdDetalleRequerimiento=_TempEstadoRMs.IdDetalleRequerimiento
ORDER BY Requerimientos.NumeroRequerimiento, DetRM.NumeroItem

DROP TABLE #Auxiliar24
