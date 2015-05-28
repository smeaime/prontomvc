CREATE PROCEDURE [dbo].[Pedidos_TX_PorObra]

@IdObra int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 
			(
			 IdPedido INTEGER,
			 Requerimientos VARCHAR(100),
			 Obras VARCHAR(100)
			)

CREATE TABLE #Auxiliar20 
			(
			 IdPedido INTEGER,
			 NumeroRequerimiento INTEGER,
			 NumeroObra VARCHAR(13),
			 SAT VARCHAR(1)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar20 (IdPedido,NumeroRequerimiento) ON [PRIMARY]
INSERT INTO #Auxiliar20 
 SELECT 
  DetPed.IdPedido,
  Case When Requerimientos.NumeroRequerimiento is not null
	Then Requerimientos.NumeroRequerimiento
	Else Acopios.NumeroAcopio
  End,
  Obras.NumeroObra,
  Case When DetalleRequerimientos.IdOrigenTransmision is not null
	Then 'S'
	Else ''
  End
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
 LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 LEFT OUTER JOIN Obras ON Requerimientos.IdObra = Obras.IdObra
 WHERE (IsNull(Acopios.IdObra,0)=@IdObra or IsNull(Requerimientos.IdObra,0)=@IdObra) and 
	IsNull(DetPed.Cumplido,'')<>'AN'

INSERT INTO #Auxiliar0 
 SELECT IdPedido, '', ''
 FROM #Auxiliar20
 GROUP BY IdPedido

/*  CURSOR  */
DECLARE @IdPedido int, @NumeroRequerimiento int, @NumeroObra varchar(13), @RMs varchar(100), @Obras varchar(100), @Corte int, @SAT varchar(1)
SET @Corte=0
SET @RMs=''
SET @Obras=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPedido, NumeroRequerimiento, NumeroObra, SAT FROM #Auxiliar20 ORDER BY IdPedido
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPedido, @NumeroRequerimiento, @NumeroObra, @SAT
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdPedido
	   BEGIN
		IF @Corte<>0
		   BEGIN
			UPDATE #Auxiliar0
			SET Requerimientos = SUBSTRING(@RMs,1,100), Obras = SUBSTRING(@Obras,1,100)
			WHERE #Auxiliar0.IdPedido=@Corte
		   END
		SET @RMs=''
		SET @Obras=''
		SET @Corte=@IdPedido
	   END
	IF NOT @NumeroRequerimiento IS NULL
		IF PATINDEX('%['+CONVERT(VARCHAR,@NumeroRequerimiento)+']'+'%', @RMs)=0
			SET @RMs=@RMs+'['+CONVERT(VARCHAR,@NumeroRequerimiento)+']'+@SAT+' '
	IF NOT @NumeroObra IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroObra)+' '+'%', @Obras)=0
			SET @Obras=@Obras+@NumeroObra+' '
	FETCH NEXT FROM Cur INTO @IdPedido, @NumeroRequerimiento, @NumeroObra, @SAT
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar0
	SET Requerimientos = SUBSTRING(@RMs,1,100), Obras = SUBSTRING(@Obras,1,100)
	WHERE #Auxiliar0.IdPedido=@Corte
    END
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar21 
			(
			 IdPedido INTEGER,
			 TotalItems NUMERIC(18,2)
			)
INSERT INTO #Auxiliar21 
 SELECT DetPed.IdPedido, Sum(IsNull(DetPed.ImporteTotalItem,0)-IsNull(DetPed.ImporteIva,0))
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
 LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE (IsNull(Acopios.IdObra,0)=@IdObra or IsNull(Requerimientos.IdObra,0)=@IdObra) and 
	IsNull(DetPed.Cumplido,'')<>'AN'
 GROUP BY DetPed.IdPedido


DECLARE @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA varchar(2), @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA=IsNull((Select Top 1 Valor From Parametros2 Where Campo='EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA'),'NO')
SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdPedido INTEGER, Equipos VARCHAR(2000))

CREATE TABLE #Auxiliar2 (IdPedido INTEGER, IdArticulo INTEGER, Descripcion VARCHAR(256), NumeroInventario VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdPedido,IdArticulo) ON [PRIMARY]

IF @EquipoDestinoDesdePRONTO_MANTENIMIENTO_RM_VA='SI' and Len(@BasePRONTOMANT)>0
    BEGIN
	SET @sql1='Select Distinct dp.IdPedido, a.IdArticulo, a.Descripcion, a.NumeroInventario 
			From DetallePedidos dp
			Left Outer Join Pedidos On Pedidos.IdPedido = dp.IdPedido
			Left Outer Join DetalleRequerimientos dr On dp.IdDetalleRequerimiento = dr.IdDetalleRequerimiento
			Left Outer Join Requerimientos On dr.IdRequerimiento = Requerimientos.IdRequerimiento
			Left Outer Join '+@BasePRONTOMANT+'.dbo.Articulos a On Requerimientos.IdEquipoDestino = a.IdArticulo
			Where a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
	INSERT INTO #Auxiliar2 EXEC sp_executesql @sql1
    END
