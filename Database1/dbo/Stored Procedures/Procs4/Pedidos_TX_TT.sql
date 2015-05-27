CREATE  Procedure [dbo].[Pedidos_TX_TT]

@IdPedido1 int

AS 

SET NOCOUNT ON

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
			Where Pedidos.IdPedido='+Convert(varchar,@IdPedido1)+' and a.IdArticulo is not null and IsNull(A.ParaMantenimiento,'+''''+''+''''+')='+''''+'SI'+''''+' and IsNull(A.Activo,'+''''+''+''''+')<>'+''''+'NO'+''''
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
	 WHERE Pedidos.IdPedido=@IdPedido1 and a.IdArticulo is not null and IsNull(a.Activo,'')<>'NO' and IsNull(a.ParaMantenimiento,'SI')='SI' 
    END

INSERT INTO #Auxiliar1
 SELECT IdPedido, '' FROM #Auxiliar2 GROUP BY IdPedido

DECLARE @IdPedido int, @IdArticulo int, @NumeroInventario varchar(20), @Descripcion varchar(256), @Equipos varchar(2000), @Corte int
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
SET @vector_X='01111111666661111111111111111111111133'
SET @vector_T='0EQQHBC555555055595G1033311433A8242G00'

SELECT 
 Pedidos.IdPedido,
 Case When IsNull(Pedidos.PuntoVenta,0)<>0 
	Then Substring('0000',1,4-Len(Convert(varchar,IsNull(Pedidos.PuntoVenta,0))))+Convert(varchar,IsNull(Pedidos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
	Else Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido)+
		IsNull(' / '+Convert(varchar,Pedidos.SubNumero),'')
 End as [Pedido],
 FechaPedido [Fecha],
 Pedidos.FechaSalida as [Fecha salida],
 Pedidos.Cumplido as [Cump.],
 dbo.Pedidos_Requerimientos(Pedidos.IdPedido) as [RM's],
 dbo.Pedidos_Obras(Pedidos.IdPedido) as [Obras],
 Proveedores.RazonSocial as [Proveedor],
 IsNull(Pedidos.TotalPedido,0)-IsNull(Pedidos.TotalIva1,0)+IsNull(Pedidos.Bonificacion,0)-
	IsNull(Pedidos.ImpuestosInternos,0)-IsNull(Pedidos.OtrosConceptos1,0)-IsNull(Pedidos.OtrosConceptos2,0)-
	IsNull(Pedidos.OtrosConceptos3,0)-IsNull(Pedidos.OtrosConceptos4,0)-IsNull(Pedidos.OtrosConceptos5,0)as [Neto gravado],
 Case When Bonificacion=0 Then Null Else Bonificacion End as [Bonificacion],
 Case When TotalIva1=0 Then Null Else TotalIva1 End as [Total Iva],
 IsNull(Pedidos.ImpuestosInternos,0)+IsNull(Pedidos.OtrosConceptos1,0)+IsNull(Pedidos.OtrosConceptos2,0)+
	IsNull(Pedidos.OtrosConceptos3,0)+IsNull(Pedidos.OtrosConceptos4,0)+IsNull(Pedidos.OtrosConceptos5,0)as [Otros Conceptos],
 TotalPedido as [Total pedido],
 Monedas.Nombre as [Moneda],
 E1.Nombre as [Comprador],
 E2.Nombre as [Liberado por],
 (Select Count(*) From DetallePedidos Where DetallePedidos.IdPedido=Pedidos.IdPedido) as [Cant.Items],
 Pedidos.IdPedido as [IdAux],
 NumeroComparativa as [Comparativa],
 TiposCompra.Descripcion as [Tipo compra RM],
-- Case When Pedidos.TipoCompra=1 Then 'Gestion por compras' When Pedidos.TipoCompra=2 Then 'Gestion por terceros' Else Null End as [Tipo compra],
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
 Pedidos.FechaEnvioProveedor as [Fecha envio proveedor],
 E3.Nombre as [Envio a proveedor],
 dbo.Pedidos_ItemsConCambioCosto(Pedidos.IdPedido) as [Items con cambios de costo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN Empleados E1 ON Pedidos.IdComprador=E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON Pedidos.Aprobo=E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON Pedidos.IdUsuarioEnvioProveedor=E3.IdEmpleado
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN TiposCompra ON Pedidos.IdTipoCompraRM = TiposCompra.IdTipoCompra
WHERE (Pedidos.IdPedido=@IdPedido1)

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2