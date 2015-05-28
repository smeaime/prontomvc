CREATE PROCEDURE [dbo].[CuboPresupuestoFinanciero]

@Dts varchar(200)

AS

SET NOCOUNT ON

TRUNCATE TABLE _TempCuboPresupuestoFinanciero

/*   PROCESO DE INGRESOS   */

CREATE TABLE #Auxiliar1
			(
			 IdRecibo INTEGER,
			 Fecha DATETIME,
			 Detalle VARCHAR(100),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetRV.IdRecibo,
  ISNULL(DetRV.FechaVencimiento,Recibos.FechaRecibo),
  Substring('RE '+Convert(varchar,IsNull(Recibos.NumeroRecibo,0)) + ' ' + IsNull(TiposComprobante.DescripcionAB+' ','') + IsNull(Convert(varchar,DetRV.NumeroValor)+' ','') + 
		IsNull('Vto. '+Convert(varchar,DetRV.FechaVencimiento,103)+' ','') + IsNull(Bancos.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS+' ','') + 
		IsNull(Cajas.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS+' ','') + IsNull(Clientes.RazonSocial COLLATE SQL_Latin1_General_CP1_CI_AS+' ','') + 
		IsNull(Replace(Convert(varchar,IsNull(Recibos.Observaciones,'')),Char(13) + Char(10),' '),''),1,100),
  DetRV.Importe * IsNull(Recibos.CotizacionMoneda,1)
 FROM DetalleRecibosValores DetRV
 LEFT OUTER JOIN Recibos ON DetRV.IdRecibo=Recibos.IdRecibo
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetRV.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetRV.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetRV.IdCaja
 LEFT OUTER JOIN Valores ON Valores.IdDetalleReciboValores=DetRV.IdDetalleReciboValores
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=Recibos.IdCliente
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and IsNull(Recibos.Anulado,'NO')<>'SI' --and Valores.Estado is null


CREATE TABLE #Auxiliar2
			(
			 IdRecibo INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  DetRV.IdRecibo,
  SUM(IsNull(DetRV.Importe,0) * IsNull(Recibos.CotizacionMoneda,1))
 FROM DetalleRecibosValores DetRV
 LEFT OUTER JOIN Recibos ON DetRV.IdRecibo=Recibos.IdRecibo
 LEFT OUTER JOIN Valores ON Valores.IdDetalleReciboValores=DetRV.IdDetalleReciboValores
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and IsNull(Recibos.Anulado,'NO')<>'SI'
 GROUP BY DetRV.IdRecibo


/*   PROCESO DE EGRESOS   */

CREATE TABLE #Auxiliar4
			(
			 IdOrdenPago INTEGER,
			 Fecha DATETIME,
			 Detalle VARCHAR(100),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  DetOPV.IdOrdenPago,
  IsNull(DetOPV.FechaVencimiento,OrdenesPago.FechaOrdenPago),
  Substring('OP '+Convert(varchar,IsNull(OrdenesPago.NumeroOrdenPago,0)) + ' ' + 
		IsNull(TiposComprobante.DescripcionAB,'') + Case When DetOPV.IdValor is not null Then +' (Terc.)' Else ' ' End + IsNull(Convert(varchar,DetOPV.NumeroValor)+' ','') + 
		IsNull('Vto. '+Convert(varchar,DetOPV.FechaVencimiento,103)+' ','') + IsNull(Bancos.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS+' ','') + 
		IsNull(Cajas.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS+' ','') + IsNull(Proveedores.RazonSocial COLLATE SQL_Latin1_General_CP1_CI_AS+' ','') + 
		IsNull(Replace(Convert(varchar,IsNull(OrdenesPago.Observaciones,'')),Char(13) + Char(10),' '),''),1,100),
  DetOPV.Importe * IsNull(OrdenesPago.CotizacionMoneda,1)
 FROM DetalleOrdenesPagoValores DetOPV
 LEFT OUTER JOIN OrdenesPago ON DetOPV.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetOPV.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetOPV.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetOPV.IdCaja
 LEFT OUTER JOIN Valores ON Valores.IdDetalleOrdenPagoValores=DetOPV.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=OrdenesPago.IdProveedor
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and IsNull(OrdenesPago.Anulada,'NO')<>'SI' --and DetOPV.IdValor is null


CREATE TABLE #Auxiliar5
			(
			 IdOrdenPago INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar5 
 SELECT 
  DetOPV.IdOrdenPago,
  SUM(IsNull(DetOPV.Importe,0) * IsNull(OrdenesPago.CotizacionMoneda,1))
 FROM DetalleOrdenesPagoValores DetOPV
 LEFT OUTER JOIN OrdenesPago ON DetOPV.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN Valores ON Valores.IdDetalleOrdenPagoValores=DetOPV.IdDetalleOrdenPagoValores
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and IsNull(OrdenesPago.Anulada,'NO')<>'SI'
 GROUP BY DetOPV.IdOrdenPago

/*   ARMADO DE TABLA FINAL   */

INSERT INTO _TempCuboPresupuestoFinanciero 

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else 'SIN OBRA' End,
  '1.INGRESOS',
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  #Auxiliar1.Fecha,
  Year(#Auxiliar1.Fecha),
  Case 	When Month(#Auxiliar1.Fecha)=1 Then '01 Enero'
	When Month(#Auxiliar1.Fecha)=2 Then '02 Febrero'
	When Month(#Auxiliar1.Fecha)=3 Then '03 Marzo'
	When Month(#Auxiliar1.Fecha)=4 Then '04 Abril'
	When Month(#Auxiliar1.Fecha)=5 Then '05 Mayo'
	When Month(#Auxiliar1.Fecha)=6 Then '06 Junio'
	When Month(#Auxiliar1.Fecha)=7 Then '07 Julio'
	When Month(#Auxiliar1.Fecha)=8 Then '08 Agosto'
	When Month(#Auxiliar1.Fecha)=9 Then '09 Setiembre'
	When Month(#Auxiliar1.Fecha)=10 Then '10 Octubre'
	When Month(#Auxiliar1.Fecha)=11 Then '11 Noviembre'
	When Month(#Auxiliar1.Fecha)=12 Then '12 Diciembre'
	ELSE 'Error'
  End,
  'Semana '+  
  Convert(varchar,Case When (Day(#Auxiliar1.Fecha)-1)/7+1<5 Then (Day(#Auxiliar1.Fecha)-1)/7+1 Else 4 End),
  #Auxiliar1.Detalle,
  0,
  Case When IsNull(#Auxiliar2.Importe,1)<>0
	Then #Auxiliar1.Importe / IsNull(#Auxiliar2.Importe,1) * (DetRRC.Importe * IsNull(Recibos.CotizacionMoneda,1))
	Else 0
  End -- * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End * -1
 FROM DetalleRecibosRubrosContables DetRRC
 LEFT OUTER JOIN #Auxiliar1 ON DetRRC.IdRecibo=#Auxiliar1.IdRecibo
 LEFT OUTER JOIN #Auxiliar2 ON DetRRC.IdRecibo=#Auxiliar2.IdRecibo
 LEFT OUTER JOIN Recibos ON DetRRC.IdRecibo=Recibos.IdRecibo
 LEFT OUTER JOIN RubrosContables ON DetRRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
 WHERE #Auxiliar1.IdRecibo=DetRRC.IdRecibo and IsNull(Recibos.Anulado,'NO')<>'SI'

UNION ALL

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else 'SIN OBRA' End,
  '2.EGRESOS',
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  #Auxiliar4.Fecha,
  Year(#Auxiliar4.Fecha),
  Case 	When Month(#Auxiliar4.Fecha)=1 Then '01 Enero'
	When Month(#Auxiliar4.Fecha)=2 Then '02 Febrero'
	When Month(#Auxiliar4.Fecha)=3 Then '03 Marzo'
	When Month(#Auxiliar4.Fecha)=4 Then '04 Abril'
	When Month(#Auxiliar4.Fecha)=5 Then '05 Mayo'
	When Month(#Auxiliar4.Fecha)=6 Then '06 Junio'
	When Month(#Auxiliar4.Fecha)=7 Then '07 Julio'
	When Month(#Auxiliar4.Fecha)=8 Then '08 Agosto'
	When Month(#Auxiliar4.Fecha)=9 Then '09 Setiembre'
	When Month(#Auxiliar4.Fecha)=10 Then '10 Octubre'
	When Month(#Auxiliar4.Fecha)=11 Then '11 Noviembre'
	When Month(#Auxiliar4.Fecha)=12 Then '12 Diciembre'
	ELSE 'Error'
  End,
  'Semana '+  
  Convert(varchar,Case When (Day(#Auxiliar4.Fecha)-1)/7+1<5 Then (Day(#Auxiliar4.Fecha)-1)/7+1 Else 4 End),
  #Auxiliar4.Detalle,
  0,
  Case When IsNull(#Auxiliar5.Importe,1)<>0
	Then #Auxiliar4.Importe / IsNull(#Auxiliar5.Importe,1) * (DetOPRC.Importe * IsNull(OrdenesPago.CotizacionMoneda,1))
	Else 0
  End * -1 --* Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
 FROM DetalleOrdenesPagoRubrosContables DetOPRC
 LEFT OUTER JOIN #Auxiliar4 ON DetOPRC.IdOrdenPago=#Auxiliar4.IdOrdenPago
 LEFT OUTER JOIN #Auxiliar5 ON DetOPRC.IdOrdenPago=#Auxiliar5.IdOrdenPago
 LEFT OUTER JOIN OrdenesPago ON DetOPRC.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN RubrosContables ON DetOPRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
 WHERE #Auxiliar4.IdOrdenPago=DetOPRC.IdOrdenPago and IsNull(OrdenesPago.Anulada,'NO')<>'SI'
/*

En definitiva se toman los recibos positivos, op negativas, dbg negativos y cbg positivos
UNION ALL

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else 'SIN OBRA' End,
  '1.INGRESOS',
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  Valores.FechaComprobante,
  Year(Valores.FechaComprobante),
  Case 	When Month(Valores.FechaComprobante)=1 Then '01 Enero'
	When Month(Valores.FechaComprobante)=2 Then '02 Febrero'
	When Month(Valores.FechaComprobante)=3 Then '03 Marzo'
	When Month(Valores.FechaComprobante)=4 Then '04 Abril'
	When Month(Valores.FechaComprobante)=5 Then '05 Mayo'
	When Month(Valores.FechaComprobante)=6 Then '06 Junio'
	When Month(Valores.FechaComprobante)=7 Then '07 Julio'
	When Month(Valores.FechaComprobante)=8 Then '08 Agosto'
	When Month(Valores.FechaComprobante)=9 Then '09 Setiembre'
	When Month(Valores.FechaComprobante)=10 Then '10 Octubre'
	When Month(Valores.FechaComprobante)=11 Then '11 Noviembre'
	When Month(Valores.FechaComprobante)=12 Then '12 Diciembre'
	ELSE 'Error'
  End,
  'Semana '+  
  Convert(varchar,Case When (Day(Valores.FechaComprobante)-1)/7+1<5 Then (Day(Valores.FechaComprobante)-1)/7+1 Else 4 End),
  TiposComprobante.Descripcion+' '+Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+Convert(varchar,Valores.NumeroComprobante),
  0,
  DetVRC.Importe * IsNull(TiposComprobante.Coeficiente,1) * IsNull(Valores.CotizacionMoneda,1)
 FROM DetalleValoresRubrosContables DetVRC
 LEFT OUTER JOIN Valores ON DetVRC.IdValor=Valores.IdValor
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN RubrosContables ON DetVRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
 WHERE IsNull(RubrosContables.IngresoEgreso,'E')='I'
*/
UNION ALL

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else 'SIN OBRA' End,
  '2.EGRESOS',
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  Valores.FechaComprobante,
  Year(Valores.FechaComprobante),
  Case 	When Month(Valores.FechaComprobante)=1 Then '01 Enero'
	When Month(Valores.FechaComprobante)=2 Then '02 Febrero'
	When Month(Valores.FechaComprobante)=3 Then '03 Marzo'
	When Month(Valores.FechaComprobante)=4 Then '04 Abril'
	When Month(Valores.FechaComprobante)=5 Then '05 Mayo'
	When Month(Valores.FechaComprobante)=6 Then '06 Junio'
	When Month(Valores.FechaComprobante)=7 Then '07 Julio'
	When Month(Valores.FechaComprobante)=8 Then '08 Agosto'
	When Month(Valores.FechaComprobante)=9 Then '09 Setiembre'
	When Month(Valores.FechaComprobante)=10 Then '10 Octubre'
	When Month(Valores.FechaComprobante)=11 Then '11 Noviembre'
	When Month(Valores.FechaComprobante)=12 Then '12 Diciembre'
	ELSE 'Error'
  End,
  'Semana '+  
  Convert(varchar,Case When (Day(Valores.FechaComprobante)-1)/7+1<5 Then (Day(Valores.FechaComprobante)-1)/7+1 Else 4 End),
  TiposComprobante.Descripcion+' '+Substring('0000000000',1,10-Len(Convert(varchar,Valores.NumeroComprobante)))+Convert(varchar,Valores.NumeroComprobante),
  0,
  DetVRC.Importe * IsNull(TiposComprobante.Coeficiente,1) * IsNull(Valores.CotizacionMoneda,1) * -1
 FROM DetalleValoresRubrosContables DetVRC
 LEFT OUTER JOIN Valores ON DetVRC.IdValor=Valores.IdValor
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN RubrosContables ON DetVRC.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
-- WHERE IsNull(RubrosContables.IngresoEgreso,'E')='E'

UNION ALL

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else 'SIN OBRA' End,
  '2.EGRESOS',
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  PlazosFijos.FechaInicioPlazoFijo,
  Year(PlazosFijos.FechaInicioPlazoFijo),
  Case 	When Month(PlazosFijos.FechaInicioPlazoFijo)=1 Then '01 Enero'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=2 Then '02 Febrero'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=3 Then '03 Marzo'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=4 Then '04 Abril'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=5 Then '05 Mayo'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=6 Then '06 Junio'	When Month(PlazosFijos.FechaInicioPlazoFijo)=7 Then '07 Julio'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=8 Then '08 Agosto'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=9 Then '09 Setiembre'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=10 Then '10 Octubre'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=11 Then '11 Noviembre'
	When Month(PlazosFijos.FechaInicioPlazoFijo)=12 Then '12 Diciembre'
	ELSE 'Error'
  End,
  'Semana '+  
  Convert(varchar,Case When (Day(PlazosFijos.FechaInicioPlazoFijo)-1)/7+1<5 Then (Day(PlazosFijos.FechaInicioPlazoFijo)-1)/7+1 Else 4 End),
  'PF '+Substring('0000000000',1,10-Len(Convert(varchar,PlazosFijos.NumeroCertificado1)))+Convert(varchar,PlazosFijos.NumeroCertificado1),
  0,
  Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) * -1
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
 WHERE IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='E'

UNION ALL

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else 'SIN OBRA' End,
  '1.INGRESOS',
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  PlazosFijos.FechaVencimiento,
  Year(PlazosFijos.FechaVencimiento),
  Case 	When Month(PlazosFijos.FechaVencimiento)=1 Then '01 Enero'
	When Month(PlazosFijos.FechaVencimiento)=2 Then '02 Febrero'
	When Month(PlazosFijos.FechaVencimiento)=3 Then '03 Marzo'
	When Month(PlazosFijos.FechaVencimiento)=4 Then '04 Abril'
	When Month(PlazosFijos.FechaVencimiento)=5 Then '05 Mayo'
	When Month(PlazosFijos.FechaVencimiento)=6 Then '06 Junio'
	When Month(PlazosFijos.FechaVencimiento)=7 Then '07 Julio'
	When Month(PlazosFijos.FechaVencimiento)=8 Then '08 Agosto'
	When Month(PlazosFijos.FechaVencimiento)=9 Then '09 Setiembre'
	When Month(PlazosFijos.FechaVencimiento)=10 Then '10 Octubre'
	When Month(PlazosFijos.FechaVencimiento)=11 Then '11 Noviembre'
	When Month(PlazosFijos.FechaVencimiento)=12 Then '12 Diciembre'
	ELSE 'Error'
  End,
  'Semana '+  
  Convert(varchar,Case When (Day(PlazosFijos.FechaVencimiento)-1)/7+1<5 Then (Day(PlazosFijos.FechaVencimiento)-1)/7+1 Else 4 End),
  'PF '+Substring('0000000000',1,10-Len(Convert(varchar,PlazosFijos.NumeroCertificado1)))+Convert(varchar,PlazosFijos.NumeroCertificado1),
  0,
  Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1) 
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
 WHERE IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='I'

UNION ALL

 SELECT 
  Case When Obras.NumeroObra is not null Then Obras.NumeroObra Else 'SIN OBRA' End,
  Case When RubrosContables.IngresoEgreso is null or RubrosContables.IngresoEgreso='E' Then '2.EGRESOS' Else '1.INGRESOS' End,
  Case When RubrosContables.Descripcion is not null Then RubrosContables.Descripcion Else 'SIN RUBRO' End,
  Convert(datetime,Convert(varchar,(PF.Semana-1)*7+1)+'/'+Convert(varchar,PF.Mes)+'/'+Convert(varchar,PF.Año),103),
  PF.Año,
  Case 	When PF.Mes=1 Then '01 Enero'
	When PF.Mes=2 Then '02 Febrero'
	When PF.Mes=3 Then '03 Marzo'
	When PF.Mes=4 Then '04 Abril'
	When PF.Mes=5 Then '05 Mayo'
	When PF.Mes=6 Then '06 Junio'
	When PF.Mes=7 Then '07 Julio'
	When PF.Mes=8 Then '08 Agosto'
	When PF.Mes=9 Then '09 Setiembre'
	When PF.Mes=10 Then '10 Octubre'
	When PF.Mes=11 Then '11 Noviembre'
	When PF.Mes=12 Then '12 Diciembre'
	ELSE 'Error'
  End,
  'Semana '+Convert(varchar,PF.Semana),
  'PRESUPUESTADO',
  Case When IsNull(RubrosContables.IngresoEgreso,'E')='E' Then PF.PresupuestoEgresos * -1 Else PF.PresupuestoIngresos End,
  0
 FROM PresupuestoFinanciero PF
 LEFT OUTER JOIN RubrosContables ON PF.IdRubroContable=RubrosContables.IdRubroContable
 LEFT OUTER JOIN Obras ON RubrosContables.IdObra=Obras.IdObra
 WHERE IsNull(PF.Tipo,'M')='M'

 DELETE FROM _TempCuboPresupuestoFinanciero
 WHERE ImporteTeorico=0 and ImporteReal=0

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5

SET NOCOUNT OFF