ELSE
    BEGIN
	INSERT INTO #Auxiliar2 
	 SELECT DISTINCT dp.IdPedido, a.IdArticulo, a.Descripcion, a.NumeroInventario
	 FROM DetallePedidos dp
	 LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = dp.IdPedido
	 LEFT OUTER JOIN DetalleRequerimientos dr ON dp.IdDetalleRequerimiento = dr.IdDetalleRequerimiento
	 LEFT OUTER JOIN Requerimientos ON dr.IdRequerimiento = Requerimientos.IdRequerimiento
	 LEFT OUTER JOIN Articulos a ON Requerimientos.IdEquipoDestino = a.IdArticulo
	 WHERE a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
    END

INSERT INTO #Auxiliar1
 SELECT IdPedido, '' FROM #Auxiliar2 GROUP BY IdPedido

DECLARE @IdArticulo int, @NumeroInventario varchar(20), @Descripcion varchar(256), @Equipos varchar(2000)
SET @Corte=0
SET @Equipos=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPedido, IdArticulo, Descripcion, NumeroInventario FROM #Auxiliar2 ORDER BY IdPedido
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPedido, @IdArticulo, @Descripcion, @NumeroInventario
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdPedido
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar1
			SET Equipos = SUBSTRING(@Equipos,1,2000)
			WHERE #Auxiliar1.IdPedido=@Corte
		SET @Equipos=''
		SET @Corte=@IdPedido
	   END
	IF NOT @NumeroInventario IS NULL
		IF PATINDEX('%'+@NumeroInventario+' '+'%', @Equipos)=0
			SET @Equipos=@Equipos+@NumeroInventario+' '+@Descripcion+' '
	FETCH NEXT FROM Cur INTO @IdPedido, @IdArticulo, @Descripcion, @NumeroInventario
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar1
	SET Equipos = SUBSTRING(@Equipos,1,2000)
	WHERE #Auxiliar1.IdPedido=@Corte
    END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111166666611111111111111111111133'
SET @vector_T='0EQQHBC5555555055955571033311433A8200'

SELECT 
 #Auxiliar21.IdPedido,
 Case When IsNull(Pedidos.PuntoVenta,0)<>0 
	Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
 End as [Pedido],
 Pedidos.FechaPedido [Fecha],
 Pedidos.FechaSalida as [Fecha salida],
 Pedidos.Cumplido as [Cump.],
 #Auxiliar0.Requerimientos as [RM's],
 #Auxiliar0.Obras as [Obras],
 Proveedores.RazonSocial as [Proveedor],
 IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
	IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
	IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0)as [Neto gravado],
 Case When Bonificacion=0 Then Null Else Bonificacion End as [Bonificacion],
 Case When TotalIva1=0 Then Null Else TotalIva1 End as [Total Iva],
 IsNull(Pedidos.ImpuestosInternos,0)+IsNull(Pedidos.OtrosConceptos1,0)+IsNull(Pedidos.OtrosConceptos2,0)+
	IsNull(Pedidos.OtrosConceptos3,0)+IsNull(Pedidos.OtrosConceptos4,0)+IsNull(Pedidos.OtrosConceptos5,0)as [Otros Conceptos],
 TotalPedido as [Total pedido],
 #Auxiliar21.TotalItems*Pedidos.CotizacionMoneda as [Total ped./obra en $],
 Monedas.Nombre as [Moneda],
 E1.Nombre as [Comprador],
 E2.Nombre as [Liberado por],
 Pedidos.IdPedido as [IdAux],
 #Auxiliar21.TotalItems as [Total pedido/obra],
 (Select Count(*) From DetallePedidos 
	Where DetallePedidos.IdPedido=#Auxiliar21.IdPedido) as [Cant.Items],
 NumeroComparativa as [Comparativa],
 Case When Pedidos.TipoCompra=1 Then 'Gestion por compras' When Pedidos.TipoCompra=2 Then 'Gestion por terceros' Else Null End as [Tipo compra],
 Pedidos.Observaciones,
 DetalleCondicionCompra as [Aclaracion s/condicion de compra],
 Case When IsNull(PedidoExterior,'NO')='SI' Then 'SI' Else Null End as [Ext.],
 PedidosAbiertos.NumeroPedidoAbierto as [Pedido abierto],
 Pedidos.NumeroLicitacion as [Nro.Licitacion],
 Pedidos.Impresa as [Impresa],
 Pedidos.UsuarioAnulacion as [Anulo],
 Pedidos.FechaAnulacion as [Fecha anulacion],
 Pedidos.MotivoAnulacion as [Motivo anulacion],
 Pedidos.ImpuestosInternos as [Imp.Internos],
 #Auxiliar1.Equipos as [Equipo destino],
 Pedidos.CircuitoFirmasCompleto as [Circuito de firmas completo],
 DescripcionIva.Descripcion as [Condicion IVA], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar21 
LEFT OUTER JOIN Pedidos ON #Auxiliar21.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador=E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo=E2.IdEmpleado
LEFT OUTER JOIN #Auxiliar0 ON Pedidos.IdPedido=#Auxiliar0.IdPedido
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdPedido=Pedidos.IdPedido
ORDER BY [Pedido]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar20
DROP TABLE #Auxiliar21