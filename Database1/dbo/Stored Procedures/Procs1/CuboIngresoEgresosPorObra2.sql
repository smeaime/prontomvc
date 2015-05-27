CREATE PROCEDURE [dbo].[CuboIngresoEgresosPorObra2]

@FechaDesde datetime,
@FechaHasta datetime,
@IdObra int,
@Dts varchar(200)

AS

SET NOCOUNT ON

DECLARE @IdRubroAnticipos int, @IdRubroDevolucionAnticipos int, @ModeloContableSinApertura varchar(2), @Modelo varchar(2), 
	@IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, 
	@IdTipoComprobanteNotaCredito int, @IdTipoComprobanteRecibo int, @IdTipoComprobanteOrdenPago int

SET @IdRubroAnticipos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdRubroAnticipos'),-1)
SET @IdRubroDevolucionAnticipos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdRubroDevolucionAnticipos'),-1)
SET @ModeloContableSinApertura=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ModeloContableSinApertura'),'NO')
SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)
SET @IdTipoComprobanteOrdenPago=(Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1)
SET @Modelo=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Modelo informe cubo de ingresos y egresos por obra'),'01')

CREATE TABLE #Auxiliar0	
			(
			 Tipo VARCHAR(30),
			 UnidadOperativa VARCHAR(50),
			 Obra VARCHAR(100),
			 RubroContable VARCHAR(50),
			 Detalle VARCHAR(100),
			 Importe NUMERIC(18,2),
			 Grupo VARCHAR(50),
			 Entidad VARCHAR(100),
			 NumeroObra VARCHAR(13)
			)

INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  uo.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',
  '['+Convert(varchar,Asientos.FechaAsiento,112)+'] '+Convert(varchar,Asientos.FechaAsiento,103)+' AS '+
	Substring('00000000',1,8-Len(Convert(varchar,Asientos.NumeroAsiento)))+Convert(varchar,Asientos.NumeroAsiento)+' '+IsNull(Asientos.Concepto,''),
  IsNull(DetAsi.Haber,0)-IsNull(DetAsi.Debe,0),
  IsNull(GruposObras.Descripcion,'S/D'),
  '',
  IsNull(Obras.NumeroObra,'')
 FROM DetalleAsientos DetAsi 
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento=Asientos.IdAsiento
 LEFT OUTER JOIN Cuentas ON DetAsi.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 LEFT OUTER JOIN Obras ON Cuentas.IdObra=Obras.IdObra
 LEFT OUTER JOIN UnidadesOperativas uo ON Obras.IdUnidadOperativa = uo.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (Asientos.FechaAsiento between @FechaDesde and @FechaHasta) and 
	Asientos.IdCuentaSubdiario is null and (@IdObra=-1 or IsNull(Cuentas.IdObra,0)=@IdObra) and 
	Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4' and IsNull(Cuentas.IdObra,0)<>0 and Substring(IsNull(Asientos.Tipo,''),1,3)<>'CIE' and Substring(IsNull(Asientos.Tipo,''),1,3)<>'APE'


