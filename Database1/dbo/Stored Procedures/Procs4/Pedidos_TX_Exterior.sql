


CREATE  Procedure [dbo].[Pedidos_TX_Exterior]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 
			(
			 IdPedido INTEGER,
			 Requerimientos VARCHAR(100)
			)

CREATE TABLE #Auxiliar1 
			(
			 IdPedido INTEGER,
			 NumeroRequerimiento INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetPed.IdPedido,
  Case When Requerimientos.NumeroRequerimiento is not null
	Then Requerimientos.NumeroRequerimiento
	Else Acopios.NumeroAcopio
  End
 FROM DetallePedidos DetPed
 LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
 LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
 LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.PedidoExterior,'NO')='SI' and IsNull(Pedidos.Cumplido,'NO')<>'AN'

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPedido,NumeroRequerimiento) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT 
  IdPedido,
  ''
 FROM #Auxiliar1
 GROUP BY IdPedido


/*  CURSOR  */
DECLARE @IdPedido int, @NumeroRequerimiento int, @RMs varchar(100), @Corte int
SET @Corte=0
SET @RMs=''
DECLARE PedReq CURSOR LOCAL FORWARD_ONLY 
	FOR
		SELECT IdPedido, NumeroRequerimiento
		FROM #Auxiliar1
		ORDER BY IdPedido
OPEN PedReq
FETCH NEXT FROM PedReq
	INTO @IdPedido, @NumeroRequerimiento

WHILE @@FETCH_STATUS = 0
 BEGIN
	IF @Corte<>@IdPedido
	 BEGIN
		IF @Corte<>0
		 BEGIN
			UPDATE #Auxiliar0
			SET Requerimientos = SUBSTRING(@RMs,1,100)
			WHERE #Auxiliar0.IdPedido=@Corte
		 END
		SET @RMs=''
		SET @Corte=@IdPedido
	 END
	IF NOT @NumeroRequerimiento IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroRequerimiento)+' '+'%', @RMs)=0
			SET @RMs=@RMs+CONVERT(VARCHAR,@NumeroRequerimiento)+' '
	FETCH NEXT FROM PedReq
		INTO @IdPedido, @NumeroRequerimiento
 END
 IF @Corte<>0
  BEGIN
	UPDATE #Auxiliar0
	SET Requerimientos = SUBSTRING(@RMs,1,100)
	WHERE #Auxiliar0.IdPedido=@Corte
  END
CLOSE PedReq
DEALLOCATE PedReq

SET NOCOUNT OFF

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='01111116666611111111111133'
Set @vector_T='05951E55555505555791033300'

SELECT 
 Pedidos.IdPedido,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 Pedidos.IdPedido as [IdAux1],
 FechaPedido [Fecha],
 Pedidos.Cumplido as [Cump.],
 #Auxiliar0.Requerimientos as [RM's],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When TotalIva2 is null
	 Then TotalPedido-TotalIva1+Bonificacion
	 Else TotalPedido-TotalIva1-TotalIva2+Bonificacion
 End as [Neto gravado],
 Case 	When Bonificacion=0
	 Then Null
	 Else Bonificacion
 End as [Bonificacion],
 Case 	When TotalIva1=0
	 Then Null
	 Else TotalIva1
 End as [Total Iva],
 Case 	When TotalIva2=0
	 Then Null
	 Else TotalIva2
 End as [Total Iva Ad.],
 TotalPedido as [Total pedido],
 Monedas.Nombre as [Moneda],
 (Select Top 1 Empleados.Nombre
  from Empleados
  Where Empleados.IdEmpleado=Pedidos.IdComprador) as [Comprador],
 (Select Top 1 Empleados.Nombre
  from Empleados
  Where Empleados.IdEmpleado=Pedidos.Aprobo) as [Liberado por],
 (Select Count(*) From DetallePedidos 
  Where DetallePedidos.IdPedido=Pedidos.IdPedido) as [Cant.Items],
 NumeroComparativa as [Comparativa],
 Case 	When Pedidos.TipoCompra=1 Then 'Gestion por compras'
	When Pedidos.TipoCompra=2 Then 'Gestion por terceros'
	Else Null
 End as [Tipo compra],
 Pedidos.IdPedido as [IdAux],
 Pedidos.Observaciones,
 DetalleCondicionCompra as [Aclaracion s/condicion de compra],
 Case When IsNull(PedidoExterior,'NO')='SI'
	Then 'SI'
	Else Null
 End as [Ext.],
 PedidosAbiertos.NumeroPedidoAbierto as [Pedido abierto],
 Pedidos.NumeroLicitacion as [Nro.Licitacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Pedidos
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Monedas ON Pedidos.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN PedidosAbiertos ON Pedidos.IdPedidoAbierto=PedidosAbiertos.IdPedidoAbierto
LEFT OUTER JOIN #Auxiliar0 ON Pedidos.IdPedido=#Auxiliar0.IdPedido
 WHERE IsNull(Pedidos.PedidoExterior,'NO')='SI' and IsNull(Pedidos.Cumplido,'NO')<>'AN'
ORDER BY NumeroPedido DESC,SubNumero DESC

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1


