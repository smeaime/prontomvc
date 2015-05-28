CREATE PROCEDURE [dbo].[CuadroEgresos_TX_DetalladoPorObra]

@FechaDesde datetime,
@FechaHasta datetime,
@IdObra int

AS

SET NOCOUNT ON

DECLARE @IdRubroAnticipos int, @IdRubroDevolucionAnticipos int

SET @IdRubroAnticipos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdRubroAnticipos'),-1)
SET @IdRubroDevolucionAnticipos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdRubroDevolucionAnticipos'),-1)

CREATE TABLE #Auxiliar1 
			(
			 IdSalidaMateriales INTEGER,
			 Materiales VARCHAR(4000) COLLATE SQL_Latin1_General_CP1_CI_AS
			)

CREATE TABLE #Auxiliar2 
			(
			 IdSalidaMateriales INTEGER,
			 Material VARCHAR(300) COLLATE SQL_Latin1_General_CP1_CI_AS
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdSalidaMateriales) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT DISTINCT Subdiarios.IdComprobante, Articulos.Descripcion
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and cp.IdTipoComprobante=Subdiarios.IdTipoComprobante
 LEFT OUTER JOIN DetalleSalidasMateriales dsm ON dsm.IdSalidaMateriales=Subdiarios.IdComprobante
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=dsm.IdArticulo
 WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	cp.IdComprobanteProveedor is null and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=Subdiarios.IdCuenta))) and 
	(@IdObra=-1 or IsNull(Cuentas.IdObra,0)=@IdObra) and Subdiarios.IdTipoComprobante=50 and 
	IsNull(TiposComprobante.Agrupacion1,'')<>'VENTAS'

INSERT INTO #Auxiliar1 
 SELECT IdSalidaMateriales, ''
 FROM #Auxiliar2
 GROUP BY IdSalidaMateriales

/*  CURSOR  */
DECLARE @IdSalidaMateriales int, @Material varchar(300), @Corte int, @P varchar(4000)
SET @Corte=0
SET @P=''
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdSalidaMateriales, Material FROM #Auxiliar2 ORDER BY IdSalidaMateriales
OPEN Cur
FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @Material
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @Corte<>@IdSalidaMateriales
	  BEGIN
		IF @Corte<>0
			UPDATE #Auxiliar1
			SET Materiales = SUBSTRING(@P,1,4000)
			WHERE IdSalidaMateriales=@Corte
		SET @P=''
		SET @Corte=@IdSalidaMateriales
	  END
	IF NOT @Material IS NULL
		IF Len(@P)>0
			SET @P=@P+Char(10)+@Material
		ELSE
			SET @P=@P+@Material
	FETCH NEXT FROM Cur INTO @IdSalidaMateriales, @Material
  END
IF @Corte<>0
  BEGIN
	UPDATE #Auxiliar1
	SET Materiales = SUBSTRING(@P,1,4000)
	WHERE IdSalidaMateriales=@Corte
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT 
 DetCP.IdDetalleComprobanteProveedor as [IdComprobante],
 IsNull(Obras.NumeroObra,'_NO IMPUTABLE') as [Obra],
 '1.GASTOS' as [Grupo],
 IsNull(RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS+' ','')+IsNull(Cuentas.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Rubro],
 cp.FechaRecepcion as [Fecha],
 TiposComprobante.DescripcionAb as [Tipo],
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 IsNull(Proveedores.RazonSocial,'') as [Proveedor],
 Case When cp.Letra='A' or cp.Letra='M' 
	Then DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
	Else (DetCP.Importe - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje1,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje2,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje3,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje4,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje5,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje6,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje7,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje8,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje9,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje10,0)/100))))) * 
		cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
 End as [Importe],
 (Select Top 1 op.NumeroOrdenPago From OrdenesPago op 
  Left Outer Join CuentasCorrientesAcreedores cca On cca.IdTipoComp=cp.IdTipoComprobante and cca.IdComprobante=cp.IdComprobanteProveedor
  Left Outer Join DetalleOrdenesPago dop On dop.IdImputacion=cca.IdCtaCte
  Where op.IdOrdenPago=dop.IdOrdenPago) as [Orden pago],
 Pedidos.NumeroPedido as [Pedido],
 Articulos.Descripcion COLLATE Modern_Spanish_CI_AS as [Material]
FROM DetalleComprobantesProveedores DetCP 
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN Obras ON IsNull(DetCP.IdObra,Cuentas.IdObra) = Obras.IdObra
LEFT OUTER JOIN DetalleRecepciones dr ON dr.IdDetalleRecepcion=DetCP.IdDetalleRecepcion
LEFT OUTER JOIN DetallePedidos dp ON dp.IdDetallePedido=IsNull(DetCP.IdDetallePedido,dr.IdDetallePedido)
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=dp.IdPedido
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=dp.IdArticulo
WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	IsNull(cp.Confirmado,'')<>'NO' and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta))) and 
	(@IdObra=-1 or IsNull(DetCP.IdObra,0)=@IdObra or IsNull(Cuentas.IdObra,0)=@IdObra)

UNION ALL

SELECT 
 Subdiarios.IdSubdiario as [IdComprobante],
 IsNull(Obras.NumeroObra,' NO IMPUTABLE') as [Obra],
 '1.GASTOS' as [Grupo],
 IsNull(RubrosContables.Descripcion,'SIN RUBRO') as [Rubro],
 Subdiarios.FechaComprobante as [Fecha],
 TiposComprobante.DescripcionAb as [Tipo],
 Substring('0000000000',1,10-Len(Convert(varchar,Subdiarios.NumeroComprobante)))+Convert(varchar,Subdiarios.NumeroComprobante) as [Comprobante],
 Null as [Proveedor],
 Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null Then Subdiarios.Debe * -1
	When Subdiarios.Debe is null and Subdiarios.Haber is not null Then Subdiarios.Haber
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null Then (Subdiarios.Debe - Subdiarios.Haber) * -1
	Else 0
 End as [Importe],
 Null as [Orden pago],
 Null as [Pedido],
 Null as [Material]
FROM Subdiarios 
LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and cp.IdTipoComprobante=Subdiarios.IdTipoComprobante
WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	cp.IdComprobanteProveedor is null and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=Subdiarios.IdCuenta))) and 
	(@IdObra=-1 or IsNull(Cuentas.IdObra,0)=@IdObra) and Subdiarios.IdTipoComprobante<>50 and 
	IsNull(TiposComprobante.Agrupacion1,'')<>'VENTAS'

UNION ALL

SELECT 
 DetAsi.IdDetalleAsiento as [IdComprobante],
 IsNull(Obras.NumeroObra,' NO IMPUTABLE') as [Obra],
 '1.GASTOS' as [Grupo],
 IsNull(RubrosContables.Descripcion,'SIN RUBRO') as [Rubro],
 Asientos.FechaAsiento as [Fecha],
 'AS' as [Tipo],
 Substring('0000000000',1,10-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento) as [Comprobante],
 Null as [Proveedor],
 Case 	When DetAsi.Debe is not null and DetAsi.Haber is null Then DetAsi.Debe * -1
	When DetAsi.Debe is null and DetAsi.Haber is not null Then DetAsi.Haber
	When DetAsi.Debe is not null and DetAsi.Haber is not null Then (DetAsi.Debe - DetAsi.Haber) * -1
	Else 0
 End as [Importe],
 Null as [Orden pago],
 Null as [Pedido],
 Null as [Material]
FROM DetalleAsientos DetAsi 
LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN Obras ON IsNull(DetAsi.IdObra,Cuentas.IdObra) = Obras.IdObra
WHERE (Asientos.FechaAsiento between @FechaDesde and @FechaHasta) and 
	Asientos.IdCuentaSubdiario is null and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetAsi.IdCuenta))) and 
	(@IdObra=-1 or IsNull(DetAsi.IdObra,0)=@IdObra or IsNull(Cuentas.IdObra,0)=@IdObra) and 
	Substring(IsNull(Asientos.Tipo,''),1,3)<>'CIE' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'APE'

UNION ALL

SELECT 
 DetCP.IdDetalleComprobanteProveedor as [IdComprobante],
 IsNull(Obras.NumeroObra,'_NO IMPUTABLE') as [Obra],
 '2.BIENES/SERVICIOS' as [Grupo],
 IsNull(RubrosContables.Descripcion COLLATE Modern_Spanish_CI_AS+' ','')+IsNull(Cuentas.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Rubro],
 cp.FechaRecepcion as [Fecha],
 TiposComprobante.DescripcionAb as [Tipo],
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante],
 IsNull(Proveedores.RazonSocial,'') as [Proveedor],
 Case When cp.Letra='A' or cp.Letra='M' 
	Then DetCP.Importe * cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
	Else (DetCP.Importe - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje1,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje2,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje3,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje4,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje5,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje6,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje7,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje8,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje9,0)/100)))) - 
		(DetCP.Importe-(DetCP.Importe/(1+(IsNull(DetCP.IVAComprasPorcentaje10,0)/100))))) * 
		cp.CotizacionMoneda * TiposComprobante.Coeficiente * -1
 End as [Importe],
 (Select Top 1 op.NumeroOrdenPago From OrdenesPago op 
  Left Outer Join CuentasCorrientesAcreedores cca On cca.IdTipoComp=cp.IdTipoComprobante and cca.IdComprobante=cp.IdComprobanteProveedor
  Left Outer Join DetalleOrdenesPago dop On dop.IdImputacion=cca.IdCtaCte
  Where op.IdOrdenPago=dop.IdOrdenPago) as [Orden pago],
 Pedidos.NumeroPedido as [Pedido],
 Articulos.Descripcion COLLATE Modern_Spanish_CI_AS as [Material]
FROM DetalleComprobantesProveedores DetCP 
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cp.IdTipoComprobante
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN Obras ON IsNull(DetCP.IdObra,Cuentas.IdObra) = Obras.IdObra
LEFT OUTER JOIN DetalleRecepciones dr ON dr.IdDetalleRecepcion=DetCP.IdDetalleRecepcion
LEFT OUTER JOIN DetallePedidos dp ON dp.IdDetallePedido=IsNull(DetCP.IdDetallePedido,dr.IdDetallePedido)
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido=dp.IdPedido
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=dp.IdArticulo
WHERE (cp.FechaRecepcion between @FechaDesde and @FechaHasta) and 
	IsNull(cp.Confirmado,'')<>'NO' and 
	(DetCP.IdObra is not null and 
	 Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	 Not Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=DetCP.IdCuenta)) and 
	(@IdObra=-1 or IsNull(DetCP.IdObra,0)=@IdObra or IsNull(Cuentas.IdObra,0)=@IdObra)

UNION ALL

SELECT 
 Subdiarios.IdSubdiario as [IdComprobante],
 IsNull(Obras.NumeroObra,' NO IMPUTABLE') as [Obra],
 '3.SALIDAS MATERIALES' as [Grupo],
 IsNull(RubrosContables.Descripcion,'SIN RUBRO') as [Rubro],
 Subdiarios.FechaComprobante as [Fecha],
 TiposComprobante.DescripcionAb as [Tipo],
 Substring('0000000000',1,10-Len(Convert(varchar,Subdiarios.NumeroComprobante)))+Convert(varchar,Subdiarios.NumeroComprobante) as [Comprobante],
 Null as [Proveedor],
 Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null Then Subdiarios.Debe * -1
	When Subdiarios.Debe is null and Subdiarios.Haber is not null Then Subdiarios.Haber
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null Then (Subdiarios.Debe - Subdiarios.Haber) * -1
	Else 0
 End as [Importe],
 Null as [Orden pago],
 Null as [Pedido],
 #Auxiliar1.Materiales COLLATE Modern_Spanish_CI_AS as [Material]
FROM Subdiarios 
LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Obras ON Obras.IdObra=Cuentas.IdObra
LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and cp.IdTipoComprobante=Subdiarios.IdTipoComprobante
LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdSalidaMateriales=Subdiarios.IdComprobante
WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	cp.IdComprobanteProveedor is null and 
	((Cuentas.IdObra Is Not Null and Cuentas.IdCuentaGasto Is Not Null) or 
	 (Cuentas.IdObra Is Null and Cuentas.IdCuentaGasto Is Null and 
	  Exists(Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos Where CuentasGastos.IdCuentaMadre=Subdiarios.IdCuenta))) and 
	(@IdObra=-1 or IsNull(Cuentas.IdObra,0)=@IdObra) and Subdiarios.IdTipoComprobante=50 and 
	IsNull(TiposComprobante.Agrupacion1,'')<>'VENTAS'

ORDER BY [Obra], [Grupo], [Fecha], [Tipo], [Comprobante]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
