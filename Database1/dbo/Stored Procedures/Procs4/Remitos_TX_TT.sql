CREATE  Procedure [dbo].[Remitos_TX_TT]

@IdRemito int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdRemito INTEGER,
			 Obras VARCHAR(100)
			)

CREATE TABLE #Auxiliar2 
			(
			 IdRemito INTEGER,
			 NumeroObra VARCHAR(13)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdRemito,NumeroObra) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT Det.IdRemito, Obras.NumeroObra
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Det.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Obras ON Det.IdObra = Obras.IdObra
 WHERE Remitos.IdRemito=@IdRemito

INSERT INTO #Auxiliar1
 SELECT IdRemito, '' FROM #Auxiliar2 GROUP BY IdRemito

/*  CURSOR  */
DECLARE @IdRemito1 int, @NumeroObra varchar(13), @Obras varchar(100), @Corte int
SET @Corte=0
SET @Obras=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdRemito, NumeroObra FROM #Auxiliar2 ORDER BY IdRemito
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRemito1, @NumeroObra
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRemito1
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar1
			SET Obras = SUBSTRING(@Obras,1,100)
			WHERE #Auxiliar1.IdRemito=@Corte
		SET @Obras=''
		SET @Corte=@IdRemito1
	   END
	IF NOT @NumeroObra IS NULL
		IF PATINDEX('%'+CONVERT(VARCHAR,@NumeroObra)+' '+'%', @Obras)=0
			SET @Obras=@Obras+@NumeroObra+' '
	FETCH NEXT FROM Cur INTO @IdRemito1, @NumeroObra
   END
 IF @Corte<>0
    BEGIN
	UPDATE #Auxiliar1
	SET Obras = SUBSTRING(@Obras,1,100)
	WHERE #Auxiliar1.IdRemito=@Corte
    END
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar3 
			(
			 IdRemito INTEGER,
			 OCompras VARCHAR(500)
			)

CREATE TABLE #Auxiliar4 
			(
			 IdRemito INTEGER,
			 OCompra VARCHAR(8)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdRemito,OCompra) ON [PRIMARY]
INSERT INTO #Auxiliar4 
 SELECT Det.IdRemito, Substring('00000000',1,8-Len(Convert(varchar,OrdenesCompra.NumeroOrdenCompra)))+Convert(varchar,OrdenesCompra.NumeroOrdenCompra)
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Det.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN DetalleOrdenesCompra ON Det.IdDetalleOrdenCompra = DetalleOrdenesCompra.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON DetalleOrdenesCompra.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE Remitos.IdRemito=@IdRemito

INSERT INTO #Auxiliar3 
 SELECT IdRemito, '' FROM #Auxiliar4 GROUP BY IdRemito

/*  CURSOR  */
DECLARE @OCompra varchar(8), @P varchar(550)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdRemito, OCompra FROM #Auxiliar4 ORDER BY IdRemito
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRemito1, @OCompra
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRemito1
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar3
			SET OCompras = SUBSTRING(@P,1,500)
			WHERE IdRemito=@Corte
		SET @P=''
		SET @Corte=@IdRemito1
	   END
	IF NOT @OCompra IS NULL
		IF PATINDEX('%'+@OCompra+' '+'%', @P)=0
			SET @P=@P+@OCompra+' '
	FETCH NEXT FROM Cur INTO @IdRemito1, @OCompra
   END
   IF @Corte<>0
	UPDATE #Auxiliar3
	SET OCompras = SUBSTRING(@P,1,500)
	WHERE IdRemito=@Corte
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar5 
			(
			 IdRemito INTEGER,
			 Facturas VARCHAR(500)
			)

