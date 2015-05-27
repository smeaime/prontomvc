CREATE PROCEDURE [dbo].[PresupuestoFinanciero_TX_DetallePorRubroContable]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int, 
		@IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int, @IdTipoComprobanteDeposito int, @LimitarTipoComprobante varchar(100)

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDeposito=(Select Top 1 IdTipoComprobanteDeposito From Parametros Where IdParametro=1)
SET @LimitarTipoComprobante=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
									Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
									Where pic.Clave='Tipos de comprobante en detalle de imputaciones por rubro para presupuesto financiero'),'')

CREATE TABLE #Auxiliar1
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 IdRubroContable INTEGER,
			 Tipo VARCHAR(5),
			 Fecha DATETIME,
			 Numero INTEGER,
			 Entidad VARCHAR(100),
			 Observaciones NTEXT,
			 Importe NUMERIC(18, 2)
			)

IF Len(@LimitarTipoComprobante)=0 or Patindex('%(OP)%', @LimitarTipoComprobante)<>0
	INSERT INTO #Auxiliar1 
	 SELECT 
	  @IdTipoComprobanteOrdenPago,
	  DetOP.IdOrdenPago,
	  DetOP.IdRubroContable,
	  'OP',
	  op.FechaOrdenPago,
	  op.NumeroOrdenPago,
	  Case When op.IdProveedor is not null Then Proveedores.RazonSocial When op.IdCuenta is not null Then Cuentas.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS Else Null End,
	  op.Observaciones,
	  DetOP.Importe * IsNull(op.CotizacionMoneda,1) * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
	 FROM DetalleOrdenesPagoRubrosContables DetOP
	 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
	 LEFT OUTER JOIN Proveedores ON op.IdProveedor = Proveedores.IdProveedor 
	 LEFT OUTER JOIN Cuentas ON op.IdCuenta = Cuentas.IdCuenta
	 LEFT OUTER JOIN RubrosContables ON DetOP.IdRubroContable=RubrosContables.IdRubroContable
	 WHERE op.FechaOrdenPago between @Desde and @hasta and (op.Confirmado is null or op.Confirmado<>'NO') and IsNull(op.Anulada,'NO')<>'SI'

IF Len(@LimitarTipoComprobante)=0 or Patindex('%(RE)%', @LimitarTipoComprobante)<>0
	INSERT INTO #Auxiliar1 
	 SELECT 
	  @IdTipoComprobanteRecibo,
	  DetRRC.IdRecibo,
	  DetRRC.IdRubroContable,
	  'RE',
	  Recibos.FechaRecibo,
	  Recibos.NumeroRecibo,
	  Case When Recibos.IdCliente is not null Then Clientes.RazonSocial When Recibos.IdCuenta is not null Then Cuentas.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS Else Null End,
	  Recibos.Observaciones,
	  DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1) * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
	 FROM DetalleRecibosRubrosContables DetRRC
	 LEFT OUTER JOIN Recibos ON DetRRC.IdRecibo=Recibos.IdRecibo
	 LEFT OUTER JOIN Clientes ON Recibos.IdCliente = Clientes.IdCliente 
	 LEFT OUTER JOIN Cuentas ON Recibos.IdCuenta = Cuentas.IdCuenta
	 LEFT OUTER JOIN RubrosContables ON DetRRC.IdRubroContable=RubrosContables.IdRubroContable
	 WHERE Recibos.FechaRecibo between @Desde and @hasta  and IsNull(Recibos.Anulado,'NO')<>'SI'

INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdTipoComprobante,
  DetVRC.IdValor,
  DetVRC.IdRubroContable,
  tc.DescripcionAb,
  Valores.FechaComprobante,
  Valores.NumeroComprobante,
  Null,
  '',
  DetVRC.Importe * IsNull(Valores.CotizacionMoneda,1) * Case When IsNull(tc.Coeficiente,1)=1 
								Then Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
								Else Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End 
							End
 FROM DetalleValoresRubrosContables DetVRC
 LEFT OUTER JOIN Valores ON DetVRC.IdValor=Valores.IdValor
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN RubrosContables ON DetVRC.IdRubroContable=RubrosContables.IdRubroContable
 WHERE Valores.FechaComprobante between @Desde and @hasta and (Len(@LimitarTipoComprobante)=0 or Patindex('%('+tc.DescripcionAb+')%', @LimitarTipoComprobante)<>0)

