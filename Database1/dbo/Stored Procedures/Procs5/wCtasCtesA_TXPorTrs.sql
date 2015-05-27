
CREATE PROCEDURE [dbo].[wCtasCtesA_TXPorTrs] @IdProveedor INT
	,@Todo INT
	,@FechaLimite DATETIME
	,@FechaDesde DATETIME = NULL
	,@Consolidar INT = NULL
	,@Pendiente VARCHAR(1) = NULL
AS
SET @FechaDesde = IsNull(@FechaDesde, Convert(DATETIME, '1/1/2000'))
SET @Consolidar = IsNull(@Consolidar, - 1)
SET @Pendiente = IsNull(@Pendiente, 'N')

DECLARE @IdTipoComprobanteOrdenPago INT
	,@SaldoInicial NUMERIC(18, 2)
	,@MostrarPedidos VARCHAR(2)
	,@MostrarOrdenPago VARCHAR(2)
	,@MostrarRecibos VARCHAR(2)

--en pronto ini
SET @IdTipoComprobanteOrdenPago = (
		SELECT TOP 1 IdTipoComprobanteOrdenPago
		FROM Parametros
		WHERE IdParametro = 1
		)
SET @MostrarPedidos = Isnull((
			SELECT TOP 1 ProntoIni.Valor
			FROM ProntoIni
			LEFT OUTER JOIN ProntoIniClaves pic ON pic.IdProntoIniClave = ProntoIni.IdProntoIniClave
			WHERE pic.Clave = 'Mostrar pedidos en resumen de cuenta corriente acreedores'
				AND IsNull(ProntoIni.Valor, '') = 'SI'
			), '')

--en parametros generales
--http://bdlconsultores.ddns.net/Consultas/Admin/verConsultas1.php?recordid=12757
--SELECT EmiteAsientoEnOP FROM Parametros
SELECT @MostrarOrdenPago = EmiteAsientoEnOP
FROM Parametros


SELECT @MostrarRecibos = valor
FROM Parametros2
where Campo = 'EmiteAsientoEnRECIBO'
--delete parametros2 where campo='EmiteAsientoEnRECIBO'
--insert into  Parametros2 (campo,valor )values ('EmiteAsientoEnRECIBO','NO') 
-- select * from Parametros2 where Campo = 'EmiteAsientoEnRE'

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (
	IdCtaCte INTEGER
	,IdTipoComp INTEGER
	,Coeficiente INTEGER
	,IdImputacion INTEGER
	,Saldo NUMERIC(18, 2)
	)

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (
	IdImputacion
	,IdCtaCte
	) ON [PRIMARY]

CREATE TABLE #Auxiliar2 (
	IdImputacion INTEGER
	,Saldo NUMERIC(18, 2)
	)

CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdImputacion) ON [PRIMARY]

INSERT INTO #Auxiliar1
SELECT CtaCte.IdCtaCte
	,CtaCte.IdTipoComp
	,IsNull(TiposComprobante.Coeficiente, 1)
	,CtaCte.IdImputacion
	,CtaCte.Saldo
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = CtaCte.IdTipoComp
WHERE CtaCte.IdProveedor = @IdProveedor
	AND (
		@Todo = - 1
		OR CtaCte.Fecha BETWEEN @FechaDesde
			AND @FechaLimite
		)

/*  CURSOR  */
DECLARE @IdTrs INT
	,@IdCtaCte INT
	,@IdTipoComp INT
	,@Coeficiente INT
	,@IdImputacion INT
	,@Saldo NUMERIC(18, 2)
	,@Saldo1 NUMERIC(18, 2)

SET @IdTrs = 0
SET @Saldo1 = 0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY
FOR
SELECT IdCtaCte
	,IdTipoComp
	,Coeficiente
	,IdImputacion
	,Saldo
FROM #Auxiliar1
ORDER BY IdImputacion
	,IdCtaCte

OPEN Cur

FETCH NEXT
FROM Cur
INTO @IdCtaCte
	,@IdTipoComp
	,@Coeficiente
	,@IdImputacion
	,@Saldo

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @IdTrs <> IsNull(@IdImputacion, - 1)
	BEGIN
		IF @IdTrs <> 0
			INSERT INTO #Auxiliar2 (
				IdImputacion
				,Saldo
				)
			VALUES (
				@IdTrs
				,@Saldo1
				)

		SET @Saldo1 = 0
		SET @IdTrs = IsNull(@IdImputacion, - 1)
	END

	SET @Saldo1 = @Saldo1 + (@Saldo * @Coeficiente * - 1)

	FETCH NEXT
	FROM Cur
	INTO @IdCtaCte
		,@IdTipoComp
		,@Coeficiente
		,@IdImputacion
		,@Saldo
END

IF @IdTrs <> 0
BEGIN
	INSERT INTO #Auxiliar2 (
		IdImputacion
		,Saldo
		)
	VALUES (
		@IdTrs
		,@Saldo1
		)
END

CLOSE Cur

DEALLOCATE Cur

IF @Pendiente = 'S'
BEGIN
	DELETE #Auxiliar1
	WHERE IsNull((
				SELECT TOP 1 #Auxiliar2.Saldo
				FROM #Auxiliar2
				WHERE #Auxiliar2.IdImputacion = IsNull(#Auxiliar1.IdImputacion, - 1)
				), 0) = 0

	DELETE #Auxiliar2
	WHERE IsNull(Saldo, 0) = 0
END



IF  IsNull(@MostrarOrdenPago, 'NO') = 'NO'
BEGIN
	print 2
	--DELETE #Auxiliar1
	--WHERE IdTipoComp = 17
	
	--update #Auxiliar1
	--set 
	--WHERE IdTipoComp = 17
END



IF IsNull(@MostrarRecibos, 'NO') = 'NO'
BEGIN
	print 2
	--DELETE #Auxiliar1
	--WHERE IdTipoComp = 2
END



CREATE TABLE #Auxiliar10 (
	IdComprobanteProveedor INTEGER
	,Pedidos VARCHAR(1000)
	)

CREATE TABLE #Auxiliar11 (
	IdComprobanteProveedor INTEGER
	,Pedido VARCHAR(20)
	)

CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (
	IdComprobanteProveedor
	,Pedido
	) ON [PRIMARY]

CREATE TABLE #Auxiliar12 (
	IdComprobanteProveedor INTEGER
	,Pedido VARCHAR(20)
	)

IF @MostrarPedidos = 'SI'
BEGIN
	INSERT INTO #Auxiliar12
	SELECT Det.IdComprobanteProveedor
		,CASE 
			WHEN IsNull(Pedidos.PuntoVenta, 0) <> 0
				THEN Substring('0000', 1, 4 - Len(Convert(VARCHAR, IsNull(Pedidos.PuntoVenta, 0)))) + Convert(VARCHAR, IsNull(Pedidos.PuntoVenta, 0)) + '-' + Substring('00000000', 1, 8 - Len(Convert(VARCHAR, Pedidos.NumeroPedido))) + Convert(VARCHAR, Pedidos.NumeroPedido) + IsNull('/' + Convert(VARCHAR, Pedidos.SubNumero), '')
			ELSE Substring('00000000', 1, 8 - Len(Convert(VARCHAR, Pedidos.NumeroPedido))) + Convert(VARCHAR, Pedidos.NumeroPedido) + IsNull('/' + Convert(VARCHAR, Pedidos.SubNumero), '')
			END
	FROM DetalleComprobantesProveedores Det
	LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = Det.IdComprobanteProveedor
	LEFT OUTER JOIN DetalleRecepciones ON DetalleRecepciones.IdDetalleRecepcion = Det.IdDetalleRecepcion
	LEFT OUTER JOIN DetallePedidos ON DetallePedidos.IdDetallePedido = IsNull(Det.IdDetallePedido, DetalleRecepciones.IdDetallePedido)
	LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetallePedidos.IdPedido
	WHERE cp.IdProveedor = @IdProveedor
		AND IsNull(Pedidos.Cumplido, '') <> 'AN'

	INSERT INTO #Auxiliar12
	SELECT Det.IdComprobanteProveedor
		,CASE 
			WHEN IsNull(Pedidos.PuntoVenta, 0) <> 0
				THEN Substring('0000', 1, 4 - Len(Convert(VARCHAR, IsNull(Pedidos.PuntoVenta, 0)))) + Convert(VARCHAR, IsNull(Pedidos.PuntoVenta, 0)) + '-' + Substring('00000000', 1, 8 - Len(Convert(VARCHAR, Pedidos.NumeroPedido))) + Convert(VARCHAR, Pedidos.NumeroPedido) + IsNull('/' + Convert(VARCHAR, Pedidos.SubNumero), '')
			ELSE Substring('00000000', 1, 8 - Len(Convert(VARCHAR, Pedidos.NumeroPedido))) + Convert(VARCHAR, Pedidos.NumeroPedido) + IsNull('/' + Convert(VARCHAR, Pedidos.SubNumero), '')
			END
	FROM DetalleComprobantesProveedores Det
	LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = Det.IdComprobanteProveedor
	LEFT OUTER JOIN DetalleSubcontratosDatos ON DetalleSubcontratosDatos.IdDetalleSubcontratoDatos = Det.IdDetalleSubcontratoDatos
	LEFT OUTER JOIN DetalleSubcontratosDatosPedidos ON DetalleSubcontratosDatosPedidos.IdSubcontratoDatos = DetalleSubcontratosDatos.IdSubcontratoDatos
	LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetalleSubcontratosDatosPedidos.IdPedido
	WHERE cp.IdProveedor = @IdProveedor
		AND Det.IdDetalleSubcontratoDatos IS NOT NULL
		AND IsNull(Pedidos.Cumplido, '') <> 'AN'

	INSERT INTO #Auxiliar12
	SELECT Det.IdComprobanteProveedor
		,CASE 
			WHEN IsNull(Pedidos.PuntoVenta, 0) <> 0
				THEN Substring('0000', 1, 4 - Len(Convert(VARCHAR, IsNull(Pedidos.PuntoVenta, 0)))) + Convert(VARCHAR, IsNull(Pedidos.PuntoVenta, 0)) + '-' + Substring('00000000', 1, 8 - Len(Convert(VARCHAR, Pedidos.NumeroPedido))) + Convert(VARCHAR, Pedidos.NumeroPedido) + IsNull('/' + Convert(VARCHAR, Pedidos.SubNumero), '')
			ELSE Substring('00000000', 1, 8 - Len(Convert(VARCHAR, Pedidos.NumeroPedido))) + Convert(VARCHAR, Pedidos.NumeroPedido) + IsNull('/' + Convert(VARCHAR, Pedidos.SubNumero), '')
			END
	FROM DetalleComprobantesProveedores Det
	LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = Det.IdComprobanteProveedor
	LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = Det.IdPedido
	WHERE cp.IdProveedor = @IdProveedor
		AND Det.IdPedido IS NOT NULL
		AND IsNull(Pedidos.Cumplido, '') <> 'AN'

	INSERT INTO #Auxiliar11
	SELECT DISTINCT IdComprobanteProveedor
		,Pedido
	FROM #Auxiliar12

	INSERT INTO #Auxiliar10
	SELECT IdComprobanteProveedor
		,''
	FROM #Auxiliar11
	GROUP BY IdComprobanteProveedor

	/*  CURSOR  */
	DECLARE @IdComprobanteProveedor INT
		,@Pedido VARCHAR(20)
		,@Corte INT
		,@P VARCHAR(1000)

	SET @Corte = 0
	SET @P = ''

	DECLARE Cur CURSOR LOCAL FORWARD_ONLY
	FOR
	SELECT IdComprobanteProveedor
		,Pedido
	FROM #Auxiliar11
	ORDER BY IdComprobanteProveedor

	OPEN Cur

	FETCH NEXT
	FROM Cur
	INTO @IdComprobanteProveedor
		,@Pedido

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Corte <> @IdComprobanteProveedor
		BEGIN
			IF @Corte <> 0
				UPDATE #Auxiliar10
				SET Pedidos = SUBSTRING(@P, 1, 1000)
				WHERE IdComprobanteProveedor = @Corte

			SET @P = ''
			SET @Corte = @IdComprobanteProveedor
		END

		IF NOT @Pedido IS NULL
			IF PATINDEX('%' + @Pedido + ' ' + '%', @P) = 0
				SET @P = @P + @Pedido + ' '

		FETCH NEXT
		FROM Cur
		INTO @IdComprobanteProveedor
			,@Pedido
	END

	IF @Corte <> 0
		UPDATE #Auxiliar10
		SET Pedidos = SUBSTRING(@P, 1, 1000)
		WHERE IdComprobanteProveedor = @Corte

	CLOSE Cur

	DEALLOCATE Cur
END

SET NOCOUNT OFF

DECLARE @vector_X VARCHAR(30)
	,@vector_T VARCHAR(30)
	,@vector_E VARCHAR(1000)

SET @vector_X = '001111111881111115111133'

IF @MostrarPedidos = 'SI'
	SET @vector_T = '00099714455449993A99B900'
ELSE
	SET @vector_T = '00099714455449993E999900'

SET @vector_E = '  |  |  |  |  | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 | NUM:#COMMA##0.00 |  |  |  |  '

SELECT #Auxiliar1.IdCtaCte AS [IdCtaCte]
	,#Auxiliar1.IdImputacion AS [IdImputacion]
	,TiposComprobante.DescripcionAB AS [Comp.]
	,CtaCte.IdTipoComp AS [IdTipoComp]
	,CtaCte.IdComprobante AS [IdComprobante]
	,CASE 
		WHEN CtaCte.IdTipoComp = @IdTipoComprobanteOrdenPago
			OR CtaCte.IdTipoComp = 16
			OR cp.IdComprobanteProveedor IS NULL
			THEN Substring(Substring('00000000', 1, 8 - Len(Convert(VARCHAR, CtaCte.NumeroComprobante))) + Convert(VARCHAR, CtaCte.NumeroComprobante), 1, 15)
		ELSE Substring(cp.Letra + '-' + Substring('0000', 1, 4 - Len(Convert(VARCHAR, cp.NumeroComprobante1))) + Convert(VARCHAR, cp.NumeroComprobante1) + '-' + Substring('00000000', 1, 8 - Len(Convert(VARCHAR, cp.NumeroComprobante2))) + Convert(VARCHAR, cp.NumeroComprobante2), 1, 15)
		END AS [Numero]
	,CtaCte.NumeroComprobante AS [Ref.]
	,CtaCte.Fecha AS [Fecha]
	,CtaCte.FechaVencimiento AS [Fecha vto.]
	,CASE 
		WHEN TiposComprobante.Coeficiente = 1
			THEN CtaCte.ImporteTotal * - 1
		ELSE CtaCte.ImporteTotal
		END AS [Imp.orig.]
	,CASE 
		WHEN @Todo = - 1
			THEN CASE 
					WHEN TiposComprobante.Coeficiente = 1
						THEN CtaCte.Saldo * - 1
					ELSE CtaCte.Saldo
					END
		ELSE CASE 
				WHEN TiposComprobante.Coeficiente = 1
					THEN CtaCte.ImporteTotal * - 1
				ELSE CtaCte.ImporteTotal
				END
		END AS [Saldo Comp.]
	,CtaCte.SaldoTrs AS [SaldoTrs]
	,CASE 
		WHEN CtaCte.IdTipoComp = @IdTipoComprobanteOrdenPago
			OR CtaCte.IdTipoComp = 16
			THEN NULL
		ELSE cp.FechaComprobante
		END AS [Fecha cmp.]
	,CtaCte.IdImputacion AS [IdImpu]
	,Convert(NUMERIC(18, 2), CtaCte.Saldo) * TiposComprobante.Coeficiente * - 1 AS [Saldo]
	,CASE 
		WHEN CtaCte.IdCtaCte = IsNull(CtaCte.IdImputacion, 0)
			THEN '0'
		ELSE '1'
		END AS [Cabeza]
	,Monedas.Abreviatura AS [Mon.origen]
	,CASE 
		WHEN CtaCte.IdTipoComp = @IdTipoComprobanteOrdenPago
			THEN IsNull(Convert(VARCHAR(1000), OrdenesPago.Observaciones COLLATE SQL_Latin1_General_CP1_CI_AS), '')
		ELSE IsNull(Convert(VARCHAR(1000), cp.Observaciones), '')
		END AS [Observaciones]
	,CtaCte.IdProveedor AS [IdProveedor]
	,CtaCte.IdCtaCte AS [IdAux1]
	,#Auxiliar10.Pedidos AS [Pedidos]
	,@Vector_E AS Vector_E
	,@Vector_T AS Vector_T
	,@Vector_X AS Vector_X
	,OrdenesPago.RetencionIVA AS [Ret.IVA]
	,OrdenesPago.RetencionGanancias AS [Ret.gan.]
	,OrdenesPago.RetencionIBrutos AS [Ret.ing.b.]
	,OrdenesPago.RetencionSUSS AS [Ret.SUSS]
FROM #Auxiliar1
LEFT OUTER JOIN CuentasCorrientesAcreedores CtaCte ON CtaCte.IdCtaCte = #Auxiliar1.IdCtaCte
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor = CtaCte.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante = CtaCte.IdTipoComp
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor = CtaCte.IdComprobante
	AND CtaCte.IdTipoComp <> @IdTipoComprobanteOrdenPago
	AND CtaCte.IdTipoComp <> 16
LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago = CtaCte.IdComprobante
	AND (
		CtaCte.IdTipoComp = @IdTipoComprobanteOrdenPago
		OR CtaCte.IdTipoComp = 16
		)
LEFT OUTER JOIN Monedas ON CtaCte.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN #Auxiliar10 ON cp.IdComprobanteProveedor = #Auxiliar10.IdComprobanteProveedor

UNION ALL

SELECT 0 AS [IdCtaCte]
	,#Auxiliar2.IdImputacion AS [IdImputacion]
	,NULL AS [Comp.]
	,NULL AS [IdTipoComp]
	,NULL AS [IdComprobante]
	,NULL AS [Numero]
	,NULL AS [Ref.]
	,NULL AS [Fecha]
	,NULL AS [Fecha vto.]
	,NULL AS [Imp.orig.]
	,NULL AS [Saldo Comp.]
	,#Auxiliar2.Saldo AS [SaldoTrs]
	,NULL AS [Fecha cmp.]
	,NULL AS [IdImpu]
	,NULL AS [Saldo]
	,'9' AS [Cabeza]
	,NULL AS [Mon.origen]
	,NULL AS [Observaciones]
	,NULL AS [IdProveedor]
	,0 AS [IdAux1]
	,NULL AS [Pedidos]
	,@Vector_E AS Vector_E
	,@Vector_T AS Vector_T
	,@Vector_X AS Vector_X
	,0 AS [Ret.IVA]
	,0 AS [Ret.gan.]
	,0 AS [Ret.ing.b.]
	,0 AS [Ret.SUSS]
FROM #Auxiliar2
ORDER BY [IdImputacion]
	,[Cabeza]
	,[Fecha]
	,[Numero]

DROP TABLE #Auxiliar1

DROP TABLE #Auxiliar2

DROP TABLE #Auxiliar10

DROP TABLE #Auxiliar11

DROP TABLE #Auxiliar12
