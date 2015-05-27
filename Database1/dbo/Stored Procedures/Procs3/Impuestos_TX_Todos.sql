CREATE  Procedure [dbo].[Impuestos_TX_Todos]

@IdTipoComprobante int = Null,
@Estado varchar(1) = Null,
@Detallado varchar(1) = Null,
@Pendientes varchar(1) = Null,
@TodosLosPeriodos varchar(1) = Null,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null,
@NumeroTramite varchar(50) = Null,
@IdCuenta int = Null,
@TramiteOCuenta varchar(1) = Null

AS 

SET NOCOUNT ON

SET @IdTipoComprobante=IsNull(@IdTipoComprobante,-1)
SET @Estado=IsNull(@Estado,'A')
SET @Detallado=IsNull(@Detallado,'R')
SET @Pendientes=IsNull(@Pendientes,'T')
SET @TodosLosPeriodos=IsNull(@TodosLosPeriodos,'*')
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)
SET @NumeroTramite=IsNull(@NumeroTramite,'')
SET @IdCuenta=IsNull(@IdCuenta,-1)
SET @TramiteOCuenta=IsNull(@TramiteOCuenta,'')

DECLARE @vector_X varchar(30),@vector_T varchar(30)

CREATE TABLE #Auxiliar2 
			(
			 IdImpuesto INTEGER,
			 Año INTEGER,
			 NumeroCuota INTEGER,
			 Importe NUMERIC(18,2),
			 FechaVencimiento1 DATETIME,
			 FechaVencimiento2 DATETIME,
			 FechaVencimiento3 DATETIME,
			 IdOrdenPago INTEGER
			)

IF @Detallado='R'
	INSERT INTO #Auxiliar2
	 SELECT IdImpuesto, Null, Null, Null, Null, Null, Null, Null
	 FROM Impuestos
	 WHERE (@IdTipoComprobante<=0 or Impuestos.IdTipoComprobante=@IdTipoComprobante) and 
		(@Estado='*' or 
		 (@Estado='A' and Exists(Select Top 1 di.IdImpuesto From DetalleImpuestos di 
					 Left Outer Join DetalleOrdenesPagoImpuestos dopi On dopi.IdDetalleImpuesto = di.IdDetalleImpuesto
					 Where di.IdImpuesto=Impuestos.IdImpuesto and dopi.IdDetalleImpuesto is null)) or 
		 (@Estado='I' and not Exists(Select Top 1 di.IdImpuesto From DetalleImpuestos di 
						Left Outer Join DetalleOrdenesPagoImpuestos dopi On dopi.IdDetalleImpuesto = di.IdDetalleImpuesto
						Where di.IdImpuesto=Impuestos.IdImpuesto and dopi.IdDetalleImpuesto is null)))
ELSE
	INSERT INTO #Auxiliar2
	 SELECT di.IdImpuesto, di.Año, di.Cuota, IsNull(di.Importe,0)+IsNull(di.Intereses1,0)+IsNull(di.Intereses2,0), di.FechaVencimiento1, di.FechaVencimiento2, di.FechaVencimiento3, dopi.IdOrdenPago
	 FROM DetalleImpuestos di 
	 LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = di.IdImpuesto
	 LEFT OUTER JOIN DetalleOrdenesPagoImpuestos dopi ON dopi.IdDetalleImpuesto = di.IdDetalleImpuesto
	 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = dopi.IdOrdenPago
	 WHERE (@IdTipoComprobante<=0 or Impuestos.IdTipoComprobante=@IdTipoComprobante) and 
		(@Estado='*' or 
		 (@Estado='A' and Exists(Select Top 1 di.IdImpuesto From DetalleImpuestos di 
					 Left Outer Join DetalleOrdenesPagoImpuestos dopi On dopi.IdDetalleImpuesto = di.IdDetalleImpuesto
					 Where di.IdImpuesto=Impuestos.IdImpuesto and dopi.IdDetalleImpuesto is null)) or 
		 (@Estado='I' and not Exists(Select Top 1 di.IdImpuesto From DetalleImpuestos di 
						Left Outer Join DetalleOrdenesPagoImpuestos dopi On dopi.IdDetalleImpuesto = di.IdDetalleImpuesto
						Where di.IdImpuesto=Impuestos.IdImpuesto and dopi.IdDetalleImpuesto is null))) and 
		(@TodosLosPeriodos='*' or (Impuestos.Fecha between @FechaDesde and @FechaHasta)) and 
		(@NumeroTramite='' or Impuestos.NumeroTramite=@NumeroTramite) and 
		(@IdCuenta<=0 or Impuestos.IdCuenta=@IdCuenta) and 
		(@Detallado<>'V' or (di.FechaVencimiento1<=@FechaHasta and dopi.IdDetalleImpuesto is null))

SET NOCOUNT OFF

