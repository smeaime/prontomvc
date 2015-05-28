CREATE Procedure [dbo].[Requerimientos_TX_DatosRequerimiento]

@IdDetalleRequerimiento int

AS 

SET NOCOUNT ON

DECLARE @IdRequerimiento int, @IdAutorizo int, @FechaAutorizacion datetime, @OrdenAutorizacion int, @Corte int, @A1 varchar(100), @A2 varchar(100), @Autorizo varchar(6)

CREATE TABLE #Auxiliar1 
			(
			 IdRequerimiento INTEGER,
			 IdAutorizo INTEGER,
			 Autorizo VARCHAR(6),
			 FechaAutorizacion DATETIME,
			 OrdenAutorizacion INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdRequerimiento,OrdenAutorizacion) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT DISTINCT Det.IdRequerimiento, apc.IdAutorizo, IsNull(Empleados.Iniciales,'???'), apc.FechaAutorizacion, apc.OrdenAutorizacion
 FROM DetalleRequerimientos Det
 LEFT OUTER JOIN Requerimientos ON Det.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN AutorizacionesPorComprobante apc ON Det.IdRequerimiento = apc.IdComprobante and apc.IdFormulario=3
 LEFT OUTER JOIN Empleados ON apc.IdAutorizo = Empleados.IdEmpleado
 WHERE Det.IdDetalleRequerimiento=@IdDetalleRequerimiento and apc.IdAutorizo is not null and IsNull(Requerimientos.Cumplido,'NO')<>'AN' and IsNull(Det.Cumplido,'NO')<>'AN'

CREATE TABLE #Auxiliar2 
			(
			 IdRequerimiento INTEGER,
			 Autorizaciones VARCHAR(100),
			 Fechas VARCHAR(100)
			)
SET @Corte=0
SET @A1=''
SET @A2=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdRequerimiento, IdAutorizo, Autorizo, FechaAutorizacion, OrdenAutorizacion FROM #Auxiliar1 ORDER BY IdRequerimiento, OrdenAutorizacion
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRequerimiento, @IdAutorizo, @Autorizo, @FechaAutorizacion, @OrdenAutorizacion
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @Corte<>@IdRequerimiento
	  BEGIN
		IF @Corte<>0
		  BEGIN
			INSERT INTO #Auxiliar2 
			(IdRequerimiento, Autorizaciones, Fechas)
			VALUES
			(@Corte, SUBSTRING(@A1,1,LEN(@A1)-2), SUBSTRING(@A2,1,LEN(@A2)-2))
		  END
		SET @A1=''
		SET @A2=''
		SET @Corte=@IdRequerimiento
	  END
	SET @A1=@A1+@Autorizo+' - '
	SET @A2=@A2+CONVERT(varchar,@FechaAutorizacion,103)+' - '
	FETCH NEXT FROM Cur INTO @IdRequerimiento, @IdAutorizo, @Autorizo, @FechaAutorizacion, @OrdenAutorizacion
  END
IF @Corte<>0
  BEGIN
	INSERT INTO #Auxiliar2 
	(IdRequerimiento, Autorizaciones, Fechas)
	VALUES
	(@Corte, SUBSTRING(@A1,1,LEN(@A1)-2), SUBSTRING(@A2,1,LEN(@A2)-2))
  END
CLOSE Cur
DEALLOCATE Cur


DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar3 (IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdArticulo) ON [PRIMARY]

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
  BEGIN
	SET @sql1='Select Distinct a.IdArticulo, a.Descripcion, a.NumeroInventario 
			From DetalleRequerimientos dr 
			Left Outer Join Requerimientos On dr.IdRequerimiento = Requerimientos.IdRequerimiento
			Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos a On IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino) = a.IdArticulo
			Where dr.IdDetalleRequerimiento='+Convert(varchar,@IdDetalleRequerimiento)+' and a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar3 
	 SELECT DISTINCT a.IdArticulo, a.Descripcion, a.NumeroInventario
	 FROM DetalleRequerimientos dr
	 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN Articulos a ON IsNull(dr.IdEquipoDestino,Requerimientos.IdEquipoDestino) = a.IdArticulo
	 WHERE dr.IdDetalleRequerimiento=@IdDetalleRequerimiento and a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
  END

CREATE TABLE #Auxiliar4 
			(
			 IdDetalleRequerimiento INTEGER,
			 Pedido NUMERIC(18,2),
			 Entregado NUMERIC(18,2),
			 SalidaPorVales NUMERIC(18,2)
			)
INSERT INTO #Auxiliar4 
(IdDetalleRequerimiento, Pedido, Entregado, SalidaPorVales)
VALUES
(@IdDetalleRequerimiento, 0, 0, 0)
UPDATE #Auxiliar4
SET Pedido=IsNull((Select Sum(DetallePedidos.Cantidad) 
					From DetallePedidos 
					Where DetallePedidos.IdDetalleRequerimiento=@IdDetalleRequerimiento and (DetallePedidos.Cumplido is null or DetallePedidos.Cumplido<>'AN')),0)
UPDATE #Auxiliar4
SET Entregado=IsNull((Select Sum(IsNull(DetRec.CantidadCC,DetRec.Cantidad))
						From DetalleRecepciones DetRec
						Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
						Where DetRec.IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(Recepciones.Anulada,'NO')<>'SI' and IsNull(DetRec.IdDetalleSalidaMateriales,0)=0),0)
UPDATE #Auxiliar4
SET SalidaPorVales=IsNull((Select Sum(DetalleValesSalida.Cantidad) 
							From DetalleValesSalida 
							Where DetalleValesSalida.IdDetalleRequerimiento=@IdDetalleRequerimiento and (DetalleValesSalida.Estado is null or DetalleValesSalida.Estado<>'AN')),0)

SET NOCOUNT OFF

SELECT 
 DetReq.*,
 Requerimientos.NumeroRequerimiento,
 Requerimientos.FechaRequerimiento,
 Requerimientos.Aprobo,
 Requerimientos.IdComprador as [IdCompradorRM],
 Requerimientos.IdObra as [IdObra],
 Requerimientos.Cumplido as [CumplidoReq],
 Requerimientos.TipoRequerimiento,
 Requerimientos.IdTipoCompra,
 Requerimientos.IdOrdenTrabajo as [IdOrdenTrabajo],
 Requerimientos.Observaciones as [ObservacionesRM],
 Articulos.Descripcion as [DescripcionArt],
 Articulos.Codigo,
 Articulos.AlicuotaIVA,
 IsNull(Articulos.CostoPPP,0) as [CostoPPP],
 IsNull(Articulos.CostoReposicion,0) as [CostoReposicion],
 Unidades.Descripcion as [Unidad en],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad],
 IsNull(#Auxiliar4.Entregado,0) as [Entregado],
 DetReq.Cantidad - IsNull(#Auxiliar4.Entregado,0) as [Pendiente],
 IsNull(#Auxiliar4.Pedido,0) as [Pedido],
 IsNull(#Auxiliar4.SalidaPorVales,0) as [SalidaPorVales],
 0 as [Reservado],
 Obras.NumeroObra as [Obra],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra1],
 Clientes.RazonSocial as [Cliente],
 Equipos.Descripcion as [Equipo],
 Rubros.Descripcion as [Rubro],
 IsNull(ControlesCalidad.Abreviatura,ControlesCalidad.Descripcion) as [CC],
 IsNull(E1.Iniciales,'???')+' - '+#Auxiliar2.Autorizaciones COLLATE SQL_Latin1_General_CP1_CI_AS as [Liberada por],
 Convert(varchar,Requerimientos.FechaAprobacion,103)+' - '+#Auxiliar2.Fechas as [Fecha aprobo],
 E2.Nombre as [Solicitada por],
 #Auxiliar3.NumeroInventario as [Cod.Eq.Destino],
 #Auxiliar3.Descripcion as [Equipo destino],
 TiposCompra.Descripcion as [TipoCompra],
 IsNull((Select Top 1 drls.Situacion From DetalleRequerimientosLogSituacion drls Where drls.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento Order By Fecha Desc),'A') as [Situacion],
 Case When IsNull(DetReq.TipoDesignacion,'')='STK' 
		Then IsNull(DetReq.Cantidad,0)-IsNull(#Auxiliar4.SalidaPorVales,0) 
		Else IsNull(DetReq.Cantidad,0)-IsNull(#Auxiliar4.Pedido,0)-IsNull(#Auxiliar4.SalidaPorVales,0) 
 End as [PendientePedido1]
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN Requerimientos On Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
LEFT OUTER JOIN Articulos On DetReq.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades On DetReq.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Obras On Requerimientos.IdObra = Obras.IdObra
LEFT OUTER JOIN Clientes On Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Equipos On DetReq.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Rubros On Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN ControlesCalidad On DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdArticulo = IsNull(DetReq.IdEquipoDestino,Requerimientos.IdEquipoDestino)
LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
LEFT OUTER JOIN #Auxiliar2 ON DetReq.IdRequerimiento = #Auxiliar2.IdRequerimiento
LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
LEFT OUTER JOIN #Auxiliar4 ON DetReq.IdDetalleRequerimiento = #Auxiliar4.IdDetalleRequerimiento
WHERE DetReq.IdDetalleRequerimiento=@IdDetalleRequerimiento

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4