CREATE TABLE #Auxiliar6 
			(
			 IdRemito INTEGER,
			 Factura VARCHAR(15)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar6 ON #Auxiliar6 (IdRemito,Factura) ON [PRIMARY]
INSERT INTO #Auxiliar6 
 SELECT Det.IdRemito, 
	Facturas.TipoABC+'-'+
		Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Det.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN DetalleFacturasRemitos ON Det.IdDetalleRemito = DetalleFacturasRemitos.IdDetalleRemito
 LEFT OUTER JOIN Facturas ON DetalleFacturasRemitos.IdFactura = Facturas.IdFactura
 WHERE Remitos.IdRemito=@IdRemito

INSERT INTO #Auxiliar5 
 SELECT IdRemito, '' FROM #Auxiliar6 GROUP BY IdRemito

/*  CURSOR  */
DECLARE @Factura varchar(15)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdRemito, Factura FROM #Auxiliar6 ORDER BY IdRemito
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRemito1, @Factura
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRemito1
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar5
			SET Facturas = SUBSTRING(@P,1,500)
			WHERE IdRemito=@Corte
		SET @P=''
		SET @Corte=@IdRemito1
	   END
	IF NOT @Factura IS NULL
		IF PATINDEX('%'+@Factura+' '+'%', @P)=0
			SET @P=@P+@Factura+' '
	FETCH NEXT FROM Cur INTO @IdRemito1, @Factura
   END
   IF @Corte<>0
	UPDATE #Auxiliar5
	SET Facturas = SUBSTRING(@P,1,500)
	WHERE IdRemito=@Corte
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar7 
			(
			 IdRemito INTEGER,
			 Articulos VARCHAR(550)
			)

CREATE TABLE #Auxiliar8 
			(
			 IdRemito INTEGER,
			 NumeroItem INTEGER,
			 Articulo VARCHAR(100)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar8 ON #Auxiliar8 (IdRemito,NumeroItem) ON [PRIMARY]
INSERT INTO #Auxiliar8 
 SELECT Det.IdRemito, Det.NumeroItem, Substring(IsNull(Articulos.Descripcion,''),1,100)
 FROM DetalleRemitos Det
 LEFT OUTER JOIN Remitos ON Det.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE Remitos.IdRemito=@IdRemito

INSERT INTO #Auxiliar7 
 SELECT IdRemito, '' FROM #Auxiliar8 GROUP BY IdRemito

/*  CURSOR  */
DECLARE @Articulo varchar(100)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdRemito, Articulo FROM #Auxiliar8 ORDER BY IdRemito, NumeroItem
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRemito, @Articulo
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdRemito
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar7
			SET Articulos = SUBSTRING(@P,1,550)
			WHERE IdRemito=@Corte
		SET @P=''
		SET @Corte=@IdRemito
	   END
	IF NOT @Articulo IS NULL
		IF PATINDEX('%'+@Articulo+' '+'%', @P)=0 and Len(@P+@Articulo)<550
			SET @P=@P+@Articulo+' - '
	FETCH NEXT FROM Cur INTO @IdRemito, @Articulo
   END
   IF @Corte<>0
	UPDATE #Auxiliar7
	SET Articulos = SUBSTRING(@P,1,550)
	WHERE IdRemito=@Corte
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111111111533'
SET @vector_T='0E94122EBB4322H504300'

SELECT 
 Remitos.IdRemito,
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+
	Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+
	Convert(varchar,Remitos.NumeroRemito) as [Remito],
 Remitos.IdRemito as [IdAux],
 Remitos.FechaRemito [Fecha],
 Remitos.Anulado as [Anulado],
 Clientes.RazonSocial as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 #Auxiliar1.Obras as [Obras],
 #Auxiliar3.OCompras as [Ordenes de compra],
 #Auxiliar5.Facturas as [Facturas],
 Case 	When Remitos.Destino=1 Then 'A facturar'
	When Remitos.Destino=2 Then 'A proveedor p/fabricar'
	When Remitos.Destino=3 Then 'Con cargo devolucion'
	When Remitos.Destino=4 Then 'Muestra'
	When Remitos.Destino=5 Then 'A prestamo'
	When Remitos.Destino=6 Then 'Traslado'
	Else ''
 End as [Tipo de remito],
 cc.Descripcion as [Condicion de venta],
 Transportistas.RazonSocial as [Transportista],
 Remitos.TotalBultos as [Bultos],
 Remitos.ValorDeclarado as [Valor decl.],
 #Auxiliar7.Articulos as [Materiales],
 (Select Count(*) From DetalleRemitos Where DetalleRemitos.IdRemito=Remitos.IdRemito) as [Cant.Items],
 Remitos.Chofer as [Chofer],
 Remitos.HoraSalida as [Hora de salida],
 Remitos.Observaciones,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Remitos
LEFT OUTER JOIN Clientes ON Remitos.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Remitos.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Transportistas ON Remitos.IdTransportista=Transportistas.IdTransportista
LEFT OUTER JOIN [Condiciones Compra] cc ON Remitos.IdCondicionVenta=cc.IdCondicionCompra
LEFT OUTER JOIN #Auxiliar1 ON Remitos.IdRemito=#Auxiliar1.IdRemito
LEFT OUTER JOIN #Auxiliar3 ON Remitos.IdRemito=#Auxiliar3.IdRemito
LEFT OUTER JOIN #Auxiliar5 ON Remitos.IdRemito=#Auxiliar5.IdRemito
LEFT OUTER JOIN #Auxiliar7 ON Remitos.IdRemito=#Auxiliar7.IdRemito
WHERE Remitos.IdRemito=@IdRemito

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8