IF @IdTipoComprobante=110 and @Detallado='R'
   BEGIN
	SET @vector_X='01111111111133'
	SET @vector_T='01992E34255500'

	SELECT 
	 #Auxiliar2.IdImpuesto as [IdImpuesto],
	 Articulos.Codigo as [Ord.Perm.],
	 Impuestos.IdImpuesto as [IdAux1],
	 #Auxiliar2.NumeroCuota [IdAux2],
	 Articulos.NumeroPatente as [Patente],
	 Articulos.Descripcion as [Equipo imputado],
	 Modelos.Descripcion as [Modelo],
	 Impuestos.Fecha as [Fecha],
	 Cuentas.Codigo as [Codigo],
	 Cuentas.Descripcion as [Cuenta contable],
	 Impuestos.Observaciones as [Observaciones],
	 Impuestos.EnUsoPor as [En uso por],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = #Auxiliar2.IdImpuesto
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
	LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0))
	ORDER BY TiposComprobante.Descripcion, Impuestos.NumeroTramite, Impuestos.Fecha, #Auxiliar2.NumeroCuota
   END

IF @IdTipoComprobante=110 and @Detallado='D'
   BEGIN
	SET @vector_X='011111111111111111133'
	SET @vector_T='01992E341125550255500'

	SELECT 
	 #Auxiliar2.IdImpuesto as [IdImpuesto],
	 Articulos.Codigo as [Ord.Perm.],
	 Impuestos.IdImpuesto as [IdAux1],
	 #Auxiliar2.NumeroCuota [IdAux2],
	 Articulos.NumeroPatente as [Patente],
	 Articulos.Descripcion as [Equipo imputado],
	 Modelos.Descripcion as [Modelo],
	 Impuestos.Fecha as [Fecha],
	 #Auxiliar2.Año as [Año],
	 #Auxiliar2.NumeroCuota [Cuota],
	 #Auxiliar2.Importe as [Importe],
	 #Auxiliar2.FechaVencimiento1 as [Fecha Vto.1],
	 #Auxiliar2.FechaVencimiento2 as [Fecha Vto.2],
	 #Auxiliar2.FechaVencimiento3 as [Fecha Vto.3],
	 Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago) as [Orden de pago],
	 Cuentas.Codigo as [Codigo],
	 Cuentas.Descripcion as [Cuenta contable],
	 Impuestos.Observaciones as [Observaciones],
	 Impuestos.EnUsoPor as [En uso por],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = #Auxiliar2.IdImpuesto
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
	LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0))
	ORDER BY TiposComprobante.Descripcion, Impuestos.NumeroTramite, Impuestos.Fecha, #Auxiliar2.NumeroCuota
   END

IF @IdTipoComprobante=111 and @Detallado='R'
   BEGIN
	SET @vector_X='01111111111133'
	SET @vector_T='05991512435500'

	SELECT 
	 #Auxiliar2.IdImpuesto as [IdImpuesto],
	 Impuestos.Detalle as [Detalle],
	 Impuestos.IdImpuesto as [IdAux1],
	 #Auxiliar2.NumeroCuota [IdAux2],
	 Impuestos.NumeroTramite as [Nro. tramite],
	 Impuestos.TipoPlan as [Tipo Plan],
	 Impuestos.CodigoPlan as [Nro.Plan],
	 Impuestos.Agencia as [Agencia],
	 Impuestos.Fecha as [Fecha],
	 Cuentas.Codigo as [Codigo],
	 Cuentas.Descripcion as [Cuenta contable],
	 Impuestos.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = #Auxiliar2.IdImpuesto
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
	LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0))
	ORDER BY TiposComprobante.Descripcion, Impuestos.NumeroTramite, Impuestos.Fecha, #Auxiliar2.NumeroCuota
   END

IF @IdTipoComprobante=111 and @Detallado='D'
   BEGIN
	SET @vector_X='01111111111111111133'
	SET @vector_T='05991512125550435500'

	SELECT 
	 #Auxiliar2.IdImpuesto as [IdImpuesto],
	 Impuestos.Detalle as [Detalle],
	 Impuestos.IdImpuesto as [IdAux1],
	 #Auxiliar2.NumeroCuota [IdAux2],
	 Impuestos.NumeroTramite as [Nro. tramite],
	 Impuestos.TipoPlan as [Tipo Plan],
	 Impuestos.CodigoPlan as [Nro.Plan],
	 Impuestos.Agencia as [Agencia],
	 #Auxiliar2.NumeroCuota [Cuota],
	 #Auxiliar2.Importe as [Importe],
	 #Auxiliar2.FechaVencimiento1 as [Fecha Vto.1],
	 #Auxiliar2.FechaVencimiento2 as [Fecha Vto.2],
	 #Auxiliar2.FechaVencimiento3 as [Fecha Vto.3],
	 Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago) as [Orden de pago],
	 Impuestos.Fecha as [Fecha],
	 Cuentas.Codigo as [Codigo],
	 Cuentas.Descripcion as [Cuenta contable],
	 Impuestos.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = #Auxiliar2.IdImpuesto
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = Impuestos.IdEquipoImputado
	LEFT OUTER JOIN Modelos ON Modelos.IdModelo = Articulos.IdModelo
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0))
	ORDER BY TiposComprobante.Descripcion, Impuestos.NumeroTramite, Impuestos.Fecha, #Auxiliar2.NumeroCuota
   END

