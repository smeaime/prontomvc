
CREATE Procedure [dbo].[Pedidos_TX_PorFechaVencimiento]

AS 

SET NOCOUNT ON

DECLARE @Fecha datetime, @IdPedido int, @IdPedido2 int, @ImporteCuota numeric(18,2), @SaldoCuota numeric(18,2), @IdAux int, 
	@ImporteItemEntrega numeric(18,2), @SaldoAAplicar numeric(18,2), @SaldoAplicado numeric(18,2)

SET @Fecha=Getdate()

-- DETERMINACION DEL IMPORTE TOTAL SEGUN ENTREGAS --
CREATE TABLE #Auxiliar1 
			(
			 IdDetallePedido INTEGER,
			 IdPedido INTEGER,
			 CantidadPedido NUMERIC(15, 2),
			 CantidadEntrega NUMERIC(15, 2),
			 ImporteItemPedido NUMERIC(15, 2),
			 ImporteItemPedidoNeto NUMERIC(15, 2),
			 ImporteItemEntrega NUMERIC(15, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Det.IdDetallePedido,
  Det.IdPedido,
  IsNull(Det.Cantidad,0),
  IsNull((Select Sum(IsNull(DetRec.Cantidad,0))
		From DetalleRecepciones DetRec
		Left Outer Join Recepciones On DetRec.IdRecepcion = Recepciones.IdRecepcion
		Where Det.IdDetallePedido=DetRec.IdDetallePedido and IsNull(Recepciones.Anulada,'')<>'SI'),0),
  (IsNull(Det.Cantidad,0)*IsNull(Det.Precio,0))-IsNull(Det.ImporteBonificacion,0),
  0,
  0
 FROM DetallePedidos Det 
 WHERE IsNull(Det.Cumplido,'')<>'SI' and IsNull(Det.Cumplido,'')<>'AN'

CREATE TABLE #Auxiliar2 (IdPedido INTEGER, ImporteItemPedido NUMERIC(15, 2), ImportePedido NUMERIC(15, 2))
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdPedido, Sum(ImporteItemPedido), Pedidos.TotalPedido
 FROM #Auxiliar1
 LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=#Auxiliar1.IdPedido
 GROUP BY #Auxiliar1.IdPedido, Pedidos.TotalPedido

UPDATE #Auxiliar1
SET ImporteItemPedidoNeto=IsNull((Select Top 1 ImportePedido From #Auxiliar2 Where #Auxiliar2.IdPedido=#Auxiliar1.IdPedido),0) / 
				IsNull((Select Top 1 ImporteItemPedido From #Auxiliar2 Where #Auxiliar2.IdPedido=#Auxiliar1.IdPedido),0) * 
				#Auxiliar1.ImporteItemPedido

UPDATE #Auxiliar1
SET ImporteItemEntrega=ImporteItemPedidoNeto/CantidadPedido*CantidadEntrega
WHERE CantidadPedido<>0

CREATE TABLE #Auxiliar3 (IdPedido INTEGER, ImporteItemEntrega NUMERIC(15, 2))
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdPedido) ON [PRIMARY]
INSERT INTO #Auxiliar3
 SELECT #Auxiliar1.IdPedido, Sum(ImporteItemEntrega)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdPedido


-- DISTRIBUCION DE IMPORTE DEL PEDIDO EN CUOTAS SEGUN CONDICION DE COMPRA --
CREATE TABLE #Auxiliar5 
			(
			 IdPedido INTEGER,
			 Fecha DATETIME,
			 IdCondicionCompra INTEGER,
			 ImporteCuota NUMERIC(15, 2),
			 SaldoCuota NUMERIC(15, 2),
			 Dias INTEGER,
			 Meses INTEGER,
			 IdAux INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdPedido, IdAux) ON [PRIMARY]
INSERT INTO #Auxiliar5 
 SELECT 
  Pedidos.IdPedido,
  Case When IsNull(Tmp.Dias,0)=0 and IsNull(Tmp.Porcentaje,100)=100
	Then Pedidos.FechaPedido
	Else DateAdd(day,IsNull(Tmp.Dias,0),Pedidos.FechaPedido)
  End,
  Pedidos.IdCondicionCompra,
  Pedidos.TotalPedido * IsNull(Tmp.Porcentaje,100)/100,
  Pedidos.TotalPedido * IsNull(Tmp.Porcentaje,100)/100,
  0,
  0,
  IsNull(Tmp.IdAux,0)
 FROM Pedidos 
 LEFT OUTER JOIN _TempCondicionesCompra Tmp ON Pedidos.IdCondicionCompra=Tmp.IdCondicionCompra
 LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
 WHERE IsNull(Pedidos.Cumplido,'')<>'SI' and IsNull(Pedidos.Cumplido,'')<>'AN'

UPDATE #Auxiliar5
SET Dias=DATEDIFF(day,Fecha,@Fecha), Meses=DATEDIFF(m,@Fecha,Fecha)


-- CALCULO DE SALDOS POR CUOTA --
DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdPedido, ImporteItemEntrega
		FROM #Auxiliar3
		WHERE ImporteItemEntrega<>0
		ORDER BY IdPedido
OPEN Cur1
FETCH NEXT FROM Cur1 INTO @IdPedido, @ImporteItemEntrega
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @SaldoAAplicar=@ImporteItemEntrega

	DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdPedido, ImporteCuota, SaldoCuota
			FROM #Auxiliar5
			WHERE IdPedido=@IdPedido and SaldoCuota<>0
			ORDER BY IdPedido 
	OPEN Cur2
	FETCH NEXT FROM Cur2 INTO @IdPedido2, @ImporteCuota, @SaldoCuota
	WHILE @@FETCH_STATUS = 0 and not @SaldoAAplicar=0
	   BEGIN
		IF @SaldoAAplicar>=@SaldoCuota
		   BEGIN
			SET @SaldoAAplicar=@SaldoAAplicar-@SaldoCuota
			SET @SaldoAplicado=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicado=@SaldoCuota-@SaldoAAplicar
			SET @SaldoAAplicar=0
		   END

		   BEGIN
			UPDATE #Auxiliar5
			SET SaldoCuota = @SaldoAplicado
			WHERE CURRENT OF Cur2
		   END
		FETCH NEXT FROM Cur2 INTO @IdPedido2, @ImporteCuota, @SaldoCuota
	   END
	CLOSE Cur2
	DEALLOCATE Cur2

	FETCH NEXT FROM Cur1 INTO @IdPedido, @ImporteItemEntrega
   END
CLOSE Cur1
DEALLOCATE Cur1

CREATE TABLE #Auxiliar6 (Meses INTEGER)
INSERT INTO #Auxiliar6 
 SELECT #Auxiliar5.Meses
 FROM #Auxiliar5
 GROUP BY #Auxiliar5.Meses

DECLARE @vector_X varchar(100), @vector_T varchar(100), @vector_E varchar(1000), @Contador int
SET @vector_X='000000111116611666666666666666666666666666133'
SET @vector_T='000000000043333'
SET @vector_E='  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  '
SET @Contador=-13
WHILE @Contador<=13
    BEGIN
	IF @Contador=-13
	    BEGIN
		IF Exists(Select Top 1 Meses FROM #Auxiliar6 Where Meses<=-13)
			SET @vector_T=@vector_T+'2'
		ELSE
			SET @vector_T=@vector_T+'9'
	    END
	ELSE
		IF @Contador=13
		    BEGIN
			IF Exists(Select Top 1 Meses FROM #Auxiliar6 Where Meses>=13)
				SET @vector_T=@vector_T+'2'
			ELSE
				SET @vector_T=@vector_T+'9'
		    END
		ELSE
		    BEGIN
			IF Exists(Select Top 1 Meses FROM #Auxiliar6 Where Meses=@Contador)
				SET @vector_T=@vector_T+'2'
			ELSE
				SET @vector_T=@vector_T+'9'
		    END
	SET @Contador=@Contador+1
    END

SET @vector_T=@vector_T+'900'

DELETE FROM #Auxiliar5
WHERE IsNull(SaldoCuota,0)=0

SET NOCOUNT OFF

SELECT 
 0 as [IdAux],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 Null as [K_FechaVencimiento],
 0 as [K_Orden],
 Paises.Descripcion as [K_Pais],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.RazonSocial as [Proveedor],
 Paises.Descripcion as [Pais],
 Null as [Comprobante],
 Null as [Fecha vto.],
 Null as [Importe],
 Null as [Saldo],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 Null as [-99],
 Null as [-12],
 Null as [-11],
 Null as [-10],
 Null as [-9],
 Null as [-8],
 Null as [-7],
 Null as [-6],
 Null as [-5],
 Null as [-4],
 Null as [-3],
 Null as [-2],
 Null as [-1],
 Null as [0],
 Null as [+1],
 Null as [+2],
 Null as [+3],
 Null as [+4],
 Null as [+5],
 Null as [+6],
 Null as [+7],
 Null as [+8],
 Null as [+9],
 Null as [+10],
 Null as [+11],
 Null as [+12],
 Null as [+99],
 ' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar5
LEFT OUTER JOIN Pedidos ON #Auxiliar5.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Paises ON Proveedores.IdPais=Paises.IdPais
GROUP BY Proveedores.CodigoEmpresa, Proveedores.RazonSocial, Paises.Descripcion

UNION ALL 

SELECT 
 0 as [IdAux],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 #Auxiliar5.Fecha as [K_FechaVencimiento],
 1 as [K_Orden],
 Paises.Descripcion as [K_Pais],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.RazonSocial as [Proveedor],
 Paises.Descripcion as [Pais],
 'PE '+Substring('00000000',1,8-Len(Convert(varchar,Pedidos.NumeroPedido)))+Convert(varchar,Pedidos.NumeroPedido) as [Comprobante],
 #Auxiliar5.Fecha as [Fecha vto.],
 #Auxiliar5.ImporteCuota as [Importe],
 Case When #Auxiliar5.SaldoCuota>=0 Then #Auxiliar5.SaldoCuota Else Null End as [Saldo],
 Case When #Auxiliar5.Dias>=0 Then #Auxiliar5.Dias Else Null End as [Ds.Venc.],
 Case When #Auxiliar5.Dias>=0 Then Null Else #Auxiliar5.Dias * -1 End as [Ds.A Vencer],
 Case When #Auxiliar5.Meses<-12 Then #Auxiliar5.SaldoCuota Else Null End as [-99],
 Case When #Auxiliar5.Meses=-12 Then #Auxiliar5.SaldoCuota Else Null End as [-12],
 Case When #Auxiliar5.Meses=-11 Then #Auxiliar5.SaldoCuota Else Null End as [-11],
 Case When #Auxiliar5.Meses=-10 Then #Auxiliar5.SaldoCuota Else Null End as [-10],
 Case When #Auxiliar5.Meses=-9 Then #Auxiliar5.SaldoCuota Else Null End as [-9],
 Case When #Auxiliar5.Meses=-8 Then #Auxiliar5.SaldoCuota Else Null End as [-8],
 Case When #Auxiliar5.Meses=-7 Then #Auxiliar5.SaldoCuota Else Null End as [-7],
 Case When #Auxiliar5.Meses=-6 Then #Auxiliar5.SaldoCuota Else Null End as [-6],
 Case When #Auxiliar5.Meses=-5 Then #Auxiliar5.SaldoCuota Else Null End as [-5],
 Case When #Auxiliar5.Meses=-4 Then #Auxiliar5.SaldoCuota Else Null End as [-4],
 Case When #Auxiliar5.Meses=-3 Then #Auxiliar5.SaldoCuota Else Null End as [-3],
 Case When #Auxiliar5.Meses=-2 Then #Auxiliar5.SaldoCuota Else Null End as [-2],
 Case When #Auxiliar5.Meses=-1 Then #Auxiliar5.SaldoCuota Else Null End as [-1],
 Case When #Auxiliar5.Meses=0 Then #Auxiliar5.SaldoCuota Else Null End as [0],
 Case When #Auxiliar5.Meses=1 Then #Auxiliar5.SaldoCuota Else Null End as [+1],
 Case When #Auxiliar5.Meses=2 Then #Auxiliar5.SaldoCuota Else Null End as [+2],
 Case When #Auxiliar5.Meses=3 Then #Auxiliar5.SaldoCuota Else Null End as [+3],
 Case When #Auxiliar5.Meses=4 Then #Auxiliar5.SaldoCuota Else Null End as [+4],
 Case When #Auxiliar5.Meses=5 Then #Auxiliar5.SaldoCuota Else Null End as [+5],
 Case When #Auxiliar5.Meses=6 Then #Auxiliar5.SaldoCuota Else Null End as [+6],
 Case When #Auxiliar5.Meses=7 Then #Auxiliar5.SaldoCuota Else Null End as [+7],
 Case When #Auxiliar5.Meses=8 Then #Auxiliar5.SaldoCuota Else Null End as [+8],
 Case When #Auxiliar5.Meses=9 Then #Auxiliar5.SaldoCuota Else Null End as [+9],
 Case When #Auxiliar5.Meses=10 Then #Auxiliar5.SaldoCuota Else Null End as [+10],
 Case When #Auxiliar5.Meses=11 Then #Auxiliar5.SaldoCuota Else Null End as [+11],
 Case When #Auxiliar5.Meses=12 Then #Auxiliar5.SaldoCuota Else Null End as [+12],
 Case When #Auxiliar5.Meses>12 Then #Auxiliar5.SaldoCuota Else Null End as [+99],
 @vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar5
LEFT OUTER JOIN Pedidos ON #Auxiliar5.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Paises ON Proveedores.IdPais=Paises.IdPais

UNION ALL

SELECT 
 0 as [IdAux],
 'zzzzz' as [K_Codigo],
 'zzzzz' as [K_Proveedor],
 Null as [K_FechaVencimiento],
 6 as [K_Orden],
 Paises.Descripcion as [K_Pais],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Pais],
 Null as [Comprobante],
 Null as [Fecha vto.],
 Null as [Importe],
 Null as [Saldo],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 Null as [-99],
 Null as [-12],
 Null as [-11],
 Null as [-10],
 Null as [-9],
 Null as [-8],
 Null as [-7],
 Null as [-6],
 Null as [-5],
 Null as [-4],
 Null as [-3],
 Null as [-2],
 Null as [-1],
 Null as [0],
 Null as [+1],
 Null as [+2],
 Null as [+3],
 Null as [+4],
 Null as [+5],
 Null as [+6],
 Null as [+7],
 Null as [+8],
 Null as [+9],
 Null as [+10],
 Null as [+11],
 Null as [+12],
 Null as [+99],
 @vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar5
LEFT OUTER JOIN Pedidos ON #Auxiliar5.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Paises ON Proveedores.IdPais=Paises.IdPais
GROUP BY Paises.Descripcion

UNION ALL

SELECT 
 0 as [IdAux],
 'zzzzz' as [K_Codigo],
 'zzzzz' as [K_Proveedor],
 Null as [K_FechaVencimiento],
 7 as [K_Orden],
 Paises.Descripcion as [K_Pais],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Pais],
 'TOTAL '+IsNull(Paises.Descripcion,'') as [Comprobante],
 Null as [Fecha vto.],
 SUM(#Auxiliar5.ImporteCuota) as [Importe],
 SUM(Case When #Auxiliar5.SaldoCuota>=0 Then #Auxiliar5.SaldoCuota Else 0 End) as [Saldo],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 SUM(Case When #Auxiliar5.Meses<-12 Then #Auxiliar5.SaldoCuota Else 0 End) as [-99],
 SUM(Case When #Auxiliar5.Meses=-12 Then #Auxiliar5.SaldoCuota Else 0 End) as [-12],
 SUM(Case When #Auxiliar5.Meses=-11 Then #Auxiliar5.SaldoCuota Else 0 End) as [-11],
 SUM(Case When #Auxiliar5.Meses=-10 Then #Auxiliar5.SaldoCuota Else 0 End) as [-10],
 SUM(Case When #Auxiliar5.Meses=-9 Then #Auxiliar5.SaldoCuota Else 0 End) as [-9],
 SUM(Case When #Auxiliar5.Meses=-8 Then #Auxiliar5.SaldoCuota Else 0 End) as [-8],
 SUM(Case When #Auxiliar5.Meses=-7 Then #Auxiliar5.SaldoCuota Else 0 End) as [-7],
 SUM(Case When #Auxiliar5.Meses=-6 Then #Auxiliar5.SaldoCuota Else 0 End) as [-6],
 SUM(Case When #Auxiliar5.Meses=-5 Then #Auxiliar5.SaldoCuota Else 0 End) as [-5],
 SUM(Case When #Auxiliar5.Meses=-4 Then #Auxiliar5.SaldoCuota Else 0 End) as [-4],
 SUM(Case When #Auxiliar5.Meses=-3 Then #Auxiliar5.SaldoCuota Else 0 End) as [-3],
 SUM(Case When #Auxiliar5.Meses=-2 Then #Auxiliar5.SaldoCuota Else 0 End) as [-2],
 SUM(Case When #Auxiliar5.Meses=-1 Then #Auxiliar5.SaldoCuota Else 0 End) as [-1],
 SUM(Case When #Auxiliar5.Meses=0 Then #Auxiliar5.SaldoCuota Else 0 End) as [0],
 SUM(Case When #Auxiliar5.Meses=1 Then #Auxiliar5.SaldoCuota Else 0 End) as [+1],
 SUM(Case When #Auxiliar5.Meses=2 Then #Auxiliar5.SaldoCuota Else 0 End) as [+2],
 SUM(Case When #Auxiliar5.Meses=3 Then #Auxiliar5.SaldoCuota Else 0 End) as [+3],
 SUM(Case When #Auxiliar5.Meses=4 Then #Auxiliar5.SaldoCuota Else 0 End) as [+4],
 SUM(Case When #Auxiliar5.Meses=5 Then #Auxiliar5.SaldoCuota Else 0 End) as [+5],
 SUM(Case When #Auxiliar5.Meses=6 Then #Auxiliar5.SaldoCuota Else 0 End) as [+6],
 SUM(Case When #Auxiliar5.Meses=7 Then #Auxiliar5.SaldoCuota Else 0 End) as [+7],
 SUM(Case When #Auxiliar5.Meses=8 Then #Auxiliar5.SaldoCuota Else 0 End) as [+8],
 SUM(Case When #Auxiliar5.Meses=9 Then #Auxiliar5.SaldoCuota Else 0 End) as [+9],
 SUM(Case When #Auxiliar5.Meses=10 Then #Auxiliar5.SaldoCuota Else 0 End) as [+10],
 SUM(Case When #Auxiliar5.Meses=11 Then #Auxiliar5.SaldoCuota Else 0 End) as [+11],
 SUM(Case When #Auxiliar5.Meses=12 Then #Auxiliar5.SaldoCuota Else 0 End) as [+12],
 SUM(Case When #Auxiliar5.Meses>12 Then #Auxiliar5.SaldoCuota Else 0 End) as [+99],
 ' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar5
LEFT OUTER JOIN Pedidos ON #Auxiliar5.IdPedido=Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Pedidos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Paises ON Proveedores.IdPais=Paises.IdPais
GROUP BY Paises.Descripcion

UNION ALL

SELECT 
 0 as [IdAux],
 'zzzzz' as [K_Codigo],
 'zzzzz' as [K_Proveedor],
 Null as [K_FechaVencimiento],
 8 as [K_Orden],
 'zzzzz' as [K_Pais],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Pais],
 Null as [Comprobante],
 Null as [Fecha vto.],
 Null as [Importe],
 Null as [Saldo],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 Null as [-99],
 Null as [-12],
 Null as [-11],
 Null as [-10],
 Null as [-9],
 Null as [-8],
 Null as [-7],
 Null as [-6],
 Null as [-5],
 Null as [-4],
 Null as [-3],
 Null as [-2],
 Null as [-1],
 Null as [0],
 Null as [+1],
 Null as [+2],
 Null as [+3],
 Null as [+4],
 Null as [+5],
 Null as [+6],
 Null as [+7],
 Null as [+8],
 Null as [+9],
 Null as [+10],
 Null as [+11],
 Null as [+12],
 Null as [+99],
 @vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL

SELECT 
 0 as [IdAux],
 'zzzzz' as [K_Codigo],
 'zzzzz' as [K_Proveedor],
 Null as [K_FechaVencimiento],
 9 as [K_Orden],
 'zzzzz' as [K_Pais],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Pais],
 'TOTAL GENERAL' as [Comprobante],
 Null as [Fecha vto.],
 SUM(#Auxiliar5.ImporteCuota) as [Importe],
 SUM(Case When #Auxiliar5.SaldoCuota>=0 Then #Auxiliar5.SaldoCuota Else 0 End) as [Saldo],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 SUM(Case When #Auxiliar5.Meses<-12 Then #Auxiliar5.SaldoCuota Else 0 End) as [-99],
 SUM(Case When #Auxiliar5.Meses=-12 Then #Auxiliar5.SaldoCuota Else 0 End) as [-12],
 SUM(Case When #Auxiliar5.Meses=-11 Then #Auxiliar5.SaldoCuota Else 0 End) as [-11],
 SUM(Case When #Auxiliar5.Meses=-10 Then #Auxiliar5.SaldoCuota Else 0 End) as [-10],
 SUM(Case When #Auxiliar5.Meses=-9 Then #Auxiliar5.SaldoCuota Else 0 End) as [-9],
 SUM(Case When #Auxiliar5.Meses=-8 Then #Auxiliar5.SaldoCuota Else 0 End) as [-8],
 SUM(Case When #Auxiliar5.Meses=-7 Then #Auxiliar5.SaldoCuota Else 0 End) as [-7],
 SUM(Case When #Auxiliar5.Meses=-6 Then #Auxiliar5.SaldoCuota Else 0 End) as [-6],
 SUM(Case When #Auxiliar5.Meses=-5 Then #Auxiliar5.SaldoCuota Else 0 End) as [-5],
 SUM(Case When #Auxiliar5.Meses=-4 Then #Auxiliar5.SaldoCuota Else 0 End) as [-4],
 SUM(Case When #Auxiliar5.Meses=-3 Then #Auxiliar5.SaldoCuota Else 0 End) as [-3],
 SUM(Case When #Auxiliar5.Meses=-2 Then #Auxiliar5.SaldoCuota Else 0 End) as [-2],
 SUM(Case When #Auxiliar5.Meses=-1 Then #Auxiliar5.SaldoCuota Else 0 End) as [-1],
 SUM(Case When #Auxiliar5.Meses=0 Then #Auxiliar5.SaldoCuota Else 0 End) as [0],
 SUM(Case When #Auxiliar5.Meses=1 Then #Auxiliar5.SaldoCuota Else 0 End) as [+1],
 SUM(Case When #Auxiliar5.Meses=2 Then #Auxiliar5.SaldoCuota Else 0 End) as [+2],
 SUM(Case When #Auxiliar5.Meses=3 Then #Auxiliar5.SaldoCuota Else 0 End) as [+3],
 SUM(Case When #Auxiliar5.Meses=4 Then #Auxiliar5.SaldoCuota Else 0 End) as [+4],
 SUM(Case When #Auxiliar5.Meses=5 Then #Auxiliar5.SaldoCuota Else 0 End) as [+5],
 SUM(Case When #Auxiliar5.Meses=6 Then #Auxiliar5.SaldoCuota Else 0 End) as [+6],
 SUM(Case When #Auxiliar5.Meses=7 Then #Auxiliar5.SaldoCuota Else 0 End) as [+7],
 SUM(Case When #Auxiliar5.Meses=8 Then #Auxiliar5.SaldoCuota Else 0 End) as [+8],
 SUM(Case When #Auxiliar5.Meses=9 Then #Auxiliar5.SaldoCuota Else 0 End) as [+9],
 SUM(Case When #Auxiliar5.Meses=10 Then #Auxiliar5.SaldoCuota Else 0 End) as [+10],
 SUM(Case When #Auxiliar5.Meses=11 Then #Auxiliar5.SaldoCuota Else 0 End) as [+11],
 SUM(Case When #Auxiliar5.Meses=12 Then #Auxiliar5.SaldoCuota Else 0 End) as [+12],
 SUM(Case When #Auxiliar5.Meses>12 Then #Auxiliar5.SaldoCuota Else 0 End) as [+99],
 ' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar5

ORDER BY [K_Pais], [K_Proveedor],[K_Codigo],[K_Orden],[K_FechaVencimiento]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
