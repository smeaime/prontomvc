CREATE Procedure [dbo].[Facturas_TX_TT]

@IdFactura int

AS

SET NOCOUNT ON

DECLARE @IdAbonos varchar(100)
SET @IdAbonos=''

CREATE TABLE #Auxiliar1 
			(
			 IdFactura INTEGER,
			 OCompras VARCHAR(500)
			)

CREATE TABLE #Auxiliar2 
			(
			 IdFactura INTEGER,
			 OCompra VARCHAR(8)
			)
INSERT INTO #Auxiliar2 
 SELECT Det.IdFactura, Substring('00000000',1,8-Len(Convert(varchar,OrdenesCompra.NumeroOrdenCompra)))+Convert(varchar,OrdenesCompra.NumeroOrdenCompra)
 FROM DetalleFacturas Det
 LEFT OUTER JOIN DetalleFacturasOrdenesCompra ON Det.IdDetalleFactura = DetalleFacturasOrdenesCompra.IdDetalleFactura
 LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleFacturasOrdenesCompra.IdDetalleOrdenCompra = DetalleOrdenesCompra.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON DetalleOrdenesCompra.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE Facturas.IdFactura=@IdFactura

CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdFactura,OCompra) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdFactura, ''
 FROM #Auxiliar2
 GROUP BY IdFactura

/*  CURSOR  */
DECLARE @IdFactura1 int, @OCompra varchar(8), @Corte int, @P varchar(500)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdFactura, OCompra
		FROM #Auxiliar2
		ORDER BY IdFactura
OPEN Cur
FETCH NEXT FROM Cur INTO @IdFactura1, @OCompra
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdFactura1
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar1
			SET OCompras = SUBSTRING(@P,1,500)
			WHERE IdFactura=@Corte
		SET @P=''
		SET @Corte=@IdFactura1
	   END
	IF NOT @OCompra IS NULL
		IF PATINDEX('%'+@OCompra+' '+'%', @P)=0
			SET @P=@P+@OCompra+' '
	FETCH NEXT FROM Cur INTO @IdFactura1, @OCompra
   END
   IF @Corte<>0
	UPDATE #Auxiliar1
	SET OCompras = SUBSTRING(@P,1,500)
	WHERE IdFactura=@Corte
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar3 
			(
			 IdFactura INTEGER,
			 Remitos VARCHAR(500)
			)

CREATE TABLE #Auxiliar4 
			(
			 IdFactura INTEGER,
			 Remito VARCHAR(13)
			)
INSERT INTO #Auxiliar4 
 SELECT Det.IdFactura, 
	Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+
		Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+
		Convert(varchar,Remitos.NumeroRemito)
 FROM DetalleFacturas Det
 LEFT OUTER JOIN DetalleFacturasRemitos ON Det.IdDetalleFactura = DetalleFacturasRemitos.IdDetalleFactura
 LEFT OUTER JOIN Facturas ON Det.IdFactura = Facturas.IdFactura
 LEFT OUTER JOIN DetalleRemitos ON DetalleFacturasRemitos.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 WHERE Facturas.IdFactura=@IdFactura

CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdFactura,Remito) ON [PRIMARY]

INSERT INTO #Auxiliar3 
 SELECT IdFactura, ''
 FROM #Auxiliar4
 GROUP BY IdFactura

/*  CURSOR  */
DECLARE @Remito varchar(13)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdFactura, Remito
		FROM #Auxiliar4
		ORDER BY IdFactura
OPEN Cur
FETCH NEXT FROM Cur INTO @IdFactura1, @Remito
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdFactura1
	   BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar3
			SET Remitos = SUBSTRING(@P,1,500)
			WHERE IdFactura=@Corte
		SET @P=''
		SET @Corte=@IdFactura1
	   END
	IF NOT @Remito IS NULL
		IF PATINDEX('%'+@Remito+' '+'%', @P)=0
			SET @P=@P+@Remito+' '
	FETCH NEXT FROM Cur INTO @IdFactura1, @Remito
   END
   IF @Corte<>0
	UPDATE #Auxiliar3
	SET Remitos = SUBSTRING(@P,1,500)
	WHERE IdFactura=@Corte
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111111111111111111133'
SET @vector_T='009112F11F055BB544444425126703433533400'