IF Len(@LimitarTipoComprobante)=0 or Patindex('%(PF)%', @LimitarTipoComprobante)<>0
  BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 
	  39,
	  Det.IdPlazoFijo,
	  Det.IdRubroContable,
	  'PF',
	  PlazosFijos.FechaInicioPlazoFijo,
	  PlazosFijos.NumeroCertificado1,
	  Null,
	  '',
	  Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
	 FROM DetallePlazosFijosRubrosContables Det
	 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
	 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
	 WHERE PlazosFijos.FechaInicioPlazoFijo between @Desde and @hasta and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='E'

	INSERT INTO #Auxiliar1 
	 SELECT 
	  39,
	  Det.IdPlazoFijo,
	  Det.IdRubroContable,
	  'PF',
	  PlazosFijos.FechaVencimiento,
	  PlazosFijos.NumeroCertificado1,
	  Null,
	  '',
	  Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) * Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then -1 Else 1 End
	 FROM DetallePlazosFijosRubrosContables Det
	 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
	 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
	 WHERE PlazosFijos.FechaVencimiento between @Desde and @hasta and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='I'
  END
  
SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00000011111111633'
SET @vector_T='00000049903439400'

SELECT
 1 as [K_Orden],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Tipo], 
 Null as [K_Numero], 
 RubrosContables.Descripcion as [Rubro contable],
 Null as [IdTipoComprobante],
 Null as [IdComprobante],
 Null as [Tipo], 
 Null as [Numero], 
 Null as [Fecha], 
 Null as [Entidad / Cuenta], 
 Null as [Observaciones], 
 Null as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable
GROUP BY #Auxiliar1.IdRubroContable,RubrosContables.Descripcion

UNION ALL

SELECT
 2 as [K_Orden],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 #Auxiliar1.Fecha as [K_Fecha], 
 #Auxiliar1.Tipo as [K_Tipo], 
 #Auxiliar1.Numero as [K_Numero], 
 RubrosContables.Descripcion as [Rubro contable],
 #Auxiliar1.IdTipoComprobante as [IdTipoComprobante],
 #Auxiliar1.IdComprobante as [IdComprobante],
 #Auxiliar1.Tipo as [Tipo], 
 #Auxiliar1.Numero as [Numero], 
 #Auxiliar1.Fecha as [Fecha], 
 #Auxiliar1.Entidad as [Entidad / Cuenta], 
 #Auxiliar1.Observaciones as [Observaciones], 
 #Auxiliar1.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable

UNION ALL

SELECT
 3 as [K_Orden],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Tipo], 
 Null as [K_Numero], 
 '   TOTAL RUBRO' as [Rubro contable],
 Null as [IdTipoComprobante],
 Null as [IdComprobante],
 Null as [Tipo], 
 Null as [Numero], 
 Null as [Fecha], 
 Null as [Entidad / Cuenta], 
 Null as [Observaciones], 
 SUM(#Auxiliar1.Importe) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable
GROUP BY #Auxiliar1.IdRubroContable,RubrosContables.Descripcion

UNION ALL

SELECT
 4 as [K_Orden],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Tipo], 
 Null as [K_Numero], 
 Null as [Rubro contable],
 Null as [IdTipoComprobante],
 Null as [IdComprobante],
 Null as [Tipo], 
 Null as [Numero], 
 Null as [Entidad / Cuenta], 
 Null as [Observaciones], 
 Null as [Fecha], 
 Null as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable
GROUP BY #Auxiliar1.IdRubroContable,RubrosContables.Descripcion

UNION ALL

SELECT
 5 as [K_Orden],
 999999 as [K_IdRubro],
 'zzzz' as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Tipo], 
 Null as [K_Numero], 
 'TOTAL GENERAL' as [Rubro contable],
 Null as [IdTipoComprobante],
 Null as [IdComprobante],
 Null as [Tipo], 
 Null as [Numero], 
 Null as [Fecha], 
 Null as [Entidad / Cuenta], 
 Null as [Observaciones], 
 SUM(#Auxiliar1.Importe) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 

ORDER BY [K_Rubro],[K_IdRubro],[K_Orden],[K_Fecha],[K_Tipo],[K_Numero]

DROP TABLE #Auxiliar1