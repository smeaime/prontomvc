CREATE PROCEDURE [dbo].[OrdenesCompra_TXFecha]

@Desde datetime,
@Hasta datetime,
@IdVendedor int = Null

AS

SET NOCOUNT ON

SET @IdVendedor=IsNull(@IdVendedor,-1)

CREATE TABLE #Auxiliar1
			(
			 IdOrdenCompra INTEGER,
			 Automatica VARCHAR(1),
			 Manual VARCHAR(1)
			)

INSERT INTO #Auxiliar1 
 SELECT 
  doc.IdOrdenCompra, 
  Case When IsNull(FacturacionAutomatica,'NO')='SI' Then 'A' Else '' End,
  Case When IsNull(FacturacionAutomatica,'NO')='NO' Then 'M' Else '' End
 FROM DetalleOrdenesCompra doc 
 LEFT OUTER JOIN OrdenesCompra  ON doc.IdOrdenCompra=OrdenesCompra .IdOrdenCompra
 WHERE (OrdenesCompra.FechaOrdenCompra Between @Desde And DATEADD(n,1439,@hasta))

CREATE TABLE #Auxiliar2
			(
			 IdOrdenCompra INTEGER,
			 Automatica VARCHAR(1),
			 Manual VARCHAR(1)
			)

INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdOrdenCompra, Max(#Auxiliar1.Automatica), Max(#Auxiliar1.Manual)
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.IdOrdenCompra

CREATE TABLE #Auxiliar3 
			(
			 IdOrdenCompra INTEGER,
			 Remitos VARCHAR(500)
			)

CREATE TABLE #Auxiliar4 
			(
			 IdOrdenCompra INTEGER,
			 Remito VARCHAR(13)
			)
INSERT INTO #Auxiliar4 
 SELECT Det.IdOrdenCompra, 
	Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+
		Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+
		Convert(varchar,Remitos.NumeroRemito)
 FROM DetalleOrdenesCompra Det
 LEFT OUTER JOIN OrdenesCompra ON Det.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN DetalleRemitos ON Det.IdDetalleOrdenCompra = DetalleRemitos.IdDetalleOrdenCompra
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 WHERE OrdenesCompra.FechaOrdenCompra Between @Desde And DATEADD(n,1439,@hasta)

CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdOrdenCompra,Remito) ON [PRIMARY]

INSERT INTO #Auxiliar3 
 SELECT IdOrdenCompra, ''
 FROM #Auxiliar4
 GROUP BY IdOrdenCompra

/*  CURSOR  */
DECLARE @IdOrdenCompra int, @Remito varchar(13), @Corte int, @P varchar(500)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdOrdenCompra, Remito
		FROM #Auxiliar4
		ORDER BY IdOrdenCompra
OPEN Cur
FETCH NEXT FROM Cur INTO @IdOrdenCompra, @Remito
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdOrdenCompra
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar3
			SET Remitos = SUBSTRING(@P,1,500)
			WHERE IdOrdenCompra=@Corte
		SET @P=''
		SET @Corte=@IdOrdenCompra
	   END
	IF NOT @Remito IS NULL
		IF PATINDEX('%'+@Remito+' '+'%', @P)=0
			SET @P=@P+@Remito+' '
	FETCH NEXT FROM Cur INTO @IdOrdenCompra, @Remito
   END
   IF @Corte<>0
	UPDATE #Auxiliar3
	SET Remitos = SUBSTRING(@P,1,500)
	WHERE IdOrdenCompra=@Corte
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar5 
			(
			 IdOrdenCompra INTEGER,
			 Facturas VARCHAR(500)
			)

CREATE TABLE #Auxiliar6 
			(
			 IdOrdenCompra INTEGER,
			 Factura VARCHAR(15)
			)
INSERT INTO #Auxiliar6 
 SELECT Det.IdOrdenCompra, 
	Facturas.TipoABC+'-'+
	Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+
		Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+
		Convert(varchar,Facturas.NumeroFactura)
 FROM DetalleOrdenesCompra Det
 LEFT OUTER JOIN OrdenesCompra ON Det.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 LEFT OUTER JOIN DetalleFacturasOrdenesCompra ON Det.IdDetalleOrdenCompra = DetalleFacturasOrdenesCompra.IdDetalleOrdenCompra
 LEFT OUTER JOIN Facturas ON DetalleFacturasOrdenesCompra.IdFactura = Facturas.IdFactura
 WHERE OrdenesCompra.FechaOrdenCompra Between @Desde And DATEADD(n,1439,@hasta)

CREATE NONCLUSTERED INDEX IX__Auxiliar6 ON #Auxiliar6 (IdOrdenCompra,Factura) ON [PRIMARY]

INSERT INTO #Auxiliar5 
 SELECT IdOrdenCompra, ''
 FROM #Auxiliar6
 GROUP BY IdOrdenCompra

/*  CURSOR  */
DECLARE @Factura varchar(15)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdOrdenCompra, Factura
		FROM #Auxiliar6
		ORDER BY IdOrdenCompra
OPEN Cur
FETCH NEXT FROM Cur INTO @IdOrdenCompra, @Factura
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdOrdenCompra
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar5
			SET Facturas = SUBSTRING(@P,1,500)
			WHERE IdOrdenCompra=@Corte
		SET @P=''
		SET @Corte=@IdOrdenCompra
	   END
	IF NOT @Factura IS NULL
		IF PATINDEX('%'+@Factura+' '+'%', @P)=0
			SET @P=@P+@Factura+' '
	FETCH NEXT FROM Cur INTO @IdOrdenCompra, @Factura
   END
   IF @Corte<>0
	UPDATE #Auxiliar5
	SET Facturas = SUBSTRING(@P,1,500)
	WHERE IdOrdenCompra=@Corte
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111111111511111133'
SET @vector_T='059443211640BB133507532424500'

SELECT 
 OrdenesCompra.IdOrdenCompra,
 OrdenesCompra.NumeroOrdenCompraCliente as [Orden de compra],
 OrdenesCompra.IdOrdenCompra as [IdAux],
 OrdenesCompra.NumeroOrdenCompra as [Nro. interno],
 OrdenesCompra.FechaOrdenCompra [Fecha],
 IsNull(OrdenesCompra.Estado,'') as [Producido],
 Case When Exists(Select Top 1 doc.IdOrdenCompra From DetalleOrdenesCompra doc Where doc.IdOrdenCompra=OrdenesCompra.IdOrdenCompra and IsNull(doc.Cumplido,'NO')='NO') Then Null Else 'SI' End as [Cumplido],
 OrdenesCompra.Anulada [Anulada],
 OrdenesCompra.SeleccionadaParaFacturacion as [Selecc.],
 Obras.NumeroObra as [Obra],
 Clientes.RazonSocial as [Cliente],
 E4.Nombre as [Liberado por],
 #Auxiliar3.Remitos as [Remitos],
 #Auxiliar5.Facturas as [Facturas],
 cc.Descripcion as [Condicion de venta],
 (Select Count(*) From DetalleOrdenesCompra Where DetalleOrdenesCompra.IdOrdenCompra=OrdenesCompra.IdOrdenCompra) as [Cant.Items],
 Case 	When IsNull(OrdenesCompra.AgrupacionFacturacion,1)=1 Then 'Cliente'
	When IsNull(OrdenesCompra.AgrupacionFacturacion,1)=2 Then 'Obra'
	When IsNull(OrdenesCompra.AgrupacionFacturacion,1)=3 Then 'U.Operativa'
	Else Null
 End as [Facturar a],
 OrdenesCompra.FechaAnulacion [Fecha anul.],
 E1.Nombre as [Anulo],
 Case 	When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=1 Then 'Grupo 1'
	When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=2 Then 'Grupo 2'
	When IsNull(OrdenesCompra.Agrupacion2Facturacion,1)=3 Then 'Grupo 3'
	Else Null
 End as [Grupo facturacion],
 OrdenesCompra.Observaciones,
 IsNull(#Auxiliar2.Automatica+' ','')+IsNull(#Auxiliar2.Manual,'') as [Tipo OC],
 E2.Nombre as [Confecciono],
 OrdenesCompra.FechaIngreso as [Fecha ing.],
 E3.Nombre as [Modifico],
 OrdenesCompra.FechaModifico as [Fecha modif.],
 (Select Max(Det.FechaEntrega) From DetalleOrdenesCompra Det Where Det.IdOrdenCompra=OrdenesCompra.IdOrdenCompra) as [Mayor fecha entrega],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM OrdenesCompra
LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN [Condiciones Compra] cc ON OrdenesCompra.IdCondicionVenta=cc.IdCondicionCompra
LEFT OUTER JOIN Obras ON OrdenesCompra.IdObra=Obras.IdObra
LEFT OUTER JOIN Empleados E1 ON OrdenesCompra.IdUsuarioAnulacion=E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON OrdenesCompra.IdUsuarioIngreso=E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON OrdenesCompra.IdUsuarioModifico=E3.IdEmpleado
LEFT OUTER JOIN Empleados E4 ON OrdenesCompra.Aprobo=E4.IdEmpleado
LEFT OUTER JOIN #Auxiliar2 ON OrdenesCompra.IdOrdenCompra=#Auxiliar2.IdOrdenCompra
LEFT OUTER JOIN #Auxiliar3 ON OrdenesCompra.IdOrdenCompra=#Auxiliar3.IdOrdenCompra
LEFT OUTER JOIN #Auxiliar5 ON OrdenesCompra.IdOrdenCompra=#Auxiliar5.IdOrdenCompra
WHERE OrdenesCompra.FechaOrdenCompra Between @Desde And DATEADD(n,1439,@hasta) and (@IdVendedor=-1 or Clientes.Vendedor1=@IdVendedor)
ORDER BY OrdenesCompra.NumeroOrdenCompra

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
DROP TABLE #Auxiliar6