IF @IdTipoComprobante=111 and @Detallado='I'
   BEGIN
	SET @vector_X='011111111133'
	SET @vector_T='0G4144444000'

	SELECT 
	 #Auxiliar2.IdImpuesto as [IdImpuesto],
	 Impuestos.NumeroTramite as [Nro. tramite],
	 Impuestos.Detalle as [Detalle],
	 #Auxiliar2.NumeroCuota [Cuota],
	 #Auxiliar2.FechaVencimiento1 as [Fecha Vto.1],
	 #Auxiliar2.FechaVencimiento2 as [Fecha Vto.2],
	 #Auxiliar2.FechaVencimiento3 as [Fecha Vto.3],
	 #Auxiliar2.Importe as [Importe],
	 op.FechaOrdenPago as [Fecha op],
	 Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago) as [Orden de pago],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = #Auxiliar2.IdImpuesto
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar2.IdOrdenPago
	WHERE (@Pendientes='T' or (@Pendientes='P' and IsNull(#Auxiliar2.IdOrdenPago,0)=0))
	ORDER BY TiposComprobante.Descripcion, Impuestos.NumeroTramite, Impuestos.Fecha, #Auxiliar2.NumeroCuota
   END

IF @IdTipoComprobante=111 and @Detallado='V' and @TramiteOCuenta='T'
   BEGIN
	SET @vector_X='001111111133'
	SET @vector_T='0034GGG00400'

	SELECT 
	 #Auxiliar2.IdImpuesto as [IdImpuesto],
	 1 as [IdAux1],
	 Impuestos.Detalle as [Detalle],
	 #Auxiliar2.FechaVencimiento1 as [Fecha cons.],
	 Impuestos.NumeroTramite as [Nro. tramite],
	 Impuestos.Agencia as [Agencia],
	 Impuestos.CodigoPlan as [Nro. plan],
	 Impuestos.TipoPlan as [Tipo plan],
	 #Auxiliar2.NumeroCuota [Cuota],
	 #Auxiliar2.Importe as [Importe],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = #Auxiliar2.IdImpuesto
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	
	UNION ALL
	
	SELECT 
	 0 as [IdImpuesto],
	 2 as [IdAux1],
	 'TOTAL' as [Detalle],
	 Null as [Fecha cons.],
	 Null as [Nro. tramite],
	 Null as [Agencia],
	 Null as [Nro. plan],
	 Null as [Tipo plan],
	 Null [Cuota],
	 Sum(IsNull(#Auxiliar2.Importe,0)) as [Importe],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2

	ORDER BY [IdAux1], [Nro. tramite], [Fecha cons.]
   END

IF @IdTipoComprobante=111 and @Detallado='V' and @TramiteOCuenta='C'
   BEGIN
	SET @vector_X='001111111133'
	SET @vector_T='0034GGG00400'

	SELECT 
	 #Auxiliar2.IdImpuesto as [IdImpuesto],
	 1 as [IdAux1],
	 Impuestos.Detalle as [Detalle],
	 #Auxiliar2.FechaVencimiento1 as [Fecha cons.],
	 Impuestos.NumeroTramite as [Nro. tramite],
	 Impuestos.Agencia as [Agencia],
	 Impuestos.CodigoPlan as [Nro. plan],
	 Impuestos.TipoPlan as [Tipo plan],
	 #Auxiliar2.NumeroCuota [Cuota],
	 #Auxiliar2.Importe as [Importe],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Impuestos ON Impuestos.IdImpuesto = #Auxiliar2.IdImpuesto
	LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = Impuestos.IdTipoComprobante
	LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = Impuestos.IdCuenta
	
	UNION ALL
	
	SELECT 
	 0 as [IdImpuesto],
	 2 as [IdAux1],
	 'TOTAL' as [Detalle],
	 Null as [Fecha cons.],
	 Null as [Nro. tramite],
	 Null as [Agencia],
	 Null as [Nro. plan],
	 Null as [Tipo plan],
	 Null [Cuota],
	 Sum(IsNull(#Auxiliar2.Importe,0)) as [Importe],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2

	ORDER BY [IdAux1], [Nro. tramite], [Fecha cons.]
   END

DROP TABLE #Auxiliar2