SELECT 
 Facturas.IdFactura, 
 Facturas.TipoABC as [A/B/E], Facturas.IdFactura as [IdAux],  Facturas.PuntoVenta as [Pto.vta.], 
 Facturas.NumeroFactura as [Factura], 
 Depositos.Descripcion as [Sucursal],
 Facturas.Anulada as [Anulada],
 Substring(IsNull(Clientes.Codigo,''),1,2) as [SubCod],
 Clientes.CodigoCliente as [Cod.Cli.], 
 Clientes.RazonSocial+IsNull(' ['+Facturas.Cliente COLLATE Modern_Spanish_CI_AS+']','') as [Cliente], 
 DescripcionIva.Descripcion as [Condicion IVA], 
 Clientes.Cuit as [Cuit], 
 Facturas.FechaFactura as [Fecha Factura], 
 #Auxiliar1.OCompras as [Ordenes de compra],
 #Auxiliar3.Remitos as [Remitos],
 Facturas.ImporteTotal-Facturas.ImporteIva1-Facturas.ImporteIva2-Facturas.RetencionIBrutos1-Facturas.RetencionIBrutos2-Facturas.RetencionIBrutos3+
	IsNull(Facturas.ImporteBonificacion,0)-IsNull(Facturas.IvaNoDiscriminado,0)-IsNull(Facturas.PercepcionIVA,0) as [Subtotal],
 Facturas.ImporteBonificacion as [Bonificacion],
 Facturas.ImporteIva1+IsNull(Facturas.IvaNoDiscriminado,0) as [Iva],
 Facturas.AjusteIva as [Ajuste IVA],
 Facturas.RetencionIBrutos1+Facturas.RetencionIBrutos2+Facturas.RetencionIBrutos3 as [IIBB],
 Facturas.PercepcionIVA as [Perc.IVA],
 Facturas.ImporteTotal as [Total factura],
 Monedas.Abreviatura as [Mon.],
 Clientes.Telefono as [Telefono del cliente], 
 Vendedores.Nombre as [Vendedor],
 Empleados.Nombre  as [Ingreso],
 Facturas.FechaIngreso as [Fecha ingreso],
 Obras.NumeroObra as [Obra (x defecto)],
 Provincias.Nombre as [Provincia destino],
 (Select Count(*) From DetalleFacturas df 
	Where df.IdFactura=Facturas.IdFactura) as [Cant.Items],
 (Select Count(*) From DetalleFacturas df 
	Where df.IdFactura=Facturas.IdFactura and 
		Patindex('%'+Convert(varchar,df.IdArticulo)+'%', @IdAbonos)<>0) as [Cant.Abonos],
 'Grupo '+Convert(varchar,
 (Select Top 1 oc.Agrupacion2Facturacion 
	From DetalleFacturasOrdenesCompra dfoc 
	Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra
	Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra
	Where dfoc.IdFactura=Facturas.IdFactura)) as [Grupo facturacion automatica],
 Facturas.ActivarRecuperoGastos as [Act.Rec.Gtos.],
 Case When IsNull(ContabilizarAFechaVencimiento,'NO')='NO' 
	Then Facturas.FechaFactura
	Else Facturas.FechaVencimiento
 End as [Fecha Contab.],
 Facturas.CAE as [CAE],
 Facturas.RechazoCAE as [Rech.CAE],
 Facturas.FechaVencimientoORechazoCAE as [Fecha vto.CAE],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Facturas 
LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN DescripcionIva ON IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Vendedores ON Clientes.Vendedor1 = Vendedores.IdVendedor
LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Obras ON Facturas.IdObra = Obras.IdObra
LEFT OUTER JOIN Provincias ON Facturas.IdProvinciaDestino = Provincias.IdProvincia
LEFT OUTER JOIN Empleados ON Facturas.IdUsuarioIngreso = Empleados.IdEmpleado
LEFT OUTER JOIN #Auxiliar1 ON Facturas.IdFactura=#Auxiliar1.IdFactura
LEFT OUTER JOIN #Auxiliar3 ON Facturas.IdFactura=#Auxiliar3.IdFactura
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = Facturas.IdDeposito
WHERE Facturas.IdFactura=@IdFactura
ORDER BY Facturas.FechaFactura,Facturas.NumeroFactura

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4