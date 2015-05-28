
CREATE Procedure [dbo].[Pedidos_TX_DetallesPedidosRecepcionesPorObra]

@Desde datetime,
@Hasta datetime,
@IdObra int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetallePedido INTEGER,
			 NumeroPedido1 INTEGER,
			 SubNumero1 INTEGER,
			 NumeroItem1 INTEGER,
			 Posicion INTEGER,
			 NumeroPedido2 INTEGER,
			 SubNumero2 INTEGER,
			 NumeroItem2 INTEGER,
			 Proveedor VARCHAR(50),
			 Codigo VARCHAR(20),
			 Material VARCHAR(300),
			 CantidadPedida NUMERIC(18,2),
			 Unidad VARCHAR(15),
			 Rubro VARCHAR(50),
			 FechaNecesidad DATETIME,
			 FechaPromesa DATETIME,
			 IdDetalleRecepcion INTEGER
			)
CREATE TABLE #Auxiliar2 
			(
			 IdDetallePedido INTEGER,
			 NumeroPedido INTEGER,
			 SubNumero INTEGER,
			 NumeroItem INTEGER,
			 Proveedor VARCHAR(50),
			 Codigo VARCHAR(20),
			 Material VARCHAR(300),
			 CantidadPedida NUMERIC(18,2),
			 Unidad VARCHAR(15),
			 Rubro VARCHAR(50),
			 FechaNecesidad DATETIME,
			 FechaPromesa DATETIME
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdDetallePedido) ON [PRIMARY]
CREATE TABLE #Auxiliar3 
			(
			 IdDetalleRecepcion INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdDetalleRecepcion) ON [PRIMARY]

INSERT INTO #Auxiliar2 
 SELECT Det.IdDetallePedido, Pedidos.NumeroPedido, Pedidos.SubNumero, Det.NumeroItem, Proveedores.RazonSocial, Articulos.Codigo, 
	Substring(IsNull(Articulos.Descripcion,''),1,300), IsNull(Det.Cantidad,0), Unidades.Abreviatura, Rubros.Descripcion, 
	Det.FechaNecesidad, Det.FechaEntrega
 FROM DetallePedidos Det
 LEFT OUTER JOIN Pedidos ON Det.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = Pedidos.IdProveedor
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Det.IdArticulo
 LEFT OUTER JOIN Rubros ON Rubros.IdRubro = Articulos.IdRubro
 LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = Det.IdUnidad
 LEFT OUTER JOIN DetalleRequerimientos ON Det.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(Det.Cumplido,'NO')<>'AN' and (@IdObra=-1 or Requerimientos.IdObra=@IdObra) and 
	Pedidos.FechaPedido Between @Desde And @Hasta

/*  CURSOR  */
DECLARE @IdDetallePedido int, @NumeroPedido int, @SubNumero int, @NumeroItem int, @Proveedor varchar(50), @Codigo varchar(20), 
	@Material varchar(300), @CantidadPedida numeric(18,2), @Unidad varchar(15), @Rubro varchar(50), @FechaNecesidad datetime, 
	@FechaPromesa datetime, @IdDetalleRecepcion int, @Renglon int

DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdDetallePedido, NumeroPedido, SubNumero, NumeroItem, Proveedor, Codigo, Material, CantidadPedida, 
			Unidad, Rubro, FechaNecesidad, FechaPromesa
		FROM #Auxiliar2
		ORDER BY IdDetallePedido
OPEN Cur1
FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @NumeroPedido, @SubNumero, @NumeroItem, @Proveedor, @Codigo, @Material, @CantidadPedida, 
			@Unidad, @Rubro, @FechaNecesidad, @FechaPromesa
WHILE @@FETCH_STATUS = 0
   BEGIN
	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 
	 SELECT Det.IdDetalleRecepcion
	 FROM DetalleRecepciones Det
	 WHERE Det.IdDetallePedido=@IdDetallePedido

	SET @Renglon=1

	IF IsNull((Select Count(*) From #Auxiliar3),0)>0
	   BEGIN
		DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleRecepcion FROM #Auxiliar3 ORDER BY IdDetalleRecepcion
		OPEN Cur2
		FETCH NEXT FROM Cur2 INTO @IdDetalleRecepcion
		WHILE @@FETCH_STATUS = 0
		   BEGIN
			IF @Renglon=1
				INSERT INTO #Auxiliar1 
				(IdDetallePedido, NumeroPedido1, SubNumero1, NumeroItem1, Posicion, NumeroPedido2, SubNumero2, NumeroItem2, 
				 Proveedor, Codigo, Material, CantidadPedida, Unidad, Rubro, FechaNecesidad, FechaPromesa, IdDetalleRecepcion)
				VALUES
				(@IdDetallePedido, @NumeroPedido, @SubNumero, @NumeroItem, @Renglon, @NumeroPedido, @SubNumero, @NumeroItem, 
				 @Proveedor, @Codigo, @Material, @CantidadPedida, @Unidad, @Rubro, @FechaNecesidad, @FechaPromesa, @IdDetalleRecepcion)
			ELSE
				INSERT INTO #Auxiliar1 
				(IdDetallePedido, NumeroPedido1, SubNumero1, NumeroItem1, Posicion, NumeroPedido2, SubNumero2, NumeroItem2, 
				 Proveedor, Codigo, Material, CantidadPedida, Unidad, Rubro, FechaNecesidad, FechaPromesa, IdDetalleRecepcion)
				VALUES
				(@IdDetallePedido, @NumeroPedido, @SubNumero, @NumeroItem, @Renglon, Null, Null, Null, 
				 Null, Null, Null, Null, Null, Null, Null, @FechaPromesa, @IdDetalleRecepcion)
	
			SET @Renglon=@Renglon+1
			FETCH NEXT FROM Cur2 INTO @IdDetalleRecepcion
		   END
		CLOSE Cur2
		DEALLOCATE Cur2
	   END
	ELSE
	   BEGIN
		INSERT INTO #Auxiliar1 
		(IdDetallePedido, NumeroPedido1, SubNumero1, NumeroItem1, Posicion, NumeroPedido2, SubNumero2, NumeroItem2, 
		 Proveedor, Codigo, Material, CantidadPedida, Unidad, Rubro, FechaNecesidad, FechaPromesa, IdDetalleRecepcion)
		VALUES
		(@IdDetallePedido, @NumeroPedido, @SubNumero, @NumeroItem, @Renglon, @NumeroPedido, @SubNumero, @NumeroItem, 
		 @Proveedor, @Codigo, @Material, @CantidadPedida, @Unidad, @Rubro, @FechaNecesidad, @FechaPromesa, Null)

	   END

	FETCH NEXT FROM Cur1 INTO @IdDetallePedido, @NumeroPedido, @SubNumero, @NumeroItem, @Proveedor, @Codigo, @Material, @CantidadPedida, 
				@Unidad, @Rubro, @FechaNecesidad, @FechaPromesa
   END
CLOSE Cur1
DEALLOCATE Cur1

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111111111133'
SET @vector_T='0200923D20144444E12204400'

SELECT 
 #Auxiliar1.IdDetallePedido as [IdAux],
 #Auxiliar1.NumeroPedido1 as [Pedido],
 #Auxiliar1.SubNumero1 as [Sub],
 #Auxiliar1.NumeroItem1 as [Item],
 #Auxiliar1.Posicion as [Pos.],
 #Auxiliar1.Proveedor as [Proveedor],
 #Auxiliar1.Codigo as [Codigo],
 #Auxiliar1.Material as [Material],
 #Auxiliar1.CantidadPedida as [Cant.],
 #Auxiliar1.Unidad as [Un.],
 #Auxiliar1.Rubro as [Rubro],
 #Auxiliar1.FechaNecesidad as [Fecha necesidad],
 #Auxiliar1.FechaPromesa as [Fecha promesa],
 Recepciones.FechaRecepcion as [Fecha entrega],
 Case When Recepciones.FechaRecepcion is null Then Null
	When Datediff(d,#Auxiliar1.FechaPromesa,Recepciones.FechaRecepcion)<=0 Then Abs(Datediff(d,#Auxiliar1.FechaPromesa,Recepciones.FechaRecepcion))
	Else Null
 End as [En termino],
 Case When Recepciones.FechaRecepcion is null Then Null
	When Datediff(d,#Auxiliar1.FechaPromesa,Recepciones.FechaRecepcion)>0 Then Datediff(d,#Auxiliar1.FechaPromesa,Recepciones.FechaRecepcion)
	Else Null
 End as [Fuera de termino],
 Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2) as [Recepcion],
 E1.Nombre as [Realizo],
 Recepciones.Observaciones as [Observaciones],
 DetalleRecepciones.Cantidad as [Cant.Rec.],
 Unidades.Abreviatura as [Un.Rec.],
 DetalleRecepciones.CostoUnitario*IsNull(DetalleRecepciones.CotizacionMoneda,1) as [Prec.Un.],
 DetalleRecepciones.Cantidad*DetalleRecepciones.CostoUnitario*IsNull(DetalleRecepciones.CotizacionMoneda,1) as [Total Item],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN DetalleRecepciones ON DetalleRecepciones.IdDetalleRecepcion = #Auxiliar1.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON Recepciones.IdRecepcion = DetalleRecepciones.IdRecepcion
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Recepciones.Realizo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = DetalleRecepciones.IdUnidad
ORDER BY #Auxiliar1.NumeroPedido1, #Auxiliar1.SubNumero1, #Auxiliar1.NumeroItem1, #Auxiliar1.Posicion

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