INSERT INTO #Auxiliar0 
 SELECT 
  '1.INGRESOS',
  UnidadesOperativas.Descripcion,
  IsNull(Obras.NumeroObra,' NO IMPUTABLE'),
  'VENTAS',
  Substring('['+Convert(varchar,Subdiarios.FechaComprobante,112)+'] '+Convert(varchar,Subdiarios.FechaComprobante,103)+' '+TiposComprobante.Descripcion+' '+
		Substring('0000000000',1,10-Len(Convert(varchar,Subdiarios.NumeroComprobante)))+Convert(varchar,Subdiarios.NumeroComprobante),1,100),
  Case 	When Subdiarios.Debe is not null and Subdiarios.Haber is null Then Subdiarios.Debe * -1
	When Subdiarios.Debe is null and Subdiarios.Haber is not null Then Subdiarios.Haber
	When Subdiarios.Debe is not null and Subdiarios.Haber is not null Then Subdiarios.Haber - Subdiarios.Debe
	Else 0
  End,
  IsNull(GruposObras.Descripcion,'S/D'),
  '',
  IsNull(Obras.NumeroObra,'')
 FROM Subdiarios 
 LEFT OUTER JOIN Cuentas ON Subdiarios.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN TiposComprobante ON Subdiarios.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Subdiarios.IdComprobante and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteFacturaVenta and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteDevoluciones and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaDebito and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteNotaCredito and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteRecibo and 
						Subdiarios.IdTipoComprobante<>@IdTipoComprobanteOrdenPago and 
						IsNull(TiposComprobante.Agrupacion1,' ')='PROVEEDORES'
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteRecibo
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=Subdiarios.IdComprobante and Subdiarios.IdTipoComprobante=@IdTipoComprobanteOrdenPago
 LEFT OUTER JOIN Valores ON Valores.IdValor=Subdiarios.IdComprobante and IsNull(TiposComprobante.Agrupacion1,'')='GASTOSBANCOS'
 LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull(Cuentas.IdObra,IsNull(Facturas.IdObra,IsNull(Devoluciones.IdObra,IsNull(NotasDebito.IdObra,IsNull(NotasCredito.IdObra,IsNull(Recibos.IdObra,IsNull(OrdenesPago.IdObra,IsNull(Valores.IdObra,0))))))))
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=IsNull(CuentasGastos.IdRubroContable,Cuentas.IdRubroContable)
 LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
 LEFT OUTER JOIN GruposObras ON Obras.IdGrupoObra = GruposObras.IdGrupoObra
 WHERE (Subdiarios.FechaComprobante between @FechaDesde and @FechaHasta) and 
	(@IdObra=-1 or IsNull(Cuentas.IdObra,0)=@IdObra) and 
	Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4' and IsNull(Cuentas.IdObra,0)<>0 


CREATE TABLE #Auxiliar1 
			(
			 Obra VARCHAR(100),
			 ImporteIngresos NUMERIC(18,2),
			 ImporteEgresos NUMERIC(18,2),
			 Saldo NUMERIC(18,2),
			 ResultadoIngresos NUMERIC(18,2),
			 ResultadoEgresos NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT Obras.NumeroObra, IsNull(#Auxiliar0.Importe,0), 0, 0, 0, 0
 FROM #Auxiliar0
 LEFT OUTER JOIN Obras ON Obras.NumeroObra COLLATE SQL_Latin1_General_CP1_CI_AS=#Auxiliar0.NumeroObra

INSERT INTO #Auxiliar1 
 SELECT Obra, 0, IsNull(Importe,0), 0, 0, 0
 FROM _TempCuboIngresoEgresosPorObra 
 WHERE Tipo<>'1.INGRESOS'

CREATE TABLE #Auxiliar2 
			(
			 Obra VARCHAR(100),
			 ImporteIngresos NUMERIC(18,2),
			 ImporteEgresos NUMERIC(18,2),
			 Saldo NUMERIC(18,2),
			 ResultadoIngresos NUMERIC(18,2),
			 ResultadoEgresos NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT Obra, Sum(IsNull(ImporteIngresos,0)), Sum(IsNull(ImporteEgresos,0)), 0, 0, 0
 FROM #Auxiliar1
 GROUP BY Obra

UPDATE #Auxiliar2
SET Saldo=IsNull(ImporteIngresos,0)+IsNull(ImporteEgresos,0)

UPDATE #Auxiliar2
SET ResultadoIngresos=Case When ImporteIngresos<>0 Then Saldo/ImporteIngresos*100 Else 0 End, 
	ResultadoEgresos=Case When ImporteEgresos<>0 Then Saldo/Abs(ImporteEgresos)*100 Else 0 End

DELETE _TempCuboIngresoEgresosPorObra WHERE Tipo='1.INGRESOS'

INSERT INTO _TempCuboIngresoEgresosPorObra 
 SELECT Tipo, UnidadOperativa, Obra, RubroContable, Detalle, Importe, Grupo, Entidad
 FROM #Auxiliar0
 ORDER BY Tipo, UnidadOperativa, Obra, RubroContable, Detalle

UPDATE _TempCuboIngresoEgresosPorObra
SET Obra=IsNull(Obra,'')+
	' - % ingresos '+Convert(varchar,IsNull((Select Top 1 A.ResultadoIngresos From #Auxiliar2 A Where A.Obra=_TempCuboIngresoEgresosPorObra.Obra),0))+'%'+
	' - % egresos '+Convert(varchar,IsNull((Select Top 1 A.ResultadoEgresos From #Auxiliar2 A Where A.Obra=_TempCuboIngresoEgresosPorObra.Obra),0))+'%'
	
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2

DECLARE @